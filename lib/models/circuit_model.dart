import 'dart:convert';
import 'package:softun_bus_mobile/models/station_model.dart';

class Circuit {
  Circuit({
    required this.id,
    required this.name,
    required this.station,
    required this.transports,
  });

  final int id;
  final String name;
  final List<Station> station;
  final List<dynamic> transports;

  factory Circuit.fromRawJson(String str) => Circuit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Circuit.fromJson(Map<String, dynamic> json) => Circuit(
        id: json["id"],
        name: json["name"],
        station:
            List<Station>.from(json["station"].map((x) => Station.fromJson(x))),
        transports: List<dynamic>.from(json["transports"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "station": List<dynamic>.from(station.map((x) => x.toJson())),
        "transports": List<dynamic>.from(transports.map((x) => x)),
      };
}
