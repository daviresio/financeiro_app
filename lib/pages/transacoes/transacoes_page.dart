import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_transacoes.dart';
import 'package:financeiro_app/database/dao/despesa_dao.dart';
import 'package:financeiro_app/database/dao/receita_dao.dart';
import 'package:financeiro_app/database/database.dart';
import 'package:financeiro_app/database/joins/despesa_joins.dart';
import 'package:financeiro_app/pages/transacoes/pages/despesas_page.dart';
import 'package:financeiro_app/pages/transacoes/pages/receitas_page.dart';
import 'package:financeiro_app/pages/transacoes/pages/todas_transacoes_page.dart';
import 'package:financeiro_app/util/constantes_util.dart';
import 'package:financeiro_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransacoesPage extends StatelessWidget {
  static String routeName = '/transacoes';

  final TransacoesPageBloc _transacoesBloc = BlocProvider.getBloc<TransacoesPageBloc>();

  final DespesaDao _despesaDao = Database.instance.despesaDao;
  final ReceitaDao _receitaDao = Database.instance.receitaDao;
  var _db = Database.instance;

  double _editWidgetHeight = 60.0;

  TransacoesPage({Key key}): super(key: key);

  final bucket = PageStorageBucket();

  final Map<String, Widget> pages = {
    TransacoesConstantes.transacoes: TodasTransacoesPage(key: PageStorageKey(TodasTransacoesPage.routeName)),
    TransacoesConstantes.despesas: DespesasPage(key: PageStorageKey(DespesasPage.routeName)),
    TransacoesConstantes.receitas: ReceitasPage(key: PageStorageKey(ReceitasPage.routeName)),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(),
      body: StreamBuilder<String>(
        stream: _transacoesBloc.tipoTransacaoSelecionada,
        initialData: TransacoesConstantes.transacoes,
        builder: (context, snapshot) {
          return StreamBuilder<DespesaComRelacionamentos>(
            stream: _transacoesBloc.despesaSelecionada,
            initialData: null,
            builder: (context, despesa) {
              return StreamBuilder(
                  stream: _transacoesBloc.mesSelecionado,
                  initialData: DateTime.now(),
                  builder: (context, mesSnapshot) {
                    return Stack(
                children: <Widget>[
                  NestedScrollView(
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                              SliverAppBar(
                                backgroundColor: TransacoesConstantes.transacoesColor[snapshot.data],
                                floating: true,
                                pinned: true,
                                title: _renderTopPage(posicaoNormal: despesa.data == null),
                                actions: <Widget>[
                                  IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () {},),
                                  IconButton(icon: Icon(FontAwesomeIcons.filter, color: Colors.white, size: 16.0,), onPressed: () {},),
                                  IconButton(icon: Icon(Icons.more_horiz, color: Colors.white,), onPressed: () {
                                    Scaffold.of(context).openEndDrawer();
                                  },),
                                ],
                                bottom: PreferredSize(
                                  preferredSize: Size.fromHeight(130),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          IconButton(icon: Icon(Icons.keyboard_arrow_left, color: Colors.white,), onPressed: _transacoesBloc.voltarMes,),
                                          SizedBox(width: 20.0,),
                                          Text('${getMonth(mesSnapshot.data.month)} ${(mesSnapshot.data.year == DateTime.now().year ? '' : mesSnapshot.data.year)}',
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
                                            child: _getTopValues(mesSnapshot.data),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ];
                    },
                    body: PageStorage(bucket: bucket, child: pages[snapshot.data]),
                  ),
                  (despesa.data == null ?
                  Container() :
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    child: Container(
                      height: _editWidgetHeight,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconButton(icon: Icon(Icons.arrow_back, color: Colors.black54,), onPressed: () {
                                _transacoesBloc.removeDespesaSelecionada();
                              }),
                              SizedBox(width: 20.0,),
                              Text('R\$ ${despesa.data.despesa.valor.toString()}', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20.0),),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(icon: Icon(Icons.check, color: Colors.black54,), onPressed: () {
                                _transacoesBloc.removeDespesaSelecionada();
                              }),
                              PopupMenuButton(
                                onSelected: (i) async {
                                  switch(i) {
                                    case 0:
                                      await showDialog(context: context, builder: (context) => AlertDialog(
                                        title: Text('Selecione a categoria'),
                                        content: StreamBuilder<List<Categoria>>(
                                            stream: _db.categoriaDao.listCategorias(),
                                            builder: (context, snapshot) {
                                              if(!snapshot.hasData) return Container();
                                              return Container(
                                                height: 300.0,
                                                width: 250.0,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data.length,
                                                  itemBuilder: (context, index) {
                                                    var item = snapshot.data[index];
                                                    return ListTile(
                                                      contentPadding: EdgeInsets.all(2.0),
                                                      onTap: () async {
                                                        await _db.despesaDao.updateDespesa(despesa.data.despesa.copyWith(categoriaId: snapshot.data[index].id));
                                                        Navigator.of(context).pop();
                                                      },
                                                      leading: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                            color: colorMapping[item.cor],
                                                            borderRadius: BorderRadius.circular(30.0),
                                                          ),
                                                          child: Icon(iconMapping[item.icone], color: Colors.white, size: 12.0,)),
                                                      title: Text(item.nome),
                                                    );
                                                  },),
                                              );
                                            }
                                        ),
                                      ),
                                      );
                                      break;
                                    case 3:
                                      await showDialog(context: context, builder: (context) => AlertDialog(
                                        title: Text('Deseja realmente excluir?'),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }, child: Text('Nao', style: TextStyle(color: Colors.blueAccent),),
                                          ),
                                          FlatButton(
                                            onPressed: () async {
                                              await _despesaDao.deleteDespesa(despesa.data.despesa.id);
                                              Navigator.of(context).pop();
                                            }, child: Text('Sim', style: TextStyle(color: Colors.blueAccent),),
                                          ),
                                        ],
                                      ));
                                      break;
                                  }
                                  _transacoesBloc.removeDespesaSelecionada();
                                },
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: Text('Editar categoria'),
                                      value: 0,
                                    ),
                                    PopupMenuItem(
                                      child: Text('Editar conta'),
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      child: Text('Editar tags'),
                                      value: 2,
                                    ),
                                    PopupMenuItem(
                                      child: Text('Deletar'),
                                      value: 3,
                                    ),
                                  ];
                                },
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                  )
                  ),
                ],
                    );
                  }
              );
            }
          );
        }
      ),
    );
  }


  Widget _renderTopPage({bool posicaoNormal = true}) {
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



  Widget _getTopValues(DateTime d) {

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
                        Text((d.month == DateTime.now().month && d.year == DateTime.now().year) ? 'Saldo Atual' : 'Saldo previsto', style: TextStyle(color: Colors.black54),),
                        StreamBuilder<double>(
                            stream: _transacoesBloc.transacoesSaldoPrevisto(),
                            initialData: 0.0,
                            builder: (context, saldoPrevistoSnapshot) {
                              return Text('R\$ ${saldoPrevistoSnapshot.data}', style: TextStyle(fontSize: 15.0, color: (saldoPrevistoSnapshot.data < 0.0 ? Colors.redAccent : Colors.green), fontWeight: FontWeight.bold),);
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
                            stream: _transacoesBloc.transacoesBalancoMensal(d),
                            initialData: 0.0,
                            builder: (context, balancoMensalSnapshot) {
                              return Text('R\$ ${balancoMensalSnapshot.data}', style: TextStyle(fontSize: 15.0, color: (balancoMensalSnapshot.data < 0.0 ? Colors.redAccent : Colors.green), fontWeight: FontWeight.bold),);
                            }
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          case TransacoesConstantes.despesas:
            return StreamBuilder<DateTime>(
              stream: _transacoesBloc.mesSelecionado,
              initialData: DateTime.now(),
              builder: (context, snapshot) {
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
                                stream: _despesaDao.totalPagoOuPendente(pago: false, data: snapshot.data),
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
                                stream: _despesaDao.totalPagoOuPendente(pago: true, data: snapshot.data),
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
              }
            );
          case TransacoesConstantes.receitas:
            return StreamBuilder<DateTime>(
                stream: _transacoesBloc.mesSelecionado,
                initialData: DateTime.now(),
                builder: (context, snapshot) {
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
                                  stream: _receitaDao.totalRecebidoOuPendente(recebido: false, data: snapshot.data),
                                  initialData: 0.0,
                                  builder: (context, snapshot) {
                                    return Text('R\$ ${snapshot.data ?? 0.0}', style: TextStyle(fontSize: 15.0, color: Colors.green, fontWeight: FontWeight.bold),);
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
                                  stream: _receitaDao.totalRecebidoOuPendente(recebido: true, data: snapshot.data),
                                  initialData: 0.0,
                                  builder: (context, snapshot) {
                                    return Text('R\$ ${snapshot.data ?? 0.0}', style: TextStyle(fontSize: 15.0, color: Colors.green, fontWeight: FontWeight.bold),);
                                  }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }
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
