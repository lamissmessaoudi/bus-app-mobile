// To parse this JSON data, do
//
//     final transport = transportFromJson(jsonString);

import 'dart:convert';

import 'package:softun_bus_mobile/models/circuit_model.dart';

Transport transportFromJson(String str) => Transport.fromJson(json.decode(str));

String transportToJson(Transport data) => json.encode(data.toJson());

class Transport {
  Transport({
    required this.longitude,
    required this.latitude,
    required this.circuit,
  });

  dynamic longitude;
  dynamic latitude;
  CircuitDto circuit;

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
        longitude: json["longitude"],
        latitude: json["latitude"],
        circuit: CircuitDto.fromJson(json["circuit"]),
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
        "circuit": circuit.toJson(),
      };
}
