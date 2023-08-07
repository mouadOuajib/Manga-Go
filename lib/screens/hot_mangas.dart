import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../dataScraper/manga_scraper.dart';
import '../models/manga.dart';

class HotMangas extends StatefulWidget {
  const HotMangas({Key? key}) : super(key: key);

  @override
  State<HotMangas> createState() => _HotMangasState();
}

class _HotMangasState extends State<HotMangas> {
  late Future<List<Manga>> getManga;
  final mangaScrapper = MangaScraper();
  late String endPoint;
  int pageIndex = 1;

  @override
  void initState() {
    endPoint = "https://ww6.manganelo.tv/genre?type=topview&page=$pageIndex";
    super.initState();
  }

  Future<List<Manga>> getMangas(String endPoint) {
    getManga = mangaScrapper.latestManga(endPoint);
    return getManga;
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: const Color(0xfffff0e0),
      body: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Column(
          children: [
            FutureBuilder(
              future: getMangas(endPoint),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final mangas = snapshot.data as List<Manga>;
                  return Expanded(
                      flex: 11,
                      child: SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: AnimationLimiter(
                          child: GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: (100 / 180),
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            children: List.generate(
                              mangas.length,
                              (int index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  columnCount: 3,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  mangas[index].coverImageUrl!,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            mangas[index].title!,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ));
                }
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 180.w,
                  height: 40.h,
                  color: Colors.transparent,
                  child: Center(
                    child: ListView.builder(
                        itemCount: 54,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  pageIndex = index + 1;
                                  endPoint =
                                      "https://ww6.manganelo.tv/genre?page=$pageIndex";
                                });
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: pageIndex == (index + 1)
                                        ? Border.all(
                                            color: Colors.blue, width: 1)
                                        : Border.all(
                                            color: Colors.grey, width: 0.5)),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
