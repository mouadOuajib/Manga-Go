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
  String? state;
  List<String>? listOfChapters;
  List<String>? chapterImages;
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
      this.state,
      this.story,
      this.listOfChapters,
      this.chapterImages,
      this.chapterIsNew = false});
}
