class Location {
  Location({
    required this.name,
  });

  String name;

  factory Location.fromJson(dynamic json) => Location(
        name: json.name,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
