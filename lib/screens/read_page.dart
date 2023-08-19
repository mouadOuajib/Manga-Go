import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangago/dataScraper/manga_scraper.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/services.dart';

class ReadPage extends StatefulWidget {
  final String chapterTitle;
  final String mangaLink;
  const ReadPage(
      {Key? key, required this.chapterTitle, required this.mangaLink})
      : super(key: key);

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  late Future<List<String>> getManga;
  bool _isAppBarVisible = true;
  bool _isHorizontalMode = true;
  bool loading = false;
  final ItemScrollController _itemScrollController = ItemScrollController();
  final PageController _pageController = PageController();

  @override
  void initState() {
    getManga = MangaScraper.fetchImageUrls(widget.mangaLink);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _toggleAppBarVisibility() {
    setState(() {
      _isAppBarVisible = !_isAppBarVisible;
    });
  }

  void _toggleReadingMode() {
    setState(() {
      _isHorizontalMode = !_isHorizontalMode;
    });
  }

  Widget _buildAppBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _isAppBarVisible ? kToolbarHeight : 0,
      child: AppBar(
        title: Text(
          widget.chapterTitle,
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          InkWell(
            onTap: _toggleReadingMode,
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0.5),
                    shape: BoxShape.circle,
                    color: Colors.transparent),
                height: 30,
                width: 30,
                child: _isHorizontalMode
                    ? const Center(child: Icon(Icons.horizontal_distribute))
                    : const Center(child: Icon(Icons.vertical_align_bottom)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMangaPage(int pageIndex, List images) {
    final imageUrl = images[pageIndex];

    if (_isHorizontalMode) {
      return Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: InteractiveViewer(
            minScale: 1.0,
            maxScale: _calculateMaxScale(imageUrl),
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    } else {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
      );
    }
  }

  double _calculateMaxScale(String imageUrl) {
    final double imageWidth = MediaQuery.of(context).size.width;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double maxScale = deviceWidth / imageWidth;
    return maxScale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _toggleAppBarVisibility,
        child: Stack(
          children: [
            FutureBuilder(
              future: getManga,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return Text('Error: ${snapshot.error} gjsljdg');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final manga = snapshot.data as List<String>;
                  return _isHorizontalMode
                      ? PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: manga.length,
                          itemBuilder: (context, index) {
                            return _buildMangaPage(index, manga);
                          },
                        )
                      : ScrollablePositionedList.builder(
                          itemScrollController: _itemScrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: manga.length,
                          itemBuilder: (context, index) {
                            log(manga.toString());
                            return _buildMangaPage(index, manga);
                          },
                        );
                }
              },
            ),
            _buildAppBar(),
          ],
        ),
      ),
    );
  }
}
