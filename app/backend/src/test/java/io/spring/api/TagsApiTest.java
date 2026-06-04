package io.spring.api;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.hasItem;

import io.spring.core.user.User;
import io.spring.core.user.UserRepository;
import io.spring.core.article.Article;
import io.spring.core.article.ArticleRepository;
import java.util.Arrays;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
public class TagsApiTest {

  @LocalServerPort private int port;

  @Autowired private ArticleRepository articleRepository;
  @Autowired private UserRepository userRepository;

  @BeforeEach
  void setUp() {
    User user = new User("test@test.com", "testuser", "password", "", "");
    userRepository.save(user);
    articleRepository.save(
        new Article("Test Article", "desc", "body", Arrays.asList("java", "spring"), user.getId()));
  }

  @Test
  void should_return_tags_after_article_is_published() {
    given()
        .port(port)
        .when()
        .get("/tags")
        .then()
        .statusCode(200)
        .body("tags", hasItem("java"))
        .body("tags", hasItem("spring"));
  }
}
