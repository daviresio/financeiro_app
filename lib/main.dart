import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_calculadora.dart';
import 'package:financeiro_app/blocs/bloc_despesa.dart';
import 'package:financeiro_app/blocs/bloc_home.dart';
import 'package:financeiro_app/blocs/bloc_categoria.dart';
import 'package:financeiro_app/blocs/bloc_receita.dart';
import 'package:financeiro_app/blocs/bloc_transacoes.dart';
import 'package:financeiro_app/pages/despesa/despesa_page.dart';
import 'package:financeiro_app/pages/home/home_page.dart';
import 'package:financeiro_app/pages/initial_page.dart';
import 'package:financeiro_app/pages/planejamento/planejamento_page.dart';
import 'package:financeiro_app/pages/receita/receita_page.dart';
import 'package:financeiro_app/pages/transacoes/transacoes_page.dart';
import 'package:flutter/material.dart';

import 'blocs/bloc_initial_page.dart';
import 'blocs/bloc_planejamento.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => HomePageBloc()),
        Bloc((i) => TransacoesPageBloc()),
        Bloc((i) => PlanejamentoPageBloc()),
        Bloc((i) => InitlalPageBloc()),
        Bloc((i) => NovaCategoriaBloc()),
        Bloc((i) => ListaCategoriaBloc()),
        Bloc((i) => CalculadoraBloc()),
        Bloc((i) => DespesaBloc()),
        Bloc((i) => ReceitaBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          fontFamily: 'Varela Round',
        ),
          initialRoute: InitalPage.routeName,
        routes: {
          InitalPage.routeName: (context) => InitalPage(),
          HomePage.routeName: (context) => HomePage(),
          TransacoesPage.routeName: (context) => TransacoesPage(),
          PlanejamentoPage.routeName: (context) => PlanejamentoPage(),
          DespesaPage.routeName: (context) => DespesaPage(),
          ReceitaPage.routeName: (context) => ReceitaPage(),
        },
      ),
    );
  }
}
