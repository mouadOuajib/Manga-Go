class Manga {
  String? title;
  String? description;
  String? coverImageUrl;
  String? chapterDateOfRelease;
  int? numberOfChapters;
  String? mangaLink;
  String? rating;
  String? lastChapter;
  String? lastChapterLink;
  bool? chapterIsNew;
  String? story;
  List<String>? genres;
  String? status;
  List<Map<String, String>>? chaptersMap;
  List<String>? chapterImages;
  String? alternative;
  String? author;
  String? dateOfUpdate;
  int? numberOfVotes;
  String? views;
  Manga(
      {this.title,
      this.coverImageUrl,
      this.chapterDateOfRelease,
      this.numberOfChapters,
      this.description,
      this.mangaLink,
      this.rating,
      this.lastChapter,
      this.lastChapterLink,
      this.genres,
      this.status,
      this.story,
      this.chaptersMap,
      this.chapterImages,
      this.chapterIsNew = false,
      this.alternative,
      this.author,
      this.dateOfUpdate,
      this.numberOfVotes,
      this.views});
}
