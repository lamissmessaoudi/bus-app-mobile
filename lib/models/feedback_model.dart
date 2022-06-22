import 'dart:convert';

Feedback feedbackFromJson(String str) => Feedback.fromJson(json.decode(str));

String feedbackToJson(Feedback data) => json.encode(data.toJson());

class Feedback {
  Feedback({
    required this.titre,
    required this.description,
    required this.date,
  });

  String titre;
  String description;
  String date;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        titre: json["titre"],
        description: json["description"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "titre": titre,
      };
}
