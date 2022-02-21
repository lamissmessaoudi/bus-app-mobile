import 'package:softun_bus_mobile/models/location.dart';
import 'package:softun_bus_mobile/models/role.dart';
import 'package:softun_bus_mobile/models/station.dart';

class User {
  User({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.cin,
    required this.roles,
    required this.location,
    required this.station,
    required this.poste,
  });

  String nom;
  String prenom;
  String email;
  String cin;
  Location location;
  Station station;
  String poste;
  List<Role> roles;

  factory User.fromJson(dynamic json) => User(
        nom: json.nom,
        prenom: json.prenom,
        email: json.email,
        cin: json.cin,
        roles: json.roles,
        location: json.location,
        station: json.station,
        poste: json.poste,
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "cin": cin,
        "roles": roles,
        "station": station,
        "location": location,
        "poste": poste,
      };
}
