class Role {
  Role({
    required this.name,
  });

  String name;

  factory Role.fromJson(dynamic json) => Role(
        name: json.name,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
