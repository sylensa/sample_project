// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

List<HistoryModel> historyModelFromJson(String str) => List<HistoryModel>.from(json.decode(str).map((x) => HistoryModel.fromJson(x)));

String historyModelToJson(List<HistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryModel {
  int? id;
  String? title;
  DateTime? eventDateUtc;
  int? eventDateUnix;
  int? flightNumber;
  String? details;
  Links? links;

  HistoryModel({
    this.id,
    this.title,
    this.eventDateUtc,
    this.eventDateUnix,
    this.flightNumber,
    this.details,
    this.links,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    id: json["id"],
    title: json["title"],
    eventDateUtc: json["event_date_utc"] == null ? null : DateTime.parse(json["event_date_utc"]),
    eventDateUnix: json["event_date_unix"],
    flightNumber: json["flight_number"],
    details: json["details"],
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "event_date_utc": eventDateUtc?.toIso8601String(),
    "event_date_unix": eventDateUnix,
    "flight_number": flightNumber,
    "details": details,
    "links": links?.toJson(),
  };
}

class Links {
  String? reddit;
  String? article;
  String? wikipedia;

  Links({
    this.reddit,
    this.article,
    this.wikipedia,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    reddit: json["reddit"],
    article: json["article"],
    wikipedia: json["wikipedia"],
  );

  Map<String, dynamic> toJson() => {
    "reddit": reddit,
    "article": article,
    "wikipedia": wikipedia,
  };
}
