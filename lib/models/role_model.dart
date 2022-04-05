import 'dart:convert';

class Role {
  Role({
    // required this.id,
    required this.name,
    // required this.user,
  });

  // int id;
  String name;
  // List<dynamic> user;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        // id: json["id"],
        name: json["name"],
        // user: List<dynamic>.from(json["user"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        // "user": List<dynamic>.from(user.map((x) => x)),
      };
}
