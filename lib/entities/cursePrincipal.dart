import 'dart:convert';

CursePrincipalDb avaliacaoDbFromMap(String str) => CursePrincipalDb.fromMap(json.decode(str));

String avaliacaoDbToMap(CursePrincipalDb data) => json.encode(data.toMap());

class CursePrincipalDb {
  CursePrincipalDb({
    this.id,
    this.idCurso,
    this.nome,
    this.avaliacao,
    this.url,
  });

  int id;
  int idCurso;
  String nome;
  String avaliacao;
  String url;

  factory CursePrincipalDb.fromMap(Map<dynamic, dynamic> json) => CursePrincipalDb(
    id: json["id"],
    idCurso: json["idCurso"],
    nome: json["nome"],
    avaliacao: json["avaliacao"],
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "idCurso": idCurso,
    "nome": nome,
    "avaliacao": avaliacao,
    "url": url,
  };
}