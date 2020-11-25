import 'dart:convert';

CurseListDb avaliacaoDbFromMap(String str) => CurseListDb.fromMap(json.decode(str));

String avaliacaoDbToMap(CurseListDb data) => json.encode(data.toMap());

class CurseListDb {
  CurseListDb({
    this.id,
    this.idCurso,
    this.nome,
    this.urlImage,
    this.urlYoutube,
    this.descricao,
  });

  int id;
  int idCurso;
  String nome;
  String urlImage;
  String urlYoutube;
  String descricao;

  factory CurseListDb.fromMap(Map<dynamic, dynamic> json) => CurseListDb(
    id: json["id"],
    idCurso: json["idCurso"],
    nome: json["nome"],
    urlImage: json["urlImage"],
    urlYoutube: json["urlYoutube"],
    descricao: json["descricao"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "idCurso": idCurso,
    "nome": nome,
    "urlImage": urlImage,
    "urlYoutube": urlYoutube,
    "descricao": descricao,
  };
}