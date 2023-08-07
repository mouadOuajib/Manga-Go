import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:mangago/screens/home_screen.dart';
import 'package:mangago/screens/latest_manga_screen.dart';
import 'package:mangago/screens/manga_news_screen.dart';
import 'package:mangago/screens/newest_manga_screen.dart';
import 'package:mangago/screens/profile_screen.dart';
import 'package:mangago/screens/search_screen.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  final textStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white);
  final selectedTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black);
  @override
  void initState() {
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Home Page",
              baseStyle: textStyle,
              selectedStyle: selectedTextStyle),
          const HomeScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "search Page",
              baseStyle: textStyle,
              selectedStyle: selectedTextStyle),
          const SearchScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Manga News",
              baseStyle: textStyle,
              selectedStyle: selectedTextStyle),
          const MangaNews()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Latest Manga",
              baseStyle: textStyle,
              selectedStyle: selectedTextStyle),
          const LatestManga()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Newest Manga",
              baseStyle: textStyle,
              selectedStyle: selectedTextStyle),
          const NewestMangas()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Profil",
              baseStyle: textStyle,
              selectedStyle: selectedTextStyle),
          const ProfileScreen())
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return HiddenDrawerMenu(
      backgroundColorMenu: theme.primary,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 40,
    );
  }
}
