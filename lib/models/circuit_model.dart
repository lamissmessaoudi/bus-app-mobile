import 'dart:convert';
import 'package:softun_bus_mobile/models/station_model.dart';

class Circuit {
  Circuit({
    required this.id,
    // required this.description,
    required this.name,
    required this.available, //checks if circuit was chosen by chauffeur
    required this.station,
    required this.depart,
  });

  final int id;
  // final String description;
  final String name;
  final bool available;
  final List<Station> station;
  final StationDto depart;

  factory Circuit.fromRawJson(String str) => Circuit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Circuit.fromJson(Map<String, dynamic> json) {
    return Circuit(
      id: json["id"],
      // description: json["description"],
      name: json["name"],
      available: json["available"],
      station:
          List<Station>.from(json["station"].map((x) => Station.fromJson(x))),
      depart: StationDto.fromJson(json["depart"]),
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
    this.description,
  });

  final int id;
  final String? description;
  final String name;
  final bool available;
  factory CircuitDto.fromRawJson(String str) =>
      CircuitDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CircuitDto.fromJson(Map<String, dynamic> json) {
    return CircuitDto(
      id: json["id"],
      description: json["description"],
      name: json["name"],
      available: json["available"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "available": available,
      };
}

class CircuitResDto {
  CircuitResDto({
    required this.id,
    this.description,
    required this.name,
    required this.available,
    required this.station,
    required this.depart,
  });

  final int id;
  final String? description;
  final String name;
  final bool available;
  final List<StationDto> station;
  final StationDto depart;

  factory CircuitResDto.fromRawJson(String str) =>
      CircuitResDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CircuitResDto.fromJson(Map<String, dynamic> json) {
    var x = CircuitResDto(
      id: json["id"],
      description: json["description"],
      name: json["name"],
      available: json["available"],
      station: List<StationDto>.from(
          json["station"].map((x) => StationDto.fromJson(x))),
      depart: StationDto.fromJson(json["depart"]),
    );

    return x;
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "available": available,
      };
}
