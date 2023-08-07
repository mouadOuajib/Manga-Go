import 'package:flutter/material.dart';

import 'hidden_drawer.dart';

void main() {
  runApp(const MangaGo());
}

class MangaGo extends StatelessWidget {
  const MangaGo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HiddenDrawer(),
    );
  }
}
