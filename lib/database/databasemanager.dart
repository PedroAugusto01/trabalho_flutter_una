import 'dart:io';
import 'package:flutter_app/database/avaliacaomanager.dart';
import 'package:flutter_app/database/usermanager.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'consultantmanager.dart';
import 'curselistmanager.dart';
import 'curseprincipalmanager.dart';

class DatabaseManager {
  final _cursePrincipalManager = CursePrincipalManager();
  final _curseListManager = CurseListManager();
  final _consultantManager = ConsultantManager();

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  DatabaseManager.privateConstructor();

  static final DatabaseManager instance = DatabaseManager.privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${UserManager.table} (
            ${UserManager.columnId} INTEGER PRIMARY KEY,
            ${UserManager.columnName} TEXT NOT NULL,
            ${UserManager.columnGender} TEXT NOT NULL,
            ${UserManager.columnEmail} TEXT NOT NULL,
            ${UserManager.columnPassword} TEXT NOT NULL,
            ${UserManager.columnAge} INTEGER NOT NULL,
            ${UserManager.columnImageZero} TEXT,
            ${UserManager.columnImageOne} TEXT,
            ${UserManager.columnImageTwo} TEXT,
            ${UserManager.columnImageThree} TEXT,
            ${UserManager.columnImageIntroduction} TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE ${ConsultantManager.table} (
            ${ConsultantManager.id} INTEGER PRIMARY KEY,
            ${ConsultantManager.name} TEXT NOT NULL,
            ${ConsultantManager.age} INTEGER NOT NULL,
            ${ConsultantManager.description} TEXT NOT NULL,
            ${ConsultantManager.url} TEXT NOT NULL,
            ${ConsultantManager.competencia} TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE ${AvaliacaoManager.table} (
            ${AvaliacaoManager.id} INTEGER PRIMARY KEY,
            ${AvaliacaoManager.idConsultor} INTEGER,
            ${AvaliacaoManager.name} TEXT,
            ${AvaliacaoManager.avaliacao} TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE ${CursePrincipalManager.table} (
            ${CursePrincipalManager.id} INTEGER PRIMARY KEY,
            ${CursePrincipalManager.idCurso} INTEGER,
            ${CursePrincipalManager.nome} TEXT,
            ${CursePrincipalManager.avaliacao} TEXT,
            ${CursePrincipalManager.url} TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE ${CurseListManager.table} (
            ${CurseListManager.id} INTEGER PRIMARY KEY,
            ${CurseListManager.idCurso} INTEGER,
            ${CurseListManager.nome} TEXT,
            ${CurseListManager.urlImage} TEXT,
            ${CurseListManager.urlYoutube} TEXT,
            ${CurseListManager.descricao} TEXT
          )
          ''');

    mockDataToDb();
  }

  void mockDataToDb() async {
    sleep(const Duration(seconds: 3));
    mockPrincipalCurseListDefault();
    mockCurseListDefault();
    sleep(const Duration(seconds: 3));
    mockConsultorListDefault();
  }

  void mockPrincipalCurseListDefault() {
     _cursePrincipalManager.insertCurse(1, "Curso de Python", "Linguagem de programação.", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png");
     _cursePrincipalManager.insertCurse(2, "Curso de Administração.", "Empresas.", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg");
     _cursePrincipalManager.insertCurse(3, "Curso Oracle", "Linguagem de programação.", "https://ebusinessconsultoria.com.br/assets/Uploads/WhPQ8SeQ.jpg");
     _cursePrincipalManager.insertCurse(4, "Curso PowerBi", "Análise de negócios.", "https://www.apkmirror.com/wp-content/uploads/2019/11/5dd397dbb0077.png");
     _cursePrincipalManager.insertCurse(5, "Curso Qlik", "Integração de dados, inteligência de negócios.", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png");
     _cursePrincipalManager.insertCurse(6, "Curso CSharp", "Linguagem de programação.", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg");
     _cursePrincipalManager.insertCurse(7, "Curso Java Script", "Linguagem de programação.", "https://image.flaticon.com/icons/png/512/721/721671.png");
     _cursePrincipalManager.insertCurse(8, "Curso Tableau", "Business Intelligence.", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg");
     _cursePrincipalManager.insertCurse(9, "Curso Postgre", "Banco de Dados.", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png");
     _cursePrincipalManager.insertCurse(10, "Curso Android", "Sistema Operacional, Linguagem de programação.", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png");
  }

  void mockCurseListDefault() {
    _curseListManager.insertCurse(1, "Aula - 01", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png", "https://www.youtube.com/watch?v=Ay-MakuSg08&ab_channel=CFBCursos", "Introdução ao Python");
    _curseListManager.insertCurse(1, "Aula - 02", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png", "https://www.youtube.com/watch?v=5JdEoBZYHFY&ab_channel=CFBCursosi", "Sintaxe básica");
    _curseListManager.insertCurse(1, "Aula - 03", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png", "https://www.youtube.com/watch?v=_p4dPzetzpE&ab_channel=CFBCursos", "Variáveis em Python");
    _curseListManager.insertCurse(1, "Aula - 04", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png", "https://www.youtube.com/watch?v=FgB-uFuFcwo&ab_channel=CFBCursos", "Tipos de dados em Python");
    _curseListManager.insertCurse(1, "Aula - 05", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png", "https://www.youtube.com/watch?v=Vsrhr5bh5u0&ab_channel=CFBCursos", "Tipos numéricos, random e operações de casting");
    _curseListManager.insertCurse(1, "Aula - 06", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png", "https://www.youtube.com/watch?v=DUZoz0HuuCU&ab_channel=CFBCursos", "Strings P1.");
    _curseListManager.insertCurse(1, "Aula - 07", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png", "https://www.youtube.com/watch?v=1Wq5QSdLAKE&ab_channel=CFBCursos", "Strings P2");
    _curseListManager.insertCurse(1, "Aula - 08", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png", "https://www.youtube.com/watch?v=yGXpyEpNSe0&ab_channel=CFBCursos", "Tipo Boolean");
    _curseListManager.insertCurse(1, "Aula - 09", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png", "https://www.youtube.com/watch?v=N7zOb-wB0xI&ab_channel=CFBCursos", "Coleção List");
    _curseListManager.insertCurse(1, "Aula - 10", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png", "https://www.youtube.com/watch?v=EY505u2h_VQ&ab_channel=CFBCursos", "Como usar o comando IF em Python");
    _curseListManager.insertCurse(1, "Playlist", "https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/python-512.png", "https://www.youtube.com/playlist?list=PLx4x_zx8csUhuVgWfy7keQQAy7t1J35TR", "Para mais Videos acesse nossa playlist no YouTube");
    _curseListManager.insertCurse(2, "Aula - 01", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/watch?v=iPjotuQC-Oo&ab_channel=Prof.MarcoFerrari", "O que é Administração");
    _curseListManager.insertCurse(2, "Aula - 02", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/watch?v=xE7eLpeAsEc", "Os setores da sociedade");
    _curseListManager.insertCurse(2, "Aula - 03", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/watch?v=HMWzYB05Qoo", "Níveis de atuação do administrador");
    _curseListManager.insertCurse(2, "Aula - 04", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/watch?v=ggiG-t99hxQ", "Processo Administrativo");
    _curseListManager.insertCurse(2, "Aula - 05", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/watch?v=oBvp9BeeUuk", "Objeto da Administração e Administrar");
    _curseListManager.insertCurse(2, "Aula - 06", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/watch?v=18DgWe1GhOw", "Níveis da Organização");
    _curseListManager.insertCurse(2, "Aula - 07", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/watch?v=gmOS6_yVEag", "Habilidades do Administrador");
    _curseListManager.insertCurse(2, "Aula - 08", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/watch?v=mkWaQG2zqRI", "Setores da Sociedade");
    _curseListManager.insertCurse(2, "Aula - 09", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/watch?v=fgWRI0qdaKU", "Teorias da Administração");
    _curseListManager.insertCurse(2, "Aula - 10", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/watch?v=On-ms8VNdl4", "Teoria Clássica");
    _curseListManager.insertCurse(2, "Aula - 11", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/watch?v=wcZc1QGUwLE", "Funções da Administração");
    _curseListManager.insertCurse(2, "Playlist", "https://i.pinimg.com/564x/bd/ea/dd/bdeadd36891535a11ff95ff9fbfcfa6b.jpg", "https://www.youtube.com/playlist?list=PLPjPQR5HICvVZ_jIacocZ-U2MYJBkncLz", "Para mais videos acesse nossa playlist no Youtube.");
    _curseListManager.insertCurse(3, "Aula - 01", "https://ebusinessconsultoria.com.br/assets/Uploads/WhPQ8SeQ.jpg", "https://www.youtube.com/watch?v=vOqatv42tkc", "Instalando o Oracle");
    _curseListManager.insertCurse(3, "Aula - 02", "https://ebusinessconsultoria.com.br/assets/Uploads/WhPQ8SeQ.jpg", "https://www.youtube.com/watch?v=Cs_Vk8ZckN4&ab_channel=AprendaPL%2FSQL", "Liberando o Schema HR no Oracle XE");
    _curseListManager.insertCurse(3, "Aula - 03", "https://ebusinessconsultoria.com.br/assets/Uploads/WhPQ8SeQ.jpg", "https://www.youtube.com/watch?v=E3vu--LFzqw&ab_channel=AprendaPL%2FSQL", "Oracle SQL");
    _curseListManager.insertCurse(3, "Aula - 04", "https://ebusinessconsultoria.com.br/assets/Uploads/WhPQ8SeQ.jpg", "https://www.youtube.com/watch?v=jZ19rKuRsSk&ab_channel=AprendaPL%2FSQL", "Primeiros Passos no PL/SQL");
    _curseListManager.insertCurse(3, "Aula - 05", "https://ebusinessconsultoria.com.br/assets/Uploads/WhPQ8SeQ.jpg", "https://www.youtube.com/watch?v=QLpIPnwADeY&ab_channel=AprendaPL%2FSQL", "Oracle Procedure PL/SQL");
    _curseListManager.insertCurse(4, "Aula - 01", "https://www.apkmirror.com/wp-content/uploads/2019/11/5dd397dbb0077.png", "https://www.youtube.com/watch?v=lFdva6LcTAY", "Introdução");
    _curseListManager.insertCurse(4, "Aula - 02", "https://www.apkmirror.com/wp-content/uploads/2019/11/5dd397dbb0077.png", "https://www.youtube.com/watch?v=merUYMASzWw", "Curso Básico de Power BI");
    _curseListManager.insertCurse(4, "Aula - 03", "https://www.apkmirror.com/wp-content/uploads/2019/11/5dd397dbb0077.png", "https://www.youtube.com/watch?v=B8lJd_3XH-c", "Curso Básico de Power BI");
    _curseListManager.insertCurse(4, "Aula - 04", "https://www.apkmirror.com/wp-content/uploads/2019/11/5dd397dbb0077.png", "https://www.youtube.com/watch?v=gGoyMm8EUWM", "Curso Básico de Power BI");
    _curseListManager.insertCurse(4, "Aula - 05", "https://www.apkmirror.com/wp-content/uploads/2019/11/5dd397dbb0077.png", "https://www.youtube.com/watch?v=h93MAg4_sOk", "Curso Básico de Power BI");
    _curseListManager.insertCurse(4, "Aula - 06", "https://www.apkmirror.com/wp-content/uploads/2019/11/5dd397dbb0077.png", "https://www.youtube.com/watch?v=Xg1xXvIKlVk", "Curso Básico de Power BI");
    _curseListManager.insertCurse(4, "Case Final", "https://www.apkmirror.com/wp-content/uploads/2019/11/5dd397dbb0077.png", "https://www.youtube.com/watch?v=7Re1YF6KdS0", "Curso Básico de Power BI");
    _curseListManager.insertCurse(4, "Case Final", "https://www.apkmirror.com/wp-content/uploads/2019/11/5dd397dbb0077.png", "https://www.youtube.com/watch?v=z2oVo49C8Y0", "Certificado do Curso de Power BI Básico");
    _curseListManager.insertCurse(5, "Aula - 01", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png", "https://www.youtube.com/watch?v=kzgS33jvRCw", "Aprendendo Join, Keep e Where");
    _curseListManager.insertCurse(5, "Aula - 02", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png", "https://www.youtube.com/watch?v=yIu4117eJm8", "Criando um gráfico de Dispersão");
    _curseListManager.insertCurse(5, "Aula - 03", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png", "https://www.youtube.com/watch?v=Tczl1Abi3FY", "Aprenda set analysis no Qlik");
    _curseListManager.insertCurse(5, "Aula - 04", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png", "https://www.youtube.com/watch?v=simBa6RZaEY", "Automatizando tarefas com arquivos .bat");
    _curseListManager.insertCurse(5, "Aula - 05", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png", "https://www.youtube.com/watch?v=nwfa5oX_RoA", "Criando um gráfico de barras");
    _curseListManager.insertCurse(5, "Aula - 06", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png", "https://www.youtube.com/watch?v=CZQhLRXFOVI", "Criando Layout em Qlikview");
    _curseListManager.insertCurse(5, "Aula - 07", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png", "https://www.youtube.com/watch?v=A2bzT61KZas", "Criando e utilizando arquivos .bat");
    _curseListManager.insertCurse(5, "Aula - 08", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png", "https://www.youtube.com/watch?v=v2RoYKHITfQ", "Carregamento de dados no Excel");
    _curseListManager.insertCurse(5, "Aula - 09", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png", "https://www.youtube.com/watch?v=QMqrO5gqEy4", "Modelagem de dados");
    _curseListManager.insertCurse(5, "Aula - 10", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png", "https://www.youtube.com/watch?v=uM1sJkOaxVw", "Aula de Business Process Modeler");
    _curseListManager.insertCurse(5, "Playlist", "https://www.gov.br/pt-br/todosportodos/imagens/qlik_512.png", "https://www.youtube.com/playlist?list=PLbc2GjxMfq2VzLyel2t_CCkZnVHBXTpqA", "Para mais Videos acesse nossa playlist no youtube");
    _curseListManager.insertCurse(6, "Aula - 01", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg", "https://www.youtube.com/watch?v=9Uh0ynDB6ko", "Abertura do Curso de C#");
    _curseListManager.insertCurse(6, "Aula - 02", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg", "https://www.youtube.com/watch?v=Hfg4Ia2k0ZM", "Console Application");
    _curseListManager.insertCurse(6, "Aula - 03", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg", "https://www.youtube.com/watch?v=hUlDF6dWrSI", "C# Project");
    _curseListManager.insertCurse(6, "Aula - 04", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg", "https://www.youtube.com/watch?v=Jeh5eYFOoos", "Comentários");
    _curseListManager.insertCurse(6, "Aula - 05", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg", "https://www.youtube.com/watch?v=4IwPvi4jLqg", "Variáveis");
    _curseListManager.insertCurse(6, "Aula - 06", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg", "https://www.youtube.com/watch?v=BIisdMxNow0", "Tipos de Dados");
    _curseListManager.insertCurse(6, "Aula - 07", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg", "https://www.youtube.com/watch?v=F1gb4f3tkkY", "Características das variáveis");
    _curseListManager.insertCurse(6, "Aula - 08", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg", "https://www.youtube.com/watch?v=wSMih47jgRI", "Entrada de Dados");
    _curseListManager.insertCurse(6, "Aula - 09", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg", "https://www.youtube.com/watch?v=MCiknR_iuII", "Conversão de Dados");
    _curseListManager.insertCurse(6, "Aula - 10", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg", "https://www.youtube.com/watch?v=T3GKI8u85Kw", "Calculadora");
    _curseListManager.insertCurse(6, "Playlist", "https://img.favpng.com/5/2/0/microsoft-visual-studio-visual-studio-code-c-sql-server-integration-services-visual-programming-language-png-favpng-jRvi81V90qqajwe4Fwx0WduDU.jpg", "https://www.youtube.com/playlist?list=PLesCEcYj003SFffgnOcITHnCJavMf0ArD", "Para mais Videos acesse nossa playlist no youtube");
    _curseListManager.insertCurse(7, "Aula - 01", "https://image.flaticon.com/icons/png/512/721/721671.png", "https://www.youtube.com/watch?v=mRryrODqQcw", "Bem-vindo");
    _curseListManager.insertCurse(7, "Aula - 02", "https://image.flaticon.com/icons/png/512/721/721671.png", "https://www.youtube.com/watch?v=o5H2LYuHM1I", "FUNDAMENTOS DE PROGRAMAÇÃO");
    _curseListManager.insertCurse(7, "Aula - 03", "https://image.flaticon.com/icons/png/512/721/721671.png", "https://www.youtube.com/watch?v=-uwh4GWJBqc", "INSTALANDO JAVA JDK E IDE");
    _curseListManager.insertCurse(7, "Aula - 04", "https://image.flaticon.com/icons/png/512/721/721671.png", "https://www.youtube.com/watch?v=QO5ItC3KqJg", "PRIMEIRO PROGRAMA JAVA");
    _curseListManager.insertCurse(7, "Aula - 05", "https://image.flaticon.com/icons/png/512/721/721671.png", "https://www.youtube.com/watch?v=BLMu7ebMC1A", "PROGRAMAÇÃO DINÂMICA COM VARIÁVEIS.");
    _curseListManager.insertCurse(7, "Aula - 06", "https://image.flaticon.com/icons/png/512/721/721671.png", "https://www.youtube.com/watch?v=-niV9NFgHdI", "ERROS NA PROGRAMAÇÃO");
    _curseListManager.insertCurse(7, "Aula - 07", "https://image.flaticon.com/icons/png/512/721/721671.png", "https://www.youtube.com/watch?v=xO2_XL7k29k", "FUNÇÕES");
    _curseListManager.insertCurse(7, "Aula - 08", "https://image.flaticon.com/icons/png/512/721/721671.png", "https://www.youtube.com/watch?v=E0VeajoiNrY", "ARGUMENTOS");
    _curseListManager.insertCurse(7, "Aula - 09", "https://image.flaticon.com/icons/png/512/721/721671.png", "https://www.youtube.com/watch?v=-NS6QTT5a3o", "PROJETO 01 E CONDIÇÕES");
    _curseListManager.insertCurse(7, "Aula - 10", "https://image.flaticon.com/icons/png/512/721/721671.png", "https://www.youtube.com/watch?v=9xTqj779eP0", "LOOPS");
    _curseListManager.insertCurse(7, "Playlist", "https://image.flaticon.com/icons/png/512/721/721671.png", "https://www.youtube.com/playlist?list=PLJ0AcghBBWSi6nK2CUkw9ngvwWB1gE8mL", "Para mais Videos acesse nossa playlist no youtube");
    _curseListManager.insertCurse(8, "Aula - 01", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg", "https://www.youtube.com/watch?v=8RdwBR9PUKA", "Introdução");
    _curseListManager.insertCurse(8, "Aula - 02", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg", "https://www.youtube.com/watch?v=JzpQjvXVGC8", "Instalação");
    _curseListManager.insertCurse(8, "Aula - 03", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg", "https://www.youtube.com/watch?v=aPzPF52ei2k", "Conectando o Tableau ao arquivo de Dados");
    _curseListManager.insertCurse(8, "Aula - 04", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg", "https://www.youtube.com/watch?v=jyFewEbsMhg", "Seu Primeiro Gráfico de Barras");
    _curseListManager.insertCurse(8, "Aula - 05", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg", "https://www.youtube.com/watch?v=CKb-zgLJyZA", "Filtros");
    _curseListManager.insertCurse(8, "Aula - 06", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg", "https://www.youtube.com/watch?v=9uKuj3IzOxQ", "Cores e Labels");
    _curseListManager.insertCurse(8, "Aula - 07", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg", "https://www.youtube.com/watch?v=xIscdteaLCA", "Vamos Publicar!");
    _curseListManager.insertCurse(8, "Aula - 08", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg", "https://www.youtube.com/watch?v=C4P-14Du7WQ", "Criando Mapas");
    _curseListManager.insertCurse(8, "Aula - 09", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg", "https://www.youtube.com/watch?v=zvVKfCMnYLM", "Campos Calculados");
    _curseListManager.insertCurse(8, "Aula - 10", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg", "https://www.youtube.com/watch?v=Uf3R91qtkww", "Tooltips");
    _curseListManager.insertCurse(8, "Playlist", "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/97/3b/c4973bd4-87ae-802a-d60a-55b7d01ce88f/source/512x512bb.jpg", "https://www.youtube.com/playlist?list=PLncE4PW8oRWjV3TLFxhOJxul1WeziSMGb", "Para mais Videos acesse nossa playlist no youtube");
    _curseListManager.insertCurse(9, "Aula - 01", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png", "https://www.youtube.com/watch?v=k4wYRoMvBwE", "Introdução");
    _curseListManager.insertCurse(9, "Aula - 02", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png", "https://www.youtube.com/watch?v=TbWp-1IAQLk", "Preparando ambiente");
    _curseListManager.insertCurse(9, "Aula - 03", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png", "https://www.youtube.com/watch?v=UDs7In1L3b4", "Criando banco e apresentando modelagem");
    _curseListManager.insertCurse(9, "Aula - 04", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png", "https://www.youtube.com/watch?v=Ao0hYZZFx1Q", "Criando tabela");
    _curseListManager.insertCurse(9, "Aula - 05", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png", "https://www.youtube.com/watch?v=Y87XbiJsGQc", "Salvando dados - Insert");
    _curseListManager.insertCurse(9, "Aula - 06", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png", "https://www.youtube.com/watch?v=zZYbU317h-8", "Atualizando dados - Update");
    _curseListManager.insertCurse(9, "Aula - 07", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png", "https://www.youtube.com/watch?v=xMlz6FzTDH8", "Removendo dados - Delete");
    _curseListManager.insertCurse(9, "Aula - 08", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png", "https://www.youtube.com/watch?v=4zJyD1pDkM4", "Consultando dados - SELECT, WHERE");
    _curseListManager.insertCurse(9, "Aula - 09", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png", "https://www.youtube.com/watch?v=jpXiGCS8IAk", "Ordenando dados - ORDER BY");
    _curseListManager.insertCurse(9, "Aula - 10", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png", "https://www.youtube.com/watch?v=YLY_MFMD3Tc", "Operador OR no SELECT");
    _curseListManager.insertCurse(9, "Playlist", "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/postgresql-512.png", "https://www.youtube.com/playlist?list=PLWd_VnthxxLe660ABLFZH26CW3G-uQIv-", "Para mais Videos acesse nossa playlist no youtube");
    _curseListManager.insertCurse(10, "Aula - 01", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png", "https://www.youtube.com/watch?v=kpOgYSptDgI", "Apresentação e Download do Android Studio");
    _curseListManager.insertCurse(10, "Aula - 02", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png", "https://www.youtube.com/watch?v=sgRYN6-nnR4", "Criando o projeto");
    _curseListManager.insertCurse(10, "Aula - 03", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png", "https://www.youtube.com/watch?v=b8XUchEXjNE", "Configurando o emulador");
    _curseListManager.insertCurse(10, "Aula - 04", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png", "https://www.youtube.com/watch?v=p_JJiNpds4Y", "Hello World Android");
    _curseListManager.insertCurse(10, "Aula - 05", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png", "https://www.youtube.com/watch?v=Sy6U99DllzU", "Criando a Documentação básica do App");
    _curseListManager.insertCurse(10, "Aula - 06", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png", "https://www.youtube.com/watch?v=CGXzO7VE360", "Implementando as classes do modelo");
    _curseListManager.insertCurse(10, "Aula - 07", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png", "https://www.youtube.com/watch?v=6S9QbFyrGfM", "Criando a interface de cadastro de produtos");
    _curseListManager.insertCurse(10, "Aula - 08", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png", "https://www.youtube.com/watch?v=Wt4uul635pQ", "Convervetendo os componentes visuais XML em componentes java");
    _curseListManager.insertCurse(10, "Aula - 09", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png", "https://www.youtube.com/watch?v=yGZt6UvOLZs", "Criando um produto com os dados do formulário");
    _curseListManager.insertCurse(10, "Aula - 10", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png", "https://www.youtube.com/watch?v=Ev15mPogJKM", "Evento de click no botão e executando o APP pela primeira vez");
    _curseListManager.insertCurse(10, "Playlist", "https://i.pinimg.com/originals/4e/74/7c/4e747c82368d9681b75d54f56319dae7.png", "https://www.youtube.com/playlist?list=PLt2CbMyJxu8hzGw-BLVdcjk-UhTBSCcru", "Para mais Videos acesse nossa playlist no youtube");
  }

   void mockConsultorListDefault() {
     _consultantManager.insertConsultant(1, "Luiz Augusto Silva", 36, "Sou especialista em tecnologia da informação, desenvolvimento de sistemas complexos para sua empresa!", "https://images.emojiterra.com/google/android-11/512px/1f9cd-1f3fc-2642.png", "Tecnologia da informação");
     _consultantManager.insertConsultant(2, "Luiza Soares Lima", 54, "Sou especialista em administração e formada em gestão de empresas, esperando seu contato para transformar sua empresa em multi nacional!", "https://i.pinimg.com/originals/9f/48/f8/9f48f8542532239a8a33d65f31c84984.jpg", "Administração, gestão de empresa");
     _consultantManager.insertConsultant(3, "Mariana Souza", 32, "Sou especialista em recursos humanos aguardo seu contato para que eu melhore seu setor de RH!", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSTe8AT2NTtFZMyQHtEynIDwvG8ZEJruEbTIw&usqp=CAU", "Recursos humanos");
     _consultantManager.insertConsultant(4, "Hiago Henrique de Souza", 28, "Especialista em redes de computadores, estou pronto para gerenciar suas redes com a maior perfomace!", "https://images.emojiterra.com/twitter/v13.0/512px/1f9cd-1f3fc-2642.png", "Redes de computadores");
     _consultantManager.insertConsultant(5, "Claudia Melo Lins", 23, "Especializada em engenharia mecanica, estou pronto para deixar sua empreta totalmente automatizada!", "https://image.flaticon.com/icons/png/512/3445/3445075.png", "Engenharia mecânica");
     _consultantManager.insertConsultant(6, "Maria Eduarda Figueiredo", 37, "Sou formada em administração e recursos humanos, desenvolver as admissões e demissões!", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT2XeV6ide4lAykM2LqCLm9uxajBDlQDSBQ_Q&usqp=CAU", "Administração, recursos humanos");
     _consultantManager.insertConsultant(7, "Felipe de Araújo", 39, "Sou formado em psicologia e desenvolvo atividades para melhorar o desempenhos e cuidar do psicologico dos seus empregados!", "https://images.vexels.com/media/users/3/190572/isolated/preview/3b6b824b929e3ca4f457b300cde733ed-moda-masculina-by-vexels.png", "Psicologo");
     _consultantManager.insertConsultant(8, "Roberta da Silva Melo", 28, "Sou advogada e cuidarei dos assuntos advogaticios da sua empresa!", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQEPxfYwKkPBEGiv2BEN3D2ergrQHxyyNMTDg&usqp=CAU","Roberta da Silva Melo");
     _consultantManager.insertConsultant(9, "Gustavo de Alcântara", 39, "Sou vendedor e trabalho na área de telemarketing desenvolvendo a comunicação com os clientes!", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSmRxQ2Jnbm9YGiUytHk7Ax-dHzpIUeQKj8jg&usqp=CAU", "Telemarketing");
     _consultantManager.insertConsultant(10, " Alice de Melo", 39, "Sou supervisora de vendas e responsável por desenvolver os trannes!", "https://image.flaticon.com/icons/png/512/123/123812.png", "Surpervisora em vendas");
  }
}