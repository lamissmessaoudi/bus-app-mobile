import 'dart:convert';

Station stationFromJson(String str) => Station.fromJson(json.decode(str));

String stationToJson(Station data) => json.encode(data.toJson());

class Station {
  Station(
      {required this.id,
      required this.name,
      required this.description,
      this.localisation,
      this.subscribedUsers,
      this.longitude,
      this.lattitude});

  int id;
  String name;
  String description;
  dynamic localisation;
  dynamic subscribedUsers;
  dynamic longitude;
  dynamic lattitude;

  int get hashCode => id.hashCode;

  bool operator ==(Object other) => other is Station && other.id == id;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        localisation: json["localisation"],
        longitude: json["longitude"],
        lattitude: json["lattitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "localisation": localisation,
        "longitude": longitude,
        "lattitude": lattitude,
      };
}
