import 'package:flutter/material.dart';
import '../data.dart';
import '../src/widgets/cool_swiper.dart';
import '../widgets/card_content.dart';

class MangaNews extends StatefulWidget {
  const MangaNews({super.key});

  @override
  State<MangaNews> createState() => _MangaNewsState();
}

class _MangaNewsState extends State<MangaNews> {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CoolSwiper(
            children: List.generate(
              Data.colors.length,
              (index) => CardContent(color: Data.colors[index]),
            ),
          ),
        ),
      ),
    );
  }
}
