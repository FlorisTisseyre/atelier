#!/usr/bin/env bash
#
# Prepare l'atelier : installe les deps du front et verifie que le back compile.
# Les sources des deux apps sont deja dans le repo (vendorisees), il n'y a donc
# plus rien a cloner ni a patcher : le front pointe deja sur localhost:8080 et
# 'npm start' embarque le flag OpenSSL legacy + le port 4100.
#
# Le back tourne en Java 21 (Spring Boot 3.2, Gradle 8.7). Si le java par defaut
# n'est pas un 21, ce script en cherche un (java_home / sdkman) pour la build.
#
# Usage : ./install.sh
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACK="$ROOT/app/spring-boot-realworld-example-app"
FRONT="$ROOT/app/react-redux-realworld-example-app"

info(){ printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok(){   printf '\033[1;32m ok\033[0m %s\n' "$*"; }
warn(){ printf '\033[1;33m !!\033[0m %s\n' "$*"; }
die(){  printf '\033[1;31m xx\033[0m %s\n' "$*" >&2; exit 1; }

need(){ command -v "$1" >/dev/null 2>&1 || die "Outil manquant : $1"; }

# Major version d'un binaire java (8, 17, 21...). Vide si introuvable.
jver(){
  local b="$1" v
  [ -x "$b" ] || return 1
  v="$("$b" -version 2>&1 | head -1 | grep -oE '"[0-9._]+"' | tr -d '"')" || return 1
  case "$v" in 1.*) echo "${v#1.}" | cut -d. -f1 ;; *) echo "$v" | cut -d. -f1 ;; esac
}

# Home d'un JDK 21. Vide si le java par defaut est deja un 21 (rien a exporter),
# ou si aucun 21 n'est trouve.
find_java21(){
  local h d
  [ "$(jver "$(command -v java 2>/dev/null)" || echo 0)" = 21 ] && return 0
  if [ -n "${JAVA_HOME:-}" ] && [ "$(jver "$JAVA_HOME/bin/java" || echo 0)" = 21 ]; then
    echo "$JAVA_HOME"; return 0
  fi
  if [ -x /usr/libexec/java_home ]; then
    h="$(/usr/libexec/java_home -v 21 2>/dev/null || true)"
    [ -n "$h" ] && [ "$(jver "$h/bin/java" || echo 0)" = 21 ] && { echo "$h"; return 0; }
  fi
  if [ -d "$HOME/.sdkman/candidates/java" ]; then
    for d in "$HOME/.sdkman/candidates/java"/*/; do
      case "$d" in */current/) continue ;; esac
      [ "$(jver "${d}bin/java" || echo 0)" = 21 ] && { echo "${d%/}"; return 0; }
    done
  fi
  return 1
}

# --- Pre-checks ---------------------------------------------------------------
info "Pre-checks"
need node; need npm
ok "node ($(node -v)) / npm presents"

DEF_JMAJ="$(jver "$(command -v java 2>/dev/null)" || echo 0)"
JDK21="$(find_java21 || true)"
if [ "$DEF_JMAJ" = 21 ]; then
  ok "Java 21 par defaut"
elif [ -n "$JDK21" ]; then
  ok "Java 21 trouve pour la build : $JDK21"
else
  warn "Aucun Java 21 trouve. Installe Temurin 21, ex : sdk install java 21.0.3-tem"
fi

# --- Front : deps -------------------------------------------------------------
info "Install deps front (npm install)"
( cd "$FRONT" && npm install )
ok "deps front installees"

# --- Back : verif compilation -------------------------------------------------
info "Verif compilation back (gradlew assemble)"
chmod +x "$BACK/gradlew" || true
if [ "$DEF_JMAJ" = 21 ]; then
  ( cd "$BACK" && ./gradlew assemble )
  ok "back compile"
elif [ -n "$JDK21" ]; then
  ( cd "$BACK" && JAVA_HOME="$JDK21" PATH="$JDK21/bin:$PATH" ./gradlew assemble )
  ok "back compile"
else
  warn "Pre-build back saute (pas de Java 21)."
fi

# --- Done ---------------------------------------------------------------------
BOOT_PREFIX=""
[ "$DEF_JMAJ" != 21 ] && [ -n "$JDK21" ] && BOOT_PREFIX="JAVA_HOME=\"$JDK21\" "

cat <<EOF

=== Pret ===

Back (onglet 1) :
    cd app/spring-boot-realworld-example-app
    ${BOOT_PREFIX}./gradlew bootRun
    -> http://localhost:8080/tags doit renvoyer du JSON

Front (onglet 2) :
    cd app/react-redux-realworld-example-app && npm start
    -> http://localhost:4100

EOF
