import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mangago/datascraper/manga_scraper.dart';
import 'package:mangago/widgets/manga_card.dart';

import '../models/manga.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final mangaScraper = MangaScraper();
  var endPoint = "https://ww6.manganelo.tv/genre?type=topview";
  var userIsSearching = false;

  final TextEditingController _textEditingController = TextEditingController();
  String enteredText = '';

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.primary,
      appBar: AppBar(
        backgroundColor: theme.primary,
        actions: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.primary,
              ),
              child: Row(
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      cursorColor: theme.onBackground,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        setState(() {
                          enteredText = text;
                        });
                      },
                      onSubmitted: (text) {
                        setState(() {
                          enteredText = text;
                          endPoint = "https://ww6.manganelo.tv/search/$text";
                          log(endPoint);
                          userIsSearching = true;
                          log(text);
                          log(userIsSearching.toString());
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: FutureBuilder(
          future: userIsSearching
              ? mangaScraper.fetchSearchList(endPoint)
              : mangaScraper.latestManga(endPoint),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Manga> mangas = snapshot.data as List<Manga>;
              return SizedBox(
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
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              mangas[index].coverImageUrl!),
                                          fit: BoxFit.cover)),
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
                            )),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
