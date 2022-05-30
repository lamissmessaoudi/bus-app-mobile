import 'dart:convert';

import 'package:softun_bus_mobile/models/circuit_model.dart';

Station stationFromJson(String str) => Station.fromJson(json.decode(str));

String stationToJson(Station data) => json.encode(data.toJson());

class Station {
  Station(
      {required this.id,
      required this.name,
      required this.description,
      required this.circuit,
      this.localisation,
      required this.subscribedUsers,
      required this.longitude,
      required this.latitude});

  int id;
  String name;
  String description;
  List<CircuitDto>? circuit;
  dynamic localisation;
  int subscribedUsers;
  double longitude;
  double latitude;

  int get hashCode => id.hashCode;

  bool operator ==(Object other) => other is Station && other.id == id;

  factory Station.fromJson(Map<String, dynamic> json) {
    print("cccccccc  Station");
    return Station(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      circuit: List<CircuitDto>.from(
          json["circuit"].map((x) => CircuitDto.fromJson(x))),
      subscribedUsers: json["subscribedUsers"],
      longitude: json["longitude"],
      latitude: json["latitude"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "circuit": List<dynamic>.from(circuit!.map((x) => x.toJson())),
        "subscribedUsers": subscribedUsers,
        "longitude": longitude,
        "latitude": latitude,
      };
}

class StationDto {
  StationDto(
      {required this.id,
      required this.name,
      required this.description,
      required this.subscribedUsers,
      required this.longitude,
      required this.latitude});

  int id;
  String name;
  String description;
  int subscribedUsers;
  double longitude;
  double latitude;

  int get hashCode => id.hashCode;

  bool operator ==(Object other) => other is StationDto && other.id == id;

  factory StationDto.fromJson(Map<String, dynamic> json) {
    print("cccccccc StationDto");
    return StationDto(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      subscribedUsers: json["subscribedUsers"],
      longitude: json["longitude"],
      latitude: json["latitude"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "subscribedUsers": subscribedUsers,
        "longitude": longitude,
        "latitude": latitude,
      };
}
