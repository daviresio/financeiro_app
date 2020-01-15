import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_transacoes.dart';
import 'package:financeiro_app/database/dao/despesa_dao.dart';
import 'package:financeiro_app/database/database.dart';
import 'package:financeiro_app/database/joins/despesa_joins.dart';
import 'package:financeiro_app/pages/despesa/despesa_page.dart';
import 'package:financeiro_app/pages/transacoes/widgets/empty_content.dart';
import 'package:financeiro_app/util/util.dart';
import 'package:financeiro_app/widgets/list/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:financeiro_app/util/constantes_util.dart';

class DespesasPage extends StatelessWidget {

  static String routeName = '/transacoes/despesas';

  DespesasPage({Key key}): super(key: key);

  final DespesaDao _despesaDao = Database.instance.despesaDao;

  final TransacoesPageBloc _transacoesBloc = BlocProvider.getBloc<TransacoesPageBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DateTime>(
        stream: _transacoesBloc.mesSelecionado,
        initialData: DateTime.now(),
        builder: (context, snapshotMesSelecionado) {
          return StreamBuilder(
              stream: _despesaDao.listDespesasComRelacionamentos(data: snapshotMesSelecionado.data),
              initialData: [],
              builder: (context, snapshot) {
                if(!snapshot.hasData || snapshot.data.length == 0) return EmptyContent();
                return StreamBuilder<DespesaComRelacionamentos>(
                  stream: _transacoesBloc.despesaSelecionada,
                  initialData: null,
                  builder: (context, despesaSelecionada) {
                    return ListView.separated(
                      itemCount: snapshot.data.length + 1,
                      itemBuilder: (context, index) {
                        if(index == 0) return Container();
                        DespesaComRelacionamentos item = snapshot.data[index - 1];
                        bool selecionado = false;
                        if(despesaSelecionada.data != null) selecionado = item.despesa.id == despesaSelecionada.data.despesa.id;
                        return MyListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(DespesaPage.routeName, arguments: item.despesa.id);
                          },
                          onLongPress: () {
                            _transacoesBloc.selecionaDespesa(item);
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
                          title: Text(item.despesa.nome != null && item.despesa.nome != '' ? item.despesa.nome : item.categoria.nome),
                          subtitle: Text('${item.categoria.nome} | ${item.conta.nome}'),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('R\$ ${item.despesa.valor.toString()}', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),),
                              Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  color: (item.despesa.pago ? Colors.green : Colors.redAccent),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Icon((item.despesa.pago ? Icons.check : Icons.no_sim), color: Colors.white, size: 12.0,),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {

                        DateTime d = snapshot.data[index].despesa.data;

                        String text = getTextDay(d);

                        if(index > 0 && text == getTextDay(snapshot.data[index - 1].despesa.data)) return Container();

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


