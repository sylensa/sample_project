// To parse this JSON data, do
//
//     final capsulesModel = capsulesModelFromJson(jsonString);

import 'dart:convert';

List<CapsulesModel> capsulesModelFromJson(String str) => List<CapsulesModel>.from(json.decode(str).map((x) => CapsulesModel.fromJson(x)));

String capsulesModelToJson(List<CapsulesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CapsulesModel {
  String? capsuleSerial;
  CapsuleId? capsuleId;
  Status? status;
  DateTime? originalLaunch;
  int? originalLaunchUnix;
  List<Mission>? missions;
  int? landings;
  Type? type;
  String? details;
  int? reuseCount;

  CapsulesModel({
    this.capsuleSerial,
    this.capsuleId,
    this.status,
    this.originalLaunch,
    this.originalLaunchUnix,
    this.missions,
    this.landings,
    this.type,
    this.details,
    this.reuseCount,
  });

  factory CapsulesModel.fromJson(Map<String, dynamic> json) => CapsulesModel(
    capsuleSerial: json["capsule_serial"],
    capsuleId: capsuleIdValues.map[json["capsule_id"]]!,
    status: statusValues.map[json["status"]]!,
    originalLaunch: json["original_launch"] == null ? null : DateTime.parse(json["original_launch"]),
    originalLaunchUnix: json["original_launch_unix"],
    missions: json["missions"] == null ? [] : List<Mission>.from(json["missions"]!.map((x) => Mission.fromJson(x))),
    landings: json["landings"],
    type: typeValues.map[json["type"]]!,
    details: json["details"],
    reuseCount: json["reuse_count"],
  );

  Map<String, dynamic> toJson() => {
    "capsule_serial": capsuleSerial,
    "capsule_id": capsuleIdValues.reverse[capsuleId],
    "status": statusValues.reverse[status],
    "original_launch": originalLaunch?.toIso8601String(),
    "original_launch_unix": originalLaunchUnix,
    "missions": missions == null ? [] : List<dynamic>.from(missions!.map((x) => x.toJson())),
    "landings": landings,
    "type": typeValues.reverse[type],
    "details": details,
    "reuse_count": reuseCount,
  };
}

enum CapsuleId {
  DRAGON1,
  DRAGON2
}

final capsuleIdValues = EnumValues({
  "dragon1": CapsuleId.DRAGON1,
  "dragon2": CapsuleId.DRAGON2
});

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
  RETIRED,
  UNKNOWN
}

final statusValues = EnumValues({
  "active": Status.ACTIVE,
  "destroyed": Status.DESTROYED,
  "retired": Status.RETIRED,
  "unknown": Status.UNKNOWN
});

enum Type {
  DRAGON_10,
  DRAGON_11,
  DRAGON_20
}

final typeValues = EnumValues({
  "Dragon 1.0": Type.DRAGON_10,
  "Dragon 1.1": Type.DRAGON_11,
  "Dragon 2.0": Type.DRAGON_20
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
