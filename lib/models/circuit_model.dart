import 'dart:convert';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/models/transport_model.dart';

class Circuit {
  Circuit({
    required this.id,
    required this.name,
    required this.available, //checks if circuit was chosen by chauffeur
    required this.station,
  });

  final int id;
  final String name;
  final bool available;
  final List<Station> station;

  factory Circuit.fromRawJson(String str) => Circuit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Circuit.fromJson(Map<String, dynamic> json) {
    print("XXXXXXXXX Circuit.fromJson");
    return Circuit(
      id: json["id"],
      name: json["name"],
      available: json["available"],
      station:
          List<Station>.from(json["station"].map((x) => Station.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "available": available,
        "station": List<dynamic>.from(station.map((x) => x.toJson())),
      };
}

class CircuitDto {
  CircuitDto({
    required this.id,
    required this.name,
    required this.available,
  });

  final int id;
  final String name;
  final bool available;
  factory CircuitDto.fromRawJson(String str) =>
      CircuitDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CircuitDto.fromJson(Map<String, dynamic> json) => CircuitDto(
        id: json["id"],
        name: json["name"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "available": available,
      };
}
