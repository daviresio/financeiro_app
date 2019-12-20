import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_transacoes.dart';
import 'package:financeiro_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransacoesPage extends StatelessWidget {
  static String routeName = '/transacoes';

  final TransacoesPageBloc _transacoesBloc = BlocProvider.getBloc<TransacoesPageBloc>();

  TransacoesPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            StreamBuilder<String>(
                stream: _transacoesBloc.tipoTransacaoSelecionada,
                initialData: TransacoesConstantes.transacoes,
                builder: (context, snapshot) {
                  return SliverAppBar(
                    backgroundColor: TransacoesConstantes.transacoesColor[snapshot.data],
                    floating: true,
                    pinned: true,
                    title: _renderTopPage(),
                    actions: <Widget>[
                      IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () {},),
                      IconButton(icon: Icon(FontAwesomeIcons.filter, color: Colors.white, size: 16.0,), onPressed: () {},),
                      IconButton(icon: Icon(Icons.more_horiz, color: Colors.white,), onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },),
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(130.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(icon: Icon(Icons.keyboard_arrow_left, color: Colors.white,), onPressed: _transacoesBloc.voltarMes,),
                              SizedBox(width: 20.0,),
                              StreamBuilder(
                                  stream: _transacoesBloc.mesSelecionado,
                                  initialData: DateTime.now(),
                                  builder: (context, snapshot) {
                                    return Text('${getMonth(snapshot.data.month)} ${(snapshot.data.year == DateTime.now().year ? '' : snapshot.data.year)}',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
                                  }),
                              SizedBox(width: 20.0,),
                              IconButton(icon: Icon(Icons.keyboard_arrow_right, color: Colors.white,), onPressed: _transacoesBloc.avancarMes,),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                              color: Colors.white,
                            ),
                            child:  Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: _getTopValues(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ];
        },
        body: Container(
          color: Colors.white,
              child: ListView(
                children: <Widget>[
                  SvgPicture.asset('assets/vetores/search.svg', height: 300.0, width: 300.0, fit: BoxFit.contain,),
                  Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 50.0, right: 50.0),
                    child: Text('Ops! Voce nao possui transacoes registradas.', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text('Para criar um novo item, clique no botao (+)', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black54), textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
      ),
    );
  }


  Widget _renderTopPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<String>(
              stream: _transacoesBloc.tipoTransacaoSelecionada,
              initialData: '',
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
                    _renderPopItem(TransacoesConstantes.transacoes),
                    _renderPopItem(TransacoesConstantes.despesas),
                    _renderPopItem(TransacoesConstantes.receitas),
                  ],
                  onSelected: (item) {
                    _transacoesBloc.alterarTransacaoSelecionada(item);
                  },
                );
              }
          ),
    );
  }

  PopupMenuItem _renderPopItem(String item) {
    return PopupMenuItem(
        value: item,
        child: ListTile(
          title: Text(item, style: TextStyle(color: Colors.black,),),
          leading: Container(width: 10.0, height: 10.0, margin: EdgeInsets.only(top: 6.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: TransacoesConstantes.transacoesColor[item],),),
        ));
  }



  Widget _getTopValues() {
    return StreamBuilder(
      stream: _transacoesBloc.tipoTransacaoSelecionada,
      initialData: TransacoesConstantes.transacoes,
      builder: (context, snapshot) {
        switch(snapshot.data) {
          case TransacoesConstantes.transacoes:
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.local_atm, color: Colors.black54,),
                    SizedBox(width: 10.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Saldo previsto', style: TextStyle(color: Colors.black54),),
                        StreamBuilder<double>(
                            stream: _transacoesBloc.transacoesSaldoPrevisto,
                            initialData: 0.0,
                            builder: (context, snapshot) {
                              return Text('R\$ ${snapshot.data}', style: TextStyle(fontSize: 15.0, color: (snapshot.data < 0.0 ? Colors.redAccent : Colors.green), fontWeight: FontWeight.bold),);
                            }
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.credit_card, color: Colors.black54,),
                    SizedBox(width: 10.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Balanco mensal', style: TextStyle(color: Colors.black54),),
                        StreamBuilder<double>(
                            stream: _transacoesBloc.transacoesBalancoMensal,
                            initialData: 0.0,
                            builder: (context, snapshot) {
                              return Text('R\$ ${snapshot.data}', style: TextStyle(fontSize: 15.0, color: (snapshot.data < 0.0 ? Colors.redAccent : Colors.green), fontWeight: FontWeight.bold),);
                            }
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          case TransacoesConstantes.despesas:
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.local_atm, color: Colors.black54,),
                    SizedBox(width: 10.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Total pendente', style: TextStyle(color: Colors.black54),),
                        StreamBuilder<double>(
                            stream: _transacoesBloc.despesasTotalPendente,
                            initialData: 0.0,
                            builder: (context, snapshot) {
                              return Text('R\$ ${snapshot.data}', style: TextStyle(fontSize: 15.0, color: Colors.redAccent, fontWeight: FontWeight.bold),);
                            }
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.credit_card, color: Colors.black54,),
                    SizedBox(width: 10.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Total pago', style: TextStyle(color: Colors.black54),),
                        StreamBuilder<double>(
                            stream: _transacoesBloc.despesasTotalPago,
                            initialData: 0.0,
                            builder: (context, snapshot) {
                              return Text('R\$ ${snapshot.data}', style: TextStyle(fontSize: 15.0, color: Colors.redAccent, fontWeight: FontWeight.bold),);
                            }
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          case TransacoesConstantes.receitas:
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.local_atm, color: Colors.black54,),
                    SizedBox(width: 10.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Total pendente', style: TextStyle(color: Colors.black54),),
                        StreamBuilder<double>(
                            stream: _transacoesBloc.receitasTotalPendente,
                            initialData: 0.0,
                            builder: (context, snapshot) {
                              return Text('R\$ ${snapshot.data}', style: TextStyle(fontSize: 15.0, color: Colors.green, fontWeight: FontWeight.bold),);
                            }
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.credit_card, color: Colors.black54,),
                    SizedBox(width: 10.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Total recebido', style: TextStyle(color: Colors.black54),),
                        StreamBuilder<double>(
                            stream: _transacoesBloc.receitasTotalRecebido,
                            initialData: 0.0,
                            builder: (context, snapshot) {
                              return Text('R\$ ${snapshot.data}', style: TextStyle(fontSize: 15.0, color: Colors.green, fontWeight: FontWeight.bold),);
                            }
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          default:
            return Container();
        }
      },
    );
  }






}

class TransacoesConstantes {
  static const String transacoes = 'Transacoes';
  static const String despesas = 'Despesas';
  static const String receitas = 'Receitas';

  static const Map<String, Color> transacoesColor = {
    transacoes: Colors.blueAccent,
    despesas: Colors.redAccent,
    receitas: Colors.green,
  };
}
