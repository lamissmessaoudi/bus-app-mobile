import 'package:softun_bus_mobile/models/enum.dart';

class Demande {
  Demande({
    required this.name,
    required this.zone,
    required this.description,
    required this.date,
    this.state,
    // required this.location,
  });

  String name;
  String zone;
  String description;
  String date;
  RequestState? state;

  factory Demande.fromJson(dynamic json) => Demande(
        name: json.name,
        zone: json.zone,
        description: json.description,
        date: json.date,
        state: json.state,
      );

  Map<String, dynamic> toJson() => {
        "zone": zone,
        "description": description,
        "date": date,
      };
}
