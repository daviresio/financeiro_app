import 'package:financeiro_app/pages/home/top_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home';

  HomePage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          TopHomePage(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Cartoes de credito',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          _card(Column(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.creditCard,
                color: Colors.black54,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22.0, bottom: 16.0),
                child: Text(
                  'Ops! Voce ainda nao tem nenhum cartao de credito cadastrado',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                'Melhore seu controle financeiro agora!',
                style: TextStyle(
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  'ADICIONAR NOVO CARTAO',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.blueAccent)
                ),
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Despesas por categoria',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          _card(Column(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.chartPie,
                color: Colors.black54,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22.0, bottom: 16.0),
                child: Text(
                  'Opa! Voce nao tem despesas cadastradas esse mes',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                'Adicione seus gastos no mes atual para ver seus graficos',
                style: TextStyle(
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Planejamento mensal',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          _card(Column(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.stickyNote,
                color: Colors.black54,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22.0, bottom: 16.0),
                child: Text(
                  'Opa! Voce nao tem um planejamento definido para este mes',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                'Melhore seu controle financeiro agora!',
                style: TextStyle(
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  'DEFINIR MEU PLANEJAMENTO',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.blueAccent)
                ),
              ),
            ],
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: () {},
              child: Padding(padding: EdgeInsets.all(50.0),
              child: Column(
                children: <Widget>[
                  Icon(FontAwesomeIcons.columns, color: Colors.black54, size: 60.0,),
                  SizedBox(height: 15.0,),
                  Text(
                    'GERENCIAR TELA INICIAL',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),),
            ),
          ),
          SizedBox(height: 60.0,),
          SvgPicture.asset('assets/vetores/home_bottom.svg', fit: BoxFit.contain, height: 300, width: 300,)
        ],
      ),
    );
  }

  Widget _card(Widget w) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 1.0,
                offset: Offset(0.0, 0.0))
          ]),
      child: w,
    );
  }
}
