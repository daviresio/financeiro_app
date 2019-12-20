import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:financeiro_app/blocs/bloc_planejamento.dart';
import 'package:financeiro_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlanejamentoPage extends StatelessWidget {
  static String routeName = '/planejamento';

  final PlanejamentoPageBloc _planejamentoBloc = BlocProvider.getBloc<PlanejamentoPageBloc>();

  PlanejamentoPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget> [
              SliverAppBar(
                backgroundColor: Colors.blueAccent,
                floating: true,
                pinned: true,
                title: _renderTopPage(),
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.delete, color: Colors.white,), onPressed: () {},),
                  PopupMenuButton(
                    itemBuilder: (context) => [

                    ],
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.keyboard_arrow_left, color: Colors.white,), onPressed: _planejamentoBloc.voltarMes,),
                      SizedBox(width: 20.0,),
                      StreamBuilder(
                          stream: _planejamentoBloc.mesSelecionado,
                          initialData: DateTime.now(),
                          builder: (context, snapshot) {
                            return Text('${getMonth(snapshot.data.month)} ${(snapshot.data.year == DateTime.now().year ? '' : snapshot.data.year)}',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
                          }),
                      SizedBox(width: 20.0,),
                      IconButton(icon: Icon(Icons.keyboard_arrow_right, color: Colors.white,), onPressed: _planejamentoBloc.avancarMes,),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Stack(
            children: <Widget>[
              Container(
                color: Colors.blueAccent,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), )
                ),
              child: ListView(
                children: <Widget>[
                  SvgPicture.asset('assets/vetores/cofrinho.svg', height: 300.0, width: 300.0, fit: BoxFit.contain,),
                  Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 50.0, right: 50.0),
                    child: Text('Ops!', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text('Nenhum planejamento definido para este mes,', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black54), textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: RaisedButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        child: Text('DEFINIR NOVO PLANEJAMENTO', style: TextStyle(color: Colors.white),),
                        onPressed: (){}
                    ),
                  ),
                ],
              ),
              ),
            ],
          ),
      ),
    );
  }



  Widget _renderTopPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<String>(
              stream: _planejamentoBloc.tipoPlanejamento,
              initialData: PlanejamentoConstants.planejamentoMensal,
              builder: (context, snapshot) {
                return PopupMenuButton(
                  child: Row(
                    children: <Widget>[
                      Text(
                        snapshot.data,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: PlanejamentoConstants.planejamentoMensal,
                      child: ListTile(
                        title: Text(PlanejamentoConstants.planejamentoMensal),
                      ),
                    ),
                    PopupMenuItem(
                      value: PlanejamentoConstants.planejamentoPersonalizado,
                      child: ListTile(
                        title: Text(PlanejamentoConstants.planejamentoPersonalizado),
                      ),
                    ),
                  ],
                  onSelected: (item) {
                    _planejamentoBloc.alteraTipoPlanejamento(item);
                  },
                );
              }
          ),
    );
  }
}


class PlanejamentoConstants {
  static const planejamentoMensal = 'Mensal';
  static const planejamentoPersonalizado = 'Personalizado';
}
