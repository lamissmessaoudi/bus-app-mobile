class Station {
  Station({
    required this.name,
  });

  String name;

  factory Station.fromJson(dynamic json) => Station(
        name: json.name,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
