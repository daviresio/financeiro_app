import 'package:financeiro_app/database/database.dart';
import 'package:financeiro_app/pages/despesa/form/calendar_form_field.dart';
import 'package:financeiro_app/pages/despesa/form/categoria_select.dart';
import 'package:financeiro_app/pages/despesa/form/conta_select.dart';
import 'package:financeiro_app/util/constantes_util.dart';
import 'package:financeiro_app/widgets/calculadora/calculadora.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'form/form_item.dart';

class DespesaPage extends StatefulWidget {
  static const routeName = '/despesa';

  @override
  _DespesaPageState createState() => _DespesaPageState();
}

class _DespesaPageState extends State<DespesaPage> {
  final _formKey = GlobalKey();

  var _despesa = Despesa().copyWith(data: DateTime.now(), pago: false, favorito: false, categoriaId: 1, contaId: 1);

  Categoria _categoriaSelecionada;
  Conta _contaSelecionada;

  bool _exibirFormularioCompleto = false;

  @override
  void initState() {
    if(_categoriaSelecionada == null) {
      _defineCategoria();
    }
    if(_contaSelecionada == null) {
      _defineConta();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showCalculadora(context);
    });

  }

  final Database _db = Database.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},
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
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('Valor da despesa', style: TextStyle(color: Colors.white),),
                          Text('R\$ 0,00', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0),),
                        ],
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
                  CalendarFormField(),
                  FormItem(Icons.textsms, Container(width: 250, height: 25.0, padding: EdgeInsets.only(top: 10.0), child:
                  TextFormField(
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
                        Text(_categoriaSelecionada?.nome ?? ''),
                      ],
                    ),
                  ), Icon(Icons.keyboard_arrow_right, color: Colors.black54,), () async {
                    dynamic result = await showCategoriaSelect(context, _despesa.categoriaId);
                    if(result != null) {
                      print(result is int);
                      print(result is Function);
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
