import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_calculadora.dart';
import 'package:financeiro_app/blocs/bloc_receita.dart';
import 'package:financeiro_app/pages/despesa/widgets/calendar_form_field.dart';
import 'package:financeiro_app/pages/despesa/widgets/categoria_select.dart';
import 'package:financeiro_app/pages/despesa/widgets/conta_select.dart';
import 'package:financeiro_app/pages/despesa/widgets/form_item.dart';
import 'package:financeiro_app/util/constantes_util.dart';
import 'package:financeiro_app/widgets/calculadora/calculadora.dart';
import 'package:flutter/material.dart';
import 'package:financeiro_app/database/database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReceitaPage extends StatefulWidget {

  static const routeName = '/receita';

  @override
  _ReceitaPageState createState() => _ReceitaPageState();
}

class _ReceitaPageState extends State<ReceitaPage> {

  final _formKey = GlobalKey();

  var _receita = Receita().copyWith(recebido: true, favorito: false, contaId: 1);

  Categoria _categoriaSelecionada;
  Subcategoria _subcategoriaSelecionada;
  Conta _contaSelecionada;

  bool _exibirFormularioCompleto = false;

  CalculadoraBloc _blocCalculadora = BlocProvider.getBloc<CalculadoraBloc>();
  ReceitaBloc _blocReceita = BlocProvider.getBloc<ReceitaBloc>();

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
        _blocReceita.alteraData(DateTime.now());
        await _db.categoriaDao.listCategoriasReceitas().listen((onData) {
          var id = onData[0]?.id;
          setState(() {
            _receita = _receita.copyWith(categoriaId: id ?? 0);
            _defineCategoria();
          });
        });
        await Future.delayed(Duration(milliseconds: 300));
        _abreCalculadora();
      } else {
        var v = await _db.receitaDao.find(id);
        _descricaoController.text = v.nome;
        _blocReceita.alteraData(v.data);
        _blocReceita.alteraValor(v.valor.toString());
        setState(() {
          _receita = v;
          _defineCategoria();
          _defineConta();
        });
      }
          
    });

  }
  
  _abreCalculadora() async {
    _blocCalculadora.reiniciar();
    var v = await showCalculadora(context, Colors.green);
    if(v != null) {
      _blocReceita.alteraValor(v.toString());
      setState(() {
        _receita = _receita.copyWith(valor: v);
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {

        DateTime data = _blocReceita.data.value;
        _receita = _receita.copyWith(nome: _descricaoController.text, data: data);
        if(_receita.id == null || _receita.id == 0) {
          await _db.receitaDao.add(_receita);
        } else {
          await _db.receitaDao.updat(_receita);
        }

        Navigator.of(context).pop();

      },
        child: Icon(Icons.check),
        backgroundColor: Colors.green,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.green,
              title: Text('Nova receita', style: TextStyle(fontWeight: FontWeight.bold),),
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
                          splashColor: Colors.green,
                          highlightColor: Colors.green.withOpacity(0.4),
                          onTap: () {
                            _abreCalculadora();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Valor da receita', style: TextStyle(color: Colors.white),),
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 20.0,),
                                    StreamBuilder<String>(
                                        stream: _blocReceita.valor,
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
          color: Colors.green,
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
                  FormItem(Icons.check_circle_outline, Text((_receita.recebido ? 'Pago' : 'Nao foi pago')), Switch(activeColor: Colors.green, value: _receita.recebido, onChanged: (v) => setState(()=> _receita = _receita.copyWith(recebido: v)),), () => setState(()=> _receita = _receita.copyWith(recebido: !_receita.recebido))),
                  CalendarFormField(Colors.green, _blocReceita),
                  FormItem(Icons.textsms, Container(width: 250, height: 25.0, padding: EdgeInsets.only(top: 10.0), child:
                  TextFormField(
                    controller: _descricaoController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Descricao'
                    ),
                  )
                  ), GestureDetector(child: (_receita.favorito ? Icon(Icons.favorite, color: Colors.green,) : Icon(Icons.favorite_border, color: Colors.black54,)), onTap: () => setState(() => _receita = _receita.copyWith(favorito: !_receita.favorito))), () {setState(() => _receita = _receita.copyWith(favorito: !_receita.favorito));}),
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
                    dynamic result = await showCategoriaSelect(context, _receita.categoriaId, 'receita');
                    if(result != null) {
                      if (result is Function) {
                        var novaCategoria = await result(context);
                        print(novaCategoria);
                        if (novaCategoria != null) {
                          setState(() {
                            _receita =
                                _receita.copyWith(categoriaId: novaCategoria);
                            _defineCategoria();
                          });
                        }
                      } else if (result is int) {
                        setState(() {
                          _receita = _receita.copyWith(categoriaId: result);
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
                    int contaId = await showContaSelect(context, _receita.contaId);
                    if(contaId != null) {
                      setState(() {
                        _receita =
                            _receita.copyWith(contaId: contaId);
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
                      highlightColor: Colors.green.withOpacity(0.2),
                      child: Text('MAIS DETALHES', style: TextStyle(color: Colors.green),),
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
    _db.categoriaDao.find(_receita.categoriaId).then((onValue) {
      if(_receita.subcategoriaId != null) {
        _db.subcategoriaDao.find(_receita.subcategoriaId).then((onValue2) {
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
    _db.contaDao.find(_receita.contaId).then((onValue) {
      setState(() {
        _contaSelecionada = onValue;
      });
    });
  }
  
}
