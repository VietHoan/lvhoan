import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:free_music/app/data/models/data_youtube_model.dart';
import 'package:free_music/app/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final ReceivePort port = ReceivePort();

  // Variable data from youtube api:
  final dataYoutube = DataYoutube().obs;
  final listClip = List<Item>.empty(growable: true).obs;
  late String tokenNextPage = ''; // token to load more clip
  //---------

  @override
  void onInit() {
    super.onInit();
    IsolateNameServer.registerPortWithName(port.sendPort, 'downloader_send_port');
    port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  // Future<void> getDownloadDirectory() async {
  //   var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
  //   log('path: ${path}');
  //   // final response = await get(Uri.parse('https://api.akuari.my.id/downloader/yt1?link=https://youtu.be/mWOBGYP-PkM'));
  //   // Map<String, dynamic> dataJson = json.decode(response.body);
  //   // dataYoutube.value = DataYoutube.fromJson(dataJson['mp3']);
  //   // log('$dataYoutube.value.result');
  //   final downloadId = await FlutterDownloader.enqueue(
  //     url: 'https://tinyurl.com/2y4yl2u3',
  //     savedDir: path,
  //     showNotification: true,
  //     openFileFromNotification: true,
  //     fileName: 'test.mp3',
  //   );
  //   log('${downloadId}');
  // }
  Future<void> onSearchSubmit({
    String? search,
    String? pageToken,
  }) async {
    final params = {
      'part': 'snippet',
      'channelType': 'any',
      'maxResults': '10',
      'q': search ?? '',
      'key': Constant.API_KEY,
      'pageToken': pageToken == null ? '' : pageToken,
    };
    final uri = Uri.https(
      dotenv.env['YOUTUBE_API']!,
      'youtube/v3/search',
      params,
    );
    final response = await get(uri);
    if (response.body != null) {
      dataYoutube.value = dataYoutubeFromJson(response.body);
      tokenNextPage = dataYoutube.value.nextPageToken!;
      listClip.value = dataYoutube.value.items!;
    }
  }
}
