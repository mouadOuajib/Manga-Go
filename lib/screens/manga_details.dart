import 'dart:developer';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangago/datascraper/manga_scraper.dart';
import 'package:mangago/screens/read_page.dart';
import 'package:mangago/src/widgets/app_button.dart';
import '../models/manga.dart';
import '../provider/watch_later.dart';
import 'package:provider/provider.dart';

class MangaDetails extends StatefulWidget {
  final String imageUrl;
  final String mangaLink;
  final String title;
  const MangaDetails(
      {Key? key,
      required this.mangaLink,
      required this.title,
      required this.imageUrl})
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfff9bbc3),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
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
              return Stack(
                children: [
                  Container(
                    height: size.height / 2.5,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: const Color(0xfff9bbc3),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 200,
                              width: 130,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(widget.imageUrl),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 0.2,
                                      color: Colors.black,
                                      offset: Offset(0, 0),
                                    )
                                  ]),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width * 0.54,
                                  child: Text(
                                    widget.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(manga.dateOfUpdate!),
                                SizedBox(
                                  height: 10.h,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Status: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                          text: '${manga.status} ',
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Author: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                          text: '${manga.author} ',
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Views: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                          text: '${manga.views} ',
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Rating: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                          text: '${manga.rating} ',
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: theme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height,
                          child: ContainedTabBarView(
                            tabs: const [
                              Text(
                                'story',
                                style: TextStyle(color: Colors.black),
                              ),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, right: 10, left: 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Genres :",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        width: double.maxFinite,
                                        child: Text(
                                          manga.genres!.join(' \u2022 '),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Alternative: ',
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                                text: '${manga.alternative} ',
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        "Description :",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        manga.story!
                                            .substring(28, manga.story!.length),
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        "Options :",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Consumer<WatchLaterProvider>(
                                            builder: (context,
                                                watchLaterProvider, child) {
                                              return AppButton(
                                                onTap: () {
                                                  if (manga
                                                          .isAddedToWatchLater ==
                                                      false) {
                                                    watchLaterProvider
                                                        .addToWatchLater(manga);
                                                  } else {
                                                    watchLaterProvider
                                                        .removeFromWatchLater(
                                                            manga);
                                                  }
                                                  if (manga
                                                          .isAddedToWatchLater ==
                                                      true) {
                                                    manga.isAddedToWatchLater =
                                                        false;
                                                  } else {
                                                    manga.isAddedToWatchLater =
                                                        true;
                                                  }
                                                  log(manga.isAddedToWatchLater
                                                      .toString());
                                                },
                                                color: Colors.greenAccent,
                                                buttontext: manga
                                                            .isAddedToWatchLater ==
                                                        false
                                                    ? "Read Later"
                                                    : "Remove Frome Read later",
                                                width: 180.w,
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          AppButton(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return FadeTransition(
                                                      opacity: animation,
                                                      child: ReadPage(
                                                        chapterTitle:
                                                            "${manga.chaptersMap![manga.chaptersMap!.length - 1]['title']}",
                                                        mangaLink:
                                                            "${manga.chaptersMap![manga.chaptersMap!.length - 1]['chapterLink']}",
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            color: Colors.redAccent,
                                            buttontext: "Start Reading",
                                            width: 100.w,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      AppButton(
                                        buttontext: "...",
                                        color: theme.onBackground,
                                        width: 40.w,
                                        border: Border.all(
                                            color: Colors.grey, width: 0.3),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                itemCount: manga.chaptersMap!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final chapter = manga.chaptersMap![index];
                                  if (chapter.isNotEmpty) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: ReadPage(
                                                  chapterTitle:
                                                      "${chapter['title']}",
                                                  mangaLink:
                                                      "${chapter['chapterLink']}",
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: ListTile(
                                        title: SizedBox(
                                          width: double.maxFinite,
                                          child: Text(
                                            """${chapter["chapterName"]}""",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                """Views: ${chapter["views"]}"""),
                                            Text(
                                                """${chapter["uploadDate"]}"""),
                                          ],
                                        ),
                                        trailing: InkWell(
                                            onTap: () {},
                                            child: const Icon(Icons.download)),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              Container(
                                color: Colors.green,
                                child: const Center(
                                  child: Text(
                                    'Comments content goes here',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                            onChange: (index) => log(index.toString()),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
