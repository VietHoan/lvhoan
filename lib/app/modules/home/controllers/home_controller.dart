import 'dart:convert';
import 'dart:developer';

import 'package:external_path/external_path.dart';
import 'package:free_music/app/data/models/data_youtube_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final String urlDownload = 'https://api.akuari.my.id/downloader/yt1?link=';
  final count = 0.obs;
  final dataYoutube = DataYoutube().obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<void> getDownloadDirectory() async {
    final response = await get(Uri.parse('https://api.akuari.my.id/downloader/yt1?link=https://youtu.be/mWOBGYP-PkM'));
    print(response.body.toString());
    Map<String, dynamic> dataJson = json.decode(response.body);
    dataYoutube.value = DataYoutube.fromJson(dataJson['mp3']);
    print(dataYoutube.value.title);
  }
}
