import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:financeiro_app/blocs/bloc_initial_page.dart';
import 'package:financeiro_app/blocs/bloc_transacoes.dart';
import 'package:financeiro_app/pages/home/home_page.dart';
import 'package:financeiro_app/pages/planejamento/planejamento_page.dart';
import 'package:financeiro_app/pages/transacoes/transacoes_page.dart';
import 'package:financeiro_app/widgets/float_button/float_button.dart';
import 'package:flutter/material.dart';

class InitalPage extends StatelessWidget {

  static const routeName = '/initial';

  final List<Widget> pages = [
    HomePage(key: PageStorageKey(HomePage.routeName)),
    TransacoesPage(key: PageStorageKey(TransacoesPage.routeName)),
    PlanejamentoPage(key: PageStorageKey(PlanejamentoPage.routeName)),
  ];

  final bucket = PageStorageBucket();

  final InitlalPageBloc _initialBloc = BlocProvider.getBloc<InitlalPageBloc>();
  final TransacoesPageBloc _transacoesBloc = BlocProvider.getBloc<TransacoesPageBloc>();

  Widget _bottomNavigationBar() => StreamBuilder<int>(
      stream: _initialBloc.currentPageIndex,
      initialData: 0,
    builder: (context, snapshot) {
      return StreamBuilder<String>(
        stream: _transacoesBloc.tipoTransacaoSelecionada,
        initialData: TransacoesConstantes.transacoes,
        builder: (context2, snapshot2) {
          return CurvedNavigationBar(
            height: 50.0,
            backgroundColor: (snapshot.data == 1 ? TransacoesConstantes.transacoesColor[snapshot2.data] : Colors.blueAccent),
            buttonBackgroundColor: Colors.grey[200],
            index: snapshot.data,
            items: <Widget>[
              Icon(Icons.add, size: 30),
              Icon(Icons.list, size: 30),
              Icon(Icons.compare_arrows, size: 30),
            ],
            onTap: _initialBloc.setPage,
          );
        }
      );
    }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomNavigationBar(),
      body: StreamBuilder<int>(
        stream: _initialBloc.currentPageIndex,
        initialData: 0,
        builder: (context, snapshot) {
          return PageStorage(bucket: bucket, child: pages[snapshot.data]);
        }
      ),
    );
  }
}
