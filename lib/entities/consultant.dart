import 'dart:convert';

Consultant avaliacaoDbFromMap(String str) => Consultant.fromMap(json.decode(str));

String avaliacaoDbToMap(Consultant data) => json.encode(data.toMap());

class Consultant {
  Consultant({
    this.id,
    this.name,
    this.age,
    this.description,
    this.url,
    this.competencia,
  });

  int id;
  String name;
  int age;
  String description;
  String url;
  String competencia;

  factory Consultant.fromMap(Map<dynamic, dynamic> json) => Consultant(
    id: json["_id"],
    name: json["name"],
    age: json["age"],
    description: json["description"],
    url: json["url"],
    competencia: json["competencia"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "age": age,
    "description": description,
    "url": url,
    "competencia": competencia,
  };
}
