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

  Stream<List<DadosTodasTransacoes>> getData({DateTime data}) {
    Stream<List<DadosTodasTransacoes>> streamDespesas = _db.despesaDao.listDespesasComRelacionamentos(data: data).map((List<DespesaComRelacionamentos> s) => s.map((v) =>
        DadosTodasTransacoes(id: v.despesa.id, valor: v.despesa.valor, categoria: v.categoria, conta: v.conta, data: v.despesa.data, isEfetivado: v.despesa.pago, isReceita: false, nome: v.despesa.nome)).toList());

    Stream<List<DadosTodasTransacoes>> streamReceitas = _db.receitaDao.listReceitasComRelacionamentos(data: data).map((List<ReceitaComRelacionamentos> s) => s.map((v) =>
        DadosTodasTransacoes(id: v.receita.id, valor: v.receita.valor, categoria: v.categoria, conta: v.conta, data: v.receita.data, isEfetivado: v.receita.recebido, isReceita: true, nome: v.receita.nome)).toList());


    StreamController<List<DadosTodasTransacoes>> combinedStrem = StreamController<List<DadosTodasTransacoes>>();
    List<DadosTodasTransacoes> lastDespesas = [];
    List<DadosTodasTransacoes> lastReceitas = [];

    streamDespesas.listen((onData) {
      lastDespesas = onData;
      onData.addAll(lastReceitas);
      onData.sort((a, b) => a.data.compareTo(b.data));
      combinedStrem.sink.add(onData);
    });

    streamReceitas.listen((onData) {
      lastReceitas = onData;
      onData.addAll(lastDespesas);
      onData.sort((a, b) => a.data.compareTo(b.data));
      combinedStrem.sink.add(onData);
    });

    return combinedStrem.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DateTime>(
        stream: _transacoesBloc.mesSelecionado,
        initialData: DateTime.now(),
        builder: (context, snapshotMesSelecionado) {
          return StreamBuilder <List<DadosTodasTransacoes>>(
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
                          DadosTodasTransacoes item = snapshot.data[index - 1];
                          //print(item.toString());
                          bool selecionado = false;
                         // if(receitaSelecionada.data != null) selecionado = item.receita.id == receitaSelecionada.data.receita.id;
                          return MyListTile(
                            onTap: () {
                             // Navigator.of(context).pushNamed(ReceitaPage.routeName, arguments: item.receita.id);
                            },
                            onLongPress: () {
                             // _transacoesBloc.selecionaReceita(item);
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
                            title: Text(item.nome != null && item.nome != '' ? item.nome : item.categoria.nome),
                            subtitle: Text('${item.categoria.nome} | ${item.conta.nome}'),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('R\$ ${item.valor.toString()}', style: TextStyle(color: (item.isReceita ? Colors.green : Colors.redAccent), fontWeight: FontWeight.bold),),
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: item.isEfetivado ? Colors.green : Colors.green,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Icon(item.isEfetivado ? Icons.check : Icons.no_sim, color: Colors.white, size: 12.0,),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {

                          var item = snapshot.data[index];

                          DateTime d = item.data;

                          String text = getTextDay(d);

                          if(index > 0 && text == getTextDay(d)) return Container();

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


class DadosTodasTransacoes {

  final int id;
  final String nome;
  final DateTime data;
  final bool isReceita;
  final bool isEfetivado;
  final Categoria categoria;
  final Conta conta;
  final double valor;

  DadosTodasTransacoes({this.id, this.nome, this.data, this.isReceita, this.isEfetivado, this.categoria, this.conta, this.valor});

  @override
  String toString() {
    return 'DadosTodasTransacoes{id: $id, nome: $nome, data: $data, isReceita: $isReceita, isEfetivado: $isEfetivado, categoria: $categoria, conta: $conta, valor: $valor}';
  }


}