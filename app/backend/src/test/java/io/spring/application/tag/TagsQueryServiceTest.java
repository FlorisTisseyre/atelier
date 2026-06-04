package io.spring.application.tag;

import static org.assertj.core.api.Assertions.assertThat;

import io.spring.application.TagsQueryService;
import io.spring.core.article.Article;
import io.spring.core.article.ArticleRepository;
import io.spring.infrastructure.DbTestBase;
import io.spring.infrastructure.repository.MyBatisArticleRepository;
import java.util.Arrays;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;

@Import({TagsQueryService.class, MyBatisArticleRepository.class})
public class TagsQueryServiceTest extends DbTestBase {
  @Autowired private TagsQueryService tagsQueryService;
  @Autowired private ArticleRepository articleRepository;

  @Test
  void should_get_all_tags_after_article_published() {
    articleRepository.save(new Article("test", "desc", "body", Arrays.asList("java"), "123"));
    assertThat(tagsQueryService.allTags()).contains("java");
  }

  @Test
  void should_reflect_new_tags_without_prior_query() {
    assertThat(tagsQueryService.allTags()).isEmpty();
    articleRepository.save(new Article("test2", "desc", "body", Arrays.asList("python"), "123"));
    assertThat(tagsQueryService.allTags()).contains("python");
  }
}
