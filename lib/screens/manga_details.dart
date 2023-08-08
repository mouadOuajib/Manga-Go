import 'dart:developer';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangago/datascraper/manga_scraper.dart';
// import 'package:mangago/screens/read_manga.dart';
import '../models/manga.dart';

class MangaDetails extends StatefulWidget {
  final String mangaLink;
  final String nameOfTheManga;
  const MangaDetails(
      {Key? key, required this.nameOfTheManga, required this.mangaLink})
      : super(key: key);

  @override
  State<MangaDetails> createState() => _MangaDetailsState();
}

class _MangaDetailsState extends State<MangaDetails> {
  MangaScraper mangaScraper = MangaScraper();
  // late String endPoint;
  late Future<Manga> getManga;

  @override
  void initState() {
    getManga = mangaScraper.fetchMangaInfo(widget.mangaLink);
    // getEndPoint(widget.nameOfTheManga);
    super.initState();
  }

  // String getEndPoint(String title) {
  //   String newTitle = title.toLowerCase().replaceAll(' ', '-');
  //   endPoint = "manga/$newTitle/";
  //   log(endPoint);
  //   return endPoint;
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.secondary,
        title: const Text("details"),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: FutureBuilder(
              future: getManga,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return Text('Error: ${snapshot.error} gjsljdg');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final manga = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      manga.title ?? "",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 160,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.amber
                              // image: DecorationImage(
                              //     image:
                              //         NetworkImage(manga.coverImageUrl ?? ""),
                              //     fit: BoxFit.cover),
                              ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              ": الحالة",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Text(
                              manga.status ?? "",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text(
                              ": التصنيف",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            SizedBox(
                              width: 200, // Adjust the width as needed
                              child: Text(manga.genres.toString() ?? "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl),
                            ),
                            Text(": التقييم",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                textDirection: TextDirection.rtl),
                            SizedBox(
                              width: 200, // Adjust the width as needed
                              child: Text(
                                "${manga.rating ?? ""}/5.0 ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ": القصة",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        SizedBox(
                          width: double.maxFinite, // Adjust the width as needed
                          child: Text(
                            """${manga.story ?? ""}""",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          color: theme.primary,
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height - 100,
                          child: ContainedTabBarView(
                            tabs: const [
                              Text(
                                'chapters',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'comments',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                            views: [
                              ListView.builder(
                                itemCount: manga.chaptersMap!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final chapter = manga.chaptersMap![index];
                                  if (chapter.isNotEmpty) {
                                    return InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) {
                                        //     log(manga.mangaLink.toString());
                                        //     return ReadManga(
                                        //         mangaChapter: chapter,
                                        //         mangaLink: widget.mangaLink);
                                        //   }),
                                        // );
                                      },
                                      child: ListTile(
                                        title: Text("chapter $chapter"),
                                        trailing: InkWell(
                                            onTap: () {
                                              // _downloadChapter(widget.mangaLink + chapter, manga.title);
                                            },
                                            child: const Icon(Icons.download)),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              Container(color: Colors.green)
                            ],
                            onChange: (index) => log(index.toString()),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
