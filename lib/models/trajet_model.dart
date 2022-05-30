// To parse this JSON data, do
//
//     final trajet = trajetFromJson(jsonString);

import 'dart:convert';

import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';

Trajet trajetFromJson(String str) => Trajet.fromJson(json.decode(str));

String trajetToJson(Trajet data) => json.encode(data.toJson());

class Trajet {
  Trajet({
    required this.circuit,
    required this.user,
    required this.date,
  });

  CircuitResDto circuit;
  InactiveUser user;
  DateTime date;

  factory Trajet.fromJson(Map<String, dynamic> json) {
    return Trajet(
      circuit: CircuitResDto.fromJson(json["circuit"]),
      user: InactiveUser.fromJson(json["user"]),
      date: DateTime.parse(json["date"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "circuit": circuit.toJson(),
        "user": user.toJson(),
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
