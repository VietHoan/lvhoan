// To parse this JSON data, do
//
//     final dataYoutube = dataYoutubeFromJson(jsonString);

import 'dart:convert';

Map<String, DataSingleClip> dataSingleClipFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) => MapEntry<String, DataSingleClip>(k, DataSingleClip.fromJson(v)));

String dataSingleClipToJson(Map<String, DataSingleClip> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

// This is response model to get link download mp3 or mp4
class DataSingleClip {
  DataSingleClip({
    this.title,
    this.result,
    this.size,
    this.thumbb,
    this.views,
    this.likes,
    this.dislike,
    this.channel,
    this.uploadDate,
    this.desc,
    this.quality,
  });

  String? title;
  String? result;
  String? size;
  String? thumbb;
  String? views;
  int? likes;
  dynamic dislike;
  String? channel;
  DateTime? uploadDate;
  String? desc;
  String? quality;

  factory DataSingleClip.fromJson(Map<String, dynamic> json) => DataSingleClip(
        title: json["title"],
        result: json["result"],
        size: json["size"],
        thumbb: json["thumbb"],
        views: json["views"],
        likes: json["likes"],
        dislike: json["dislike"],
        channel: json["channel"],
        uploadDate: DateTime.parse(json["uploadDate"]),
        desc: json["desc"],
        quality: json["quality"] == null ? null : json["quality"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "result": result,
        "size": size,
        "thumbb": thumbb,
        "views": views,
        "likes": likes,
        "dislike": dislike,
        "channel": channel,
        "uploadDate":
            "${uploadDate?.year.toString().padLeft(4, '0')}-${uploadDate?.month.toString().padLeft(2, '0')}-${uploadDate?.day.toString().padLeft(2, '0')}",
        "desc": desc,
        "quality": quality == null ? null : quality,
      };
}
