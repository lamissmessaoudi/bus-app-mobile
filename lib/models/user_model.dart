import 'package:enum_to_string/enum_to_string.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/role_model.dart';
import 'package:softun_bus_mobile/models/station_model.dart';

class User {
  User({
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.roles,
    required this.station,
    required this.poste,
    required this.active,
    required this.deviceId,
  });

  String name;
  String lastname;
  String email;
  String phone;
  String poste;
  Station station;
  List<RoleType> roles;
  bool active;
  String deviceId;

  factory User.fromJson(dynamic json) => User(
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        roles: List.from(json["roles"].map((x) =>
            EnumToString.fromString(RoleType.values, Role.fromJson(x).name))),
        station: Station.fromJson(json["station"]),
        poste: json["poste"],
        active: json["active"],
        deviceId: json["deviceId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "station": station.toJson(),
        "poste": poste,
        "active": active,
        "deviceId": deviceId,
      };
  Map<String, dynamic> toSharedJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "roles": List.from(roles
            .map((x) => Role(name: EnumToString.convertToString(x)).toJson())),
        "station": station.toJson(),
        "poste": poste,
        "active": active,
        "deviceId": deviceId,
      };
}

class InactiveUser {
  InactiveUser({
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    this.roles,
    this.station,
    required this.poste,
    required this.active,
    required this.deviceId,
  });

  String name;
  String lastname;
  String email;
  String phone;
  String poste;
  StationDto? station;
  List<RoleType>? roles;
  bool active;
  String deviceId;

  factory InactiveUser.fromJson(dynamic json) => InactiveUser(
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        roles: List.from(json["roles"].map((x) =>
            EnumToString.fromString(RoleType.values, Role.fromJson(x).name))),
        station: StationDto.fromJson(json["station"]),
        poste: json["poste"],
        active: json["active"],
        deviceId: json["deviceId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "station": station?.toJson(),
        "poste": poste,
        "active": active,
        "deviceId": deviceId,
      };
}
