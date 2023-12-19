// To parse this JSON data, do
//
//     final coresModel = coresModelFromJson(jsonString);

import 'dart:convert';

List<CoresModel> coresModelFromJson(String str) => List<CoresModel>.from(json.decode(str).map((x) => CoresModel.fromJson(x)));

String coresModelToJson(List<CoresModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoresModel {
  String? coreSerial;
  int? block;
  Status? status;
  DateTime? originalLaunch;
  int? originalLaunchUnix;
  List<Mission>? missions;
  int? reuseCount;
  int? rtlsAttempts;
  int? rtlsLandings;
  int? asdsAttempts;
  int? asdsLandings;
  bool? waterLanding;
  String? details;

  CoresModel({
    this.coreSerial,
    this.block,
    this.status,
    this.originalLaunch,
    this.originalLaunchUnix,
    this.missions,
    this.reuseCount,
    this.rtlsAttempts,
    this.rtlsLandings,
    this.asdsAttempts,
    this.asdsLandings,
    this.waterLanding,
    this.details,
  });

  factory CoresModel.fromJson(Map<String, dynamic> json) => CoresModel(
    coreSerial: json["core_serial"],
    block: json["block"],
    status: statusValues.map[json["status"]],
    originalLaunch: json["original_launch"] == null ? null : DateTime.parse(json["original_launch"]),
    originalLaunchUnix: json["original_launch_unix"],
    missions: json["missions"] == null ? [] : List<Mission>.from(json["missions"]!.map((x) => Mission.fromJson(x))),
    reuseCount: json["reuse_count"],
    rtlsAttempts: json["rtls_attempts"],
    rtlsLandings: json["rtls_landings"],
    asdsAttempts: json["asds_attempts"],
    asdsLandings: json["asds_landings"],
    waterLanding: json["water_landing"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "core_serial": coreSerial,
    "block": block,
    "status": statusValues.reverse[status],
    "original_launch": originalLaunch?.toIso8601String(),
    "original_launch_unix": originalLaunchUnix,
    "missions": missions == null ? [] : List<dynamic>.from(missions!.map((x) => x.toJson())),
    "reuse_count": reuseCount,
    "rtls_attempts": rtlsAttempts,
    "rtls_landings": rtlsLandings,
    "asds_attempts": asdsAttempts,
    "asds_landings": asdsLandings,
    "water_landing": waterLanding,
    "details": details,
  };
}

class Mission {
  String? name;
  int? flight;

  Mission({
    this.name,
    this.flight,
  });

  factory Mission.fromJson(Map<String, dynamic> json) => Mission(
    name: json["name"],
    flight: json["flight"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "flight": flight,
  };
}

enum Status {
  ACTIVE,
  DESTROYED,
  EXPENDED,
  RETIRED,
  UNKNOWN
}

final statusValues = EnumValues({
  "active": Status.ACTIVE,
  "destroyed": Status.DESTROYED,
  "expended": Status.EXPENDED,
  "retired": Status.RETIRED,
  "unknown": Status.UNKNOWN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
