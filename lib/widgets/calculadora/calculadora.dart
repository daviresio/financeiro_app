import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_calculadora.dart';
import 'package:flutter/material.dart';
import 'package:financeiro_app/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:math_expressions/math_expressions.dart';

Future<dynamic> showCalculadora(BuildContext context, Color color) {

  Widget _body() {
    CalculadoraBloc _bloc = BlocProvider.getBloc<CalculadoraBloc>();


    _button(String text, {Function onTap}) {
      double size = (MediaQuery.of(context).size.width / 4) - 6;
      return SizedBox(
        width: size,
        child: FlatButton(
          onPressed: () {
            if(onTap == null) {
              _bloc.adicionaValor(text);
            } else {
              try {
                onTap();
              } catch (e) {
                _bloc.reiniciar();
              }
            }
          },
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          highlightColor: color.withOpacity(0.1),
          splashColor: color.withOpacity(0.1),
          child: Text(text, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black54),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      );
    }

    double _realizaCalculos() {
      Parser p = Parser();
      Expression exp = p.parse(_bloc.valor.value == null ||  _bloc.valor.value == '' ? '0.0' : _bloc.valor.value);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      _bloc.alteraValor(eval.toString());
      return eval;
    }

    return Material(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('R\$', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black54),),
            Row(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<String>(
                      stream: _bloc.valor,
                      initialData: '',
                      builder: (context, snapshot) {
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0, bottom: 10.0, top: 10.0, left: 10.0),
                            child: (snapshot.data.length == 0 ? Text('0.0', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black26), textAlign: TextAlign.right,)
                                : Text(snapshot.data, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black54), textAlign: TextAlign.right,)
                            ),
                          ),
                        );
                      }
                  ),
                ),
                IconButton(icon: Icon(Icons.backspace, color: Colors.black54), onPressed: (){
                  _bloc.apagaValor();
                }),
              ],
            ),
            Divider(
              color: Colors.black26,
              height: 0.6,
            ),
            SizedBox(height: 20.0,),
            Row(
              children: <Widget>[
                _button('7'),
                _button('8'),
                _button('9'),
                _button('+'),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                _button('4'),
                _button('5'),
                _button('6'),
                _button('-'),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                _button('1'),
                _button('2'),
                _button('3'),
                _button('*'),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                _button('.'),
                _button('0'),
                _button('=', onTap: () {
                  _realizaCalculos();
                }),
                _button('/'),
              ],
            ),
            SizedBox(height: 80.0,),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlineButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    borderSide: BorderSide(color: color, width: 1.0),
                    splashColor: color.withOpacity(0.1),
                    highlightColor: color.withOpacity(0.1),
                    highlightedBorderColor: color,
                    child: Text('CANCELAR', style: TextStyle(color: color, fontWeight: FontWeight.bold),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(width: 20.0,),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      double value = _realizaCalculos();
                      Navigator.of(context).pop(value);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: color,
                    splashColor: Colors.white.withOpacity(0.3),
                    highlightColor: Colors.white.withOpacity(0.1),
                    child: Text('CONCLUIDO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) => roundedBottomSheet(_body(), height: 0.8,));

}