import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_transacoes.dart';
import 'package:financeiro_app/database/database.dart';
import 'package:financeiro_app/database/joins/despesa_joins.dart';
import 'package:financeiro_app/database/joins/receita_joins.dart';
import 'package:financeiro_app/pages/transacoes/widgets/empty_content.dart';
import 'package:financeiro_app/util/constantes_util.dart';
import 'package:financeiro_app/util/util.dart';
import 'package:financeiro_app/widgets/list/list_tile.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';

class TodasTransacoesPage extends StatelessWidget {

  static String routeName = '/transacoes/todas-transacoes';

  TodasTransacoesPage({Key key}): super(key: key);

  final _db = Database.instance;

  final TransacoesPageBloc _transacoesBloc = BlocProvider.getBloc<TransacoesPageBloc>();

  Stream<List<dynamic>> getData({DateTime data}) {
    Stream<List<DespesaComRelacionamentos>> streamDespesas = _db.despesaDao.listDespesasComRelacionamentos(data: data);
    Stream<List<ReceitaComRelacionamentos>> streamReceitas = _db.receitaDao.listReceitasComRelacionamentos(data: data);

    return Observable.combineLatest2(streamDespesas, streamReceitas, (a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DateTime>(
        stream: _transacoesBloc.mesSelecionado,
        initialData: DateTime.now(),
        builder: (context, snapshotMesSelecionado) {
          return StreamBuilder(
              stream: getData(data: snapshotMesSelecionado.data),
              initialData: [],
              builder: (context, snapshot) {
                if(!snapshot.hasData || snapshot.data.length == 0) return EmptyContent();
                return StreamBuilder<ReceitaComRelacionamentos>(
                    stream: _transacoesBloc.receitaSelecionada,
                    initialData: null,
                    builder: (context, receitaSelecionada) {
                      return ListView.separated(
                        itemCount: snapshot.data.length + 1,
                        itemBuilder: (context, index) {
                          if(index == 0) return Container();
                          ReceitaComRelacionamentos item = snapshot.data[index - 1];
                          bool selecionado = false;
                          if(receitaSelecionada.data != null) selecionado = item.receita.id == receitaSelecionada.data.receita.id;
                          return MyListTile(
                            onTap: () {
                             // Navigator.of(context).pushNamed(ReceitaPage.routeName, arguments: item.receita.id);
                            },
                            onLongPress: () {
                              _transacoesBloc.selecionaReceita(item);
                            },
                            selected: selecionado,
                            leading: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: (selecionado ? Colors.grey[400] : colorMapping[item.categoria.cor]),
                              ),
                              child: (selecionado ? Icon(Icons.check, color: Colors.white,) : Icon(iconMapping[item.categoria.icone], color: Colors.white, size: 16.0,)),
                            ),
                            title: Text(item.receita.nome != null && item.receita.nome != '' ? item.receita.nome : item.categoria.nome),
                            subtitle: Text('${item.categoria.nome} | ${item.conta.nome}'),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('R\$ ${item.receita.valor.toString()}', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: (item.receita.recebido ? Colors.green : Colors.green),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Icon((item.receita.recebido ? Icons.check : Icons.no_sim), color: Colors.white, size: 12.0,),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {

                          DateTime d = snapshot.data[index].receita.data;

                          String text = getTextDay(d);

                          if(index > 0 && text == getTextDay(snapshot.data[index - 1].receita.data)) return Container();

                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(text, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)));


                        },
                      );
                    }
                );
              }
          );
        },
      ),
    );
  }
}
