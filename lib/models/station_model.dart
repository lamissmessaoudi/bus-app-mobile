import 'dart:convert';

import 'package:softun_bus_mobile/models/location_model.dart';

Station stationFromJson(String str) => Station.fromJson(json.decode(str));

String stationToJson(Station data) => json.encode(data.toJson());

class Station {
  Station({
    required this.id,
    required this.name,
    required this.description,
    this.localisation,
    this.circuit,
  });

  int id;
  String name;
  String description;
  dynamic localisation;
  dynamic circuit;

  int get hashCode => id.hashCode;

  bool operator ==(Object other) => other is Station && other.id == id;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        localisation: json["localisation"],
        circuit: json["circuit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "localisation": localisation,
        "circuit": circuit,
      };
}
