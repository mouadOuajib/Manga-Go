import 'dart:developer';

import 'package:http/http.dart' as http;

class HttpService {
  static Future<String?> getHtml() async {
    try {
      final response = await http.get(Uri.parse(
          "https://ww6.manganelo.tv/chapter/manga-aa951409/chapter-1084"));
      log(response.statusCode.toString());
      if (response.statusCode == 200) return response.body;
    } catch (e) {
      log("HttpService : $e");
    }
    return null;
  }
}
