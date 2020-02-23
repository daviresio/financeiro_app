import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_calculadora.dart';
import 'package:financeiro_app/blocs/bloc_despesa.dart';
import 'package:financeiro_app/database/database.dart';
import 'package:financeiro_app/pages/despesa/widgets//calendar_form_field.dart';
import 'package:financeiro_app/pages/despesa/widgets/categoria_select.dart';
import 'package:financeiro_app/pages/despesa/widgets/conta_select.dart';
import 'package:financeiro_app/util/constantes_util.dart';
import 'package:financeiro_app/util/util.dart';
import 'package:financeiro_app/widgets/calculadora/calculadora.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/form_item.dart';

class DespesaPage extends StatefulWidget {

  static const routeName = '/despesa';

  @override
  _DespesaPageState createState() => _DespesaPageState();
}

class _DespesaPageState extends State<DespesaPage> {
  final _formKey = GlobalKey();

  var _despesa = Despesa().copyWith(pago: true, favorito: false, contaId: 1);

  Categoria _categoriaSelecionada;
  Subcategoria _subcategoriaSelecionada;
  Conta _contaSelecionada;

  bool _exibirFormularioCompleto = false;

  CalculadoraBloc _blocCalculadora = BlocProvider.getBloc<CalculadoraBloc>();
  DespesaBloc _blocDespesa = BlocProvider.getBloc<DespesaBloc>();

  var _db = Database.instance;

  TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {

    if(_categoriaSelecionada == null) {
      _defineCategoria();
    }
    if(_contaSelecionada == null) {
      _defineConta();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      int id = ModalRoute.of(context).settings.arguments;

      if(id == null) {
        _blocDespesa.alteraData(DateTime.now());
        await _db.categoriaDao.listCategoriasDespesas().listen((onData) {
          var id = onData[0]?.id;
          setState(() {
            _despesa = _despesa.copyWith(categoriaId: id ?? 0);
            _defineCategoria();
          });
        });
        await Future.delayed(Duration(milliseconds: 300));
        _abreCalculadora();
      } else {
        var v = await _db.despesaDao.find(id);
        _descricaoController.text = v.nome;
       _blocDespesa.alteraData(v.data);
       _blocDespesa.alteraValor(v.valor.toString());
        setState(() {
          _despesa = v;
          _defineCategoria();
          _defineConta();
        });
      }

    });

  }


  _abreCalculadora() async {
    _blocCalculadora.reiniciar();
    var v = await showCalculadora(context, Colors.redAccent);
    if(v != null) {
      _blocDespesa.alteraValor(v.toString());
      setState(() {
        _despesa = _despesa.copyWith(valor: v);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        double media = await _db.despesaDao.getMediaValorPorCategoria(_despesa.categoriaId);
        DateTime data = _blocDespesa.data.value;
        _despesa = _despesa.copyWith(nome: _descricaoController.text, data: data);
        if(_despesa.id == null || _despesa.id == 0) {
          await _db.despesaDao.insertDespesa(_despesa);
        } else {
          await _db.despesaDao.updateDespesa(_despesa);
        }

        if(_despesa.valor > media && media > 0) {
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Voce pode economizar', style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold),),
                  content: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('${_subcategoriaSelecionada != null ? _categoriaSelecionada.nome : _categoriaSelecionada.nome} - ${formatDateDayMonthYear(_despesa.data)}', style: TextStyle(),),
                          Text('R\$ ${_despesa.valor}', style: TextStyle(color: Colors.redAccent),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Media dessa despesa', style: TextStyle(color: Colors.orange),),
                          Text('R\$ $media', style: TextStyle(color: Colors.orange),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Aumento em valor', style: TextStyle(color: Colors.blueAccent),),
                          Text('R\$ ${_despesa.valor - media}', style: TextStyle(color: Colors.blueAccent),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Aumento em porcentagem', style: TextStyle(color: Colors.green,),),
                          Text('% ', style: TextStyle(color: Colors.green,),),
                        ],
                      ),
                      Divider(height: 1.0, color: Colors.black54,),
                      SizedBox(height: 20.0,),
                      CheckboxListTile(value: true, onChanged: (v) {}, title: Text('Analise inteligente ativada'), selected: true, activeColor: Colors.redAccent,),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: Text('ENTENDI', style: TextStyle(color: Colors.redAccent),)),
                  ],
                );
              }
          );
        }

        Navigator.of(context).pop();

      },
        child: Icon(Icons.check),
        backgroundColor: Colors.redAccent,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.redAccent,
              title: Text('Nova despesa', style: TextStyle(fontWeight: FontWeight.bold),),
              floating: true,
              pinned: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.red,
                          highlightColor: Colors.red.withOpacity(0.4),
                          onTap: () {
                            _abreCalculadora();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Valor da despesa', style: TextStyle(color: Colors.white),),
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 20.0,),
                                    StreamBuilder<String>(
                                      stream: _blocDespesa.valor,
                                      initialData: '0.0',
                                      builder: (context, snapshot) {
                                        return Text('R\$ ${snapshot.data}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0),);
                                      }
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text('BRL', style: TextStyle(color: Colors.white.withOpacity(0.6)),),
                          Icon(Icons.arrow_drop_down, color: Colors.white.withOpacity(0.6)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: Container(
          color: Colors.redAccent,
          padding: EdgeInsets.only(top: 8.0),
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(top: 16.0, left: 30.0, right: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), ),
              ),
              child: ListView(
                children: <Widget>[
                  FormItem(Icons.check_circle_outline, Text((_despesa.pago ? 'Pago' : 'Nao foi pago')), Switch(activeColor: Colors.redAccent, value: _despesa.pago, onChanged: (v) => setState(()=> _despesa = _despesa.copyWith(pago: v)),), () => setState(()=> _despesa = _despesa.copyWith(pago: !_despesa.pago))),
                  CalendarFormField(Colors.redAccent, _blocDespesa),
                  FormItem(Icons.textsms, Container(width: 250, height: 25.0, padding: EdgeInsets.only(top: 10.0), child:
                  TextFormField(
                    controller: _descricaoController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Descricao'
                    ),
                  )
                  ), GestureDetector(child: (_despesa.favorito ? Icon(Icons.favorite, color: Colors.redAccent,) : Icon(Icons.favorite_border, color: Colors.black54,)), onTap: () => setState(() => _despesa = _despesa.copyWith(favorito: !_despesa.favorito))), () {}),
                  FormItem(Icons.bookmark_border, Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    decoration: _categoriaSelecionada != null ? BoxDecoration(
                      border: Border.all(width: 1.0, color: colorMapping[_categoriaSelecionada.cor]),
                      borderRadius: BorderRadius.circular(20.0),
                    ) : BoxDecoration(),
                    child: Row(
                      children: <Widget>[
                        (_categoriaSelecionada != null ? Icon(iconMapping[_categoriaSelecionada.icone], color: colorMapping[_categoriaSelecionada.cor], size: 16.0,) : Container()),
                        SizedBox(width: 10.0,),
                        Text(_subcategoriaSelecionada != null ? '${_categoriaSelecionada.nome} > ${_subcategoriaSelecionada.nome}' : _categoriaSelecionada?.nome ?? ''),
                      ],
                    ),
                  ), Icon(Icons.keyboard_arrow_right, color: Colors.black54,), () async {
                    dynamic result = await showCategoriaSelect(context, _despesa.categoriaId, 'despesa');
                    if(result != null) {
                      if (result is Function) {
                        var novaCategoria = await result(context);
                        print(novaCategoria);
                        if (novaCategoria != null) {
                          setState(() {
                            _despesa =
                                _despesa.copyWith(categoriaId: novaCategoria);
                            _defineCategoria();
                          });
                        }
                      } else if (result is int) {
                        setState(() {
                          _despesa = _despesa.copyWith(categoriaId: result);
                          _defineCategoria();
                        });
                      }
                    }
                  }),
                  FormItem(Icons.account_balance_wallet, Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    decoration: _contaSelecionada != null ? BoxDecoration(
                      border: Border.all(width: 1.0, color: colorMapping[_contaSelecionada.cor]),
                      borderRadius: BorderRadius.circular(20.0),
                    ) : BoxDecoration(),
                    child: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.moneyBillAlt, color: colorMapping[_contaSelecionada?.cor ?? 'blue'], size: 16.0,),
                        SizedBox(width: 10.0,),
                        Text(_contaSelecionada?.nome ?? ''),
                      ],
                    ),
                  ), Icon(Icons.keyboard_arrow_right, color: Colors.black54,), () async {
                    int contaId = await showContaSelect(context, _despesa.contaId);
                    if(contaId != null) {
                      setState(() {
                        _despesa =
                            _despesa.copyWith(contaId: contaId);
                        _defineConta();
                      });
                    }
                  }),
                  (_exibirFormularioCompleto ? Column(
                    children: <Widget> [
                    FormItem(Icons.attach_file, Container(), Container(), () {}),
                    FormItem(Icons.location_on, Container(), Container(), () {}),
                    FormItem(Icons.gps_not_fixed, Container(), Container(), () {}),
                    FormItem(Icons.autorenew, Container(), Container(), () {}),
                    FormItem(Icons.edit, Container(), Container(), () {}),
                    FormItem(Icons.label_outline, Container(), Container(), () {}),
                    FormItem(Icons.alarm, Container(), Container(), () {}),
                      SizedBox(height: 60.0,)
                  ])
                      : Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _exibirFormularioCompleto = true;
                        });
                      },
                      highlightColor: Colors.redAccent.withOpacity(0.2),
                      child: Text('MAIS DETALHES', style: TextStyle(color: Colors.redAccent),),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _defineCategoria() {
    _db.categoriaDao.find(_despesa.categoriaId).then((onValue) {
      if(_despesa.subcategoriaId != null) {
        _db.subcategoriaDao.find(_despesa.subcategoriaId).then((onValue2) {
          setState(() {
            _subcategoriaSelecionada = onValue2;
          });
        });
      }
      setState(() {
        _categoriaSelecionada = onValue;
      });
    });
  }

  void _defineConta() {
    _db.contaDao.find(_despesa.contaId).then((onValue) {
      setState(() {
        _contaSelecionada = onValue;
      });
    });
  }

}
