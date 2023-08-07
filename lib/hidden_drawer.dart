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
  @override
  void initState() {
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Home Page",
              baseStyle: const TextStyle(),
              selectedStyle: const TextStyle()),
          const HomeScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "search Page",
              baseStyle: const TextStyle(),
              selectedStyle: const TextStyle()),
          const SearchScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Manga News",
              baseStyle: const TextStyle(),
              selectedStyle: const TextStyle()),
          const MangaNews()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Latest Manga",
              baseStyle: const TextStyle(),
              selectedStyle: const TextStyle()),
          const LatestManga()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Newest Manga",
              baseStyle: const TextStyle(),
              selectedStyle: const TextStyle()),
          const NewestMangas()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Profil",
              baseStyle: const TextStyle(),
              selectedStyle: const TextStyle()),
          const ProfileScreen())
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.purple,
      screens: _pages,
      initPositionSelected: 0,
    );
  }
}
