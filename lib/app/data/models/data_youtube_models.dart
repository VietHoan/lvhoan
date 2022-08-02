// To parse this JSON data, do
//
//     final dataYoutube = dataYoutubeFromJson(jsonString);

import 'dart:convert';

Map<String, DataYoutube> dataYoutubeFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) => MapEntry<String, DataYoutube>(k, DataYoutube.fromJson(v)));

String dataYoutubeToJson(Map<String, DataYoutube> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class DataYoutube {
  DataYoutube({
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

  factory DataYoutube.fromJson(Map<String, dynamic> json) => DataYoutube(
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
