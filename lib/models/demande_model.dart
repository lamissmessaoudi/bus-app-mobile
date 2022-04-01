import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:softun_bus_mobile/models/enum.dart';

Demande demandeFromJson(String str) => Demande.fromJson(json.decode(str));

String demandeToJson(Demande data) => json.encode(data.toJson());

class Demande {
  Demande({
    required this.titre,
    required this.description,
    this.date,
    this.status = RequestState.Inprogress,
    // required this.location,
  });

  String titre;
  String description;
  String? date;
  RequestState? status;

  factory Demande.fromJson(Map<String, dynamic> json) => Demande(
        titre: json["titre"],
        description: json["description"],
        // state: json["state"],
        status: EnumToString.fromString(RequestState.values, json["status"]),
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "titre": titre,
      };
}
