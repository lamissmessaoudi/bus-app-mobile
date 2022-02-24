import 'package:softun_bus_mobile/models/location_model.dart';
import 'package:softun_bus_mobile/models/role_model.dart';
import 'package:softun_bus_mobile/models/station_model.dart';

class User {
  User({
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.roles,
    required this.location,
    required this.station,
    required this.poste,
  });

  String name;
  String lastname;
  String email;
  String phone;
  String poste;
  Location? location;
  Station station; //station
  List<Role> roles;

  factory User.fromJson(dynamic json) => User(
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        location: json["location"],
        station: Station.fromJson(json["station"]),
        poste: json["poste"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "station": station.toJson(),
        "location": location,
        "poste": poste,
      };
}
