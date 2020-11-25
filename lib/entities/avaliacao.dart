import 'dart:convert';

AvaliacaoDb avaliacaoDbFromMap(String str) => AvaliacaoDb.fromMap(json.decode(str));

String avaliacaoDbToMap(AvaliacaoDb data) => json.encode(data.toMap());

class AvaliacaoDb {
  AvaliacaoDb({
    this.id,
    this.idConsultor,
    this.name,
    this.avaliacao,
  });

  int id;
  int idConsultor;
  String name;
  String avaliacao;

  factory AvaliacaoDb.fromMap(Map<dynamic, dynamic> json) => AvaliacaoDb(
    id: json["id"],
    idConsultor: json["idConsultor"],
    name: json["name"],
    avaliacao: json["avaliacao"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "idConsultor": idConsultor,
    "name": name,
    "avaliacao": avaliacao,
  };
}