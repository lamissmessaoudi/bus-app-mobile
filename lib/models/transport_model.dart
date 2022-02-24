class Transport {
  Transport({
    required this.name,
  });

  String name;

  factory Transport.fromJson(dynamic json) => Transport(
        name: json.name,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
