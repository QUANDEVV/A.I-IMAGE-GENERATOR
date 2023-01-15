// ignore_for_file: must_be_immutable


import 'dart:convert';

import 'package:get/get.dart';
import 'package:images/api/api.dart';
import 'package:images/main.dart';
import 'package:http/http.dart' as http;

class ImageController extends Images {
  var url = Uri.parse('https://api.openai.com/v1/images/generations');

  final data = ''.obs;
  final isLoading = false.obs;

  Future getImage({required String imageText, required String size}) async {
    try {
      isLoading.value = true;
      var request = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $api_token",
          },
          body: jsonEncode({"prompt": imageText, "n": 1}));
      if (request.statusCode == 200) {
        isLoading.value = false;
        data.value = jsonDecode(request.body)['data'][0]['url'];
        print(data.value);
      } else {
        isLoading.value = false;
        print(jsonDecode(request.body));
      }
    } catch (e) {
        isLoading.value = false;

      print(e.toString());
    }
  }
}
