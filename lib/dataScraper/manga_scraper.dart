import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:mangago/models/manga.dart';

class MangaScraper {
  final String baseUrl = "https://ww6.manganelo.tv";

  //fetch search manga list
  Future<List<Manga>> fetchSearchList(String url) async {
    List<Manga> mangas = [];

    final response =
        await http.get(Uri.parse("https://ww6.manganelo.tv/search/attack"));
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      final mangaItems =
          document.querySelectorAll('.panel-search-story .search-story-item');

      for (var mangaItem in mangaItems) {
        final imgElement = mangaItem.querySelector('.item-img img');
        final imageUrl = imgElement?.attributes['src'] ?? '';

        final titleElement = mangaItem.querySelector('.item-title');
        final title = titleElement?.text.trim() ?? '';

        final mangaUrl = titleElement?.attributes['href'] ?? '';

        final finalChapterElement = mangaItem.querySelector('.item-chapter');
        final finalChapter = finalChapterElement?.text.trim() ?? '';

        mangas.add(Manga(
          coverImageUrl: "https://ww6.manganelo.tv$imageUrl",
          title: title,
          mangaLink: mangaUrl,
          lastChapter: finalChapter,
        ));
      }
    }

    return mangas;
  }

  //fetch latest manga
  Future<List<Manga>> latestManga(String url) async {
    List<Manga> mangas = [];

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      final mangaItems = document.querySelectorAll('.content-genres-item');

      for (var mangaItem in mangaItems) {
        final imgElement = mangaItem.querySelector('.genres-item-img img');
        final imageUrl = imgElement?.attributes['src'] ?? '';

        final titleElement = mangaItem.querySelector('.genres-item-name');
        final title = titleElement?.text.trim() ?? '';

        final mangaUrl = titleElement?.attributes['href'] ?? '';

        final ratingElement = mangaItem.querySelector('.genres-item-rate');
        final rating = ratingElement?.text.trim() ?? '';

        final lastChapterElement = mangaItem.querySelector('.genres-item-chap');
        final lastChapter = lastChapterElement?.text.trim() ?? '';
        final lastChapterUrl = lastChapterElement?.attributes['href'] ?? '';

        mangas.add(Manga(
          coverImageUrl: "https://ww6.manganelo.tv$imageUrl",
          title: title,
          mangaLink: mangaUrl,
          rating: rating,
          lastChapter: lastChapter,
          lastChapterLink: lastChapterUrl,
        ));
      }
    }

    return mangas;
  }
}
