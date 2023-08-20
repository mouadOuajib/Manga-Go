import 'package:flutter/material.dart';
import 'package:mangago/screens/read_later.dart';

class FavoriteMangaPage extends StatelessWidget {
  final List<String> listText = [
    "Read later",
    "Favorite",
    "I already read it",
    "Current reading"
  ];

  FavoriteMangaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listText.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    listText[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReadLater()));
                  },
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
