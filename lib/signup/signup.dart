import 'package:flutter/material.dart';

class SignUpImages extends StatefulWidget {
  SignUpImages(this.parentAction);
  final ValueChanged<List<dynamic>> parentAction;
  @override
  State<StatefulWidget> createState() => _SignUpImages();
}

class _SignUpImages extends State<SignUpImages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.all(
            Radius.circular(25.0)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 28.0, bottom: 28.0),
        child: SingleChildScrollView (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                  "SEJA BEM-VINDO(A) À HotCourse! ‍Apresentamos os Termos de Uso do domínio digital HotCourse. "
                      "Os serviços do HotCourse são fornecidos pela pessoa juridica ou fisica"
                      "com a seguinte Razão social HotCourse LTDA com o nome fantasia HotCourse"
                      "Inscrito no CNPJ 123.456/0001-21, titular da propriedade intelectual sobre software"
                      "Sugerimos, também, a leitura atenta de nossa Política de Privacidade, também disponível nessa mesma página. "
                      "Apresentamos os Termos de Uso da plataforma digital de private label – "
                      "HotCourse. Sugerimos, também, a leitura atenta de nossa Política de Privacidade, "
                      "facilmente localizada através desse link: https://www.HotCourse.com/politica-de-privacidade. Para melhor organizar as informações, "
                      "arrolamos, na sequência, os principais pontos deste Termo de Uso, mas destacamos ser muito importante a leitura da integralidade desse documento: "
                      "Todo o relacionamento e interação dos Usuários com a plataforma HotCourse é realizada de forma digital e online. "
                      "O Usuário não pagará qualquer tarifa pela a utilização da plataforma HotCourse. "
                      "Para utilizar a plataforma HotCourse o Usuário baixa o aplicativo na loja virtual do seu smartphone, informa o número do seu CPF, "
                      "e cria uma senha pessoal, sigilosa e intransferível. O Usuário não deve, em hipótese alguma, "
                      "divulgar essa senha para terceiros e é o único responsável pelo uso não autorizado da senha cadastrada."),
            ],
          ),
        ),
      ),
    );
  }
}