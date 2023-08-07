import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:mangago/models/manga.dart';
import 'package:html/dom.dart';

class MangaScraper {
  final String baseUrl = "https://ww6.manganelo.tv";

  //fetch search manga list
  Future<List<Manga>> fetchSearchList(String url) async {
    List<Manga> mangas = [];

    final response = await http.get(Uri.parse(url));
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
        log(mangaUrl.toString());

        mangas.add(Manga(
          coverImageUrl: "https://ww6.manganelo.tv$imageUrl",
          title: title,
          mangaLink: "https://ww6.manganelo.tv$mangaUrl",
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
      log("1");
      final document = parser.parse(response.body);
      log("2");
      final mangaItems = document.querySelectorAll('.content-genres-item');
      log("3");
      for (var mangaItem in mangaItems) {
        log("4");
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
        log("mangaUrl$mangaUrl image=$imageUrl  title=$title");

        mangas.add(Manga(
          coverImageUrl: "https://ww6.manganelo.tv$imageUrl",
          title: title,
          mangaLink: "https://ww6.manganelo.tv$mangaUrl",
          rating: rating,
          lastChapter: lastChapter,
          lastChapterLink: lastChapterUrl,
        ));
      }
    }

    return mangas;
  }

  //fetch manga details
  Future<Manga> fetchMangaInfo(String url) async {
    final response = await http.get(Uri.parse(url));
    log("11");
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      log("22");
      String alternative =
          document.querySelector('.info-alternative h2')?.text.trim() ?? '';
      String author =
          document.querySelector('.info-author a')?.text.trim() ?? '';
      String status = document.querySelector('.info-status')?.text.trim() ?? '';

      List<String> genres = [];
      var genreLinks = document.querySelectorAll('.info-genres a');
      for (var genreLink in genreLinks) {
        genres.add(genreLink.text.trim());
      }

      String updated = document.querySelector('.info-time')?.text ?? '';
      double rating = double.tryParse(document
                  .querySelector('.info-rate em[property="v:average"]')
                  ?.text
                  .trim() ??
              '0') ??
          0;
      int votes = int.tryParse(document
                  .querySelector('.info-rate em[property="v:votes"]')
                  ?.text
                  .trim() ??
              '0') ??
          0;
      String description = document
              .querySelector('.panel-story-info-description')
              ?.text
              .trim() ??
          '';

      List<Map<String, String>> chapters = [];
      var chapterListItems =
          document.querySelectorAll('.row-content-chapter li');
      for (var chapterItem in chapterListItems) {
        String chapterName =
            chapterItem.querySelector('.chapter-name')?.text.trim() ?? '';
        String views =
            chapterItem.querySelector('.chapter-view')?.text.trim() ?? '';
        String uploadDate =
            chapterItem.querySelector('.chapter-time')?.text.trim() ?? '';
        chapters.add({
          'chapterName': chapterName,
          'views': views,
          'uploadDate': uploadDate,
        });
      }
      log("alternative=$alternative author=$author status=$status genres=$genres dateofupdate=$updated  rating=$rating numberofvotes=$votes story=$description chaptermap=$chapters");

      return Manga(
        alternative: alternative,
        author: author,
        status: status,
        genres: genres,
        dateOfUpdate: updated,
        rating: rating.toString(),
        numberOfVotes: votes,
        story: description,
        chaptersMap: chapters,
      );
    } else {
      throw Exception('Failed to fetch manga info');
    }
  }
}
