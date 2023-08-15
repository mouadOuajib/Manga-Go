import 'dart:developer';

import 'package:beautiful_soup_dart/beautiful_soup.dart';

class ScrapingService {
  static List<String> getImages(String html) {
    try {
      final soup = BeautifulSoup(html);
      final container = soup.find('div', class_: 'container-chapter-reader');
      log("111");
      if (container != null) {
        log("222");
        final items = container.findAll('img', class_: 'img-loading');
        final List<String> imageUrls = [];
        log("333");
        for (var item in items) {
          final imageUrl = item.attributes['src'];
          log("444");
          log(imageUrl.toString());
          if (imageUrl != null) {
            log(imageUrl.toString());
            imageUrls.add(imageUrl);
          }
        }

        return imageUrls;
      } else {
        log("Container not found.");
        return [];
      }
    } catch (e) {
      log("ScrapingService: $e");
      return [];
    }
  }
}
