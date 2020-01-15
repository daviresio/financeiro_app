import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_initial_page.dart';
import 'package:financeiro_app/blocs/bloc_transacoes.dart';
import 'package:financeiro_app/pages/despesa/despesa_page.dart';
import 'package:financeiro_app/pages/receita/receita_page.dart';
import 'package:financeiro_app/pages/transacoes/transacoes_page.dart';
import 'package:flutter/material.dart';

class FloatButton extends StatefulWidget {
  @override
  _FloatButtonState createState() => _FloatButtonState();
}

class _FloatButtonState extends State<FloatButton> with SingleTickerProviderStateMixin {

  final TransacoesPageBloc _transacoesBloc = BlocProvider.getBloc<TransacoesPageBloc>();
  final InitlalPageBloc _initialBloc = BlocProvider.getBloc<InitlalPageBloc>();

  Animation<double> _animation;
  AnimationController _controller;

  bool _active = false;

  Animation<Offset> _b1;
  Animation<Offset> _b2;
  Animation<Offset> _b3;
  Animation<Offset> _b4;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed) {

        }

      })..addListener(() {

      });

    _b1 = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-1.0, 0.2)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));
    _b2 = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-1.2, -1.0)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));
    _b3 = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-1.0, -2.5)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));
    _b4 = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-0.5, -3.5)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IgnorePointer(
          ignoring: !_active,
          child: FadeTransition(
            opacity: _animation,
            child: Container(
              color: Colors.black54,
            ),
          ),
        ),

        _renderSubIcon(Icon(Icons.swap_horiz, color: Colors.blueAccent,), _b1, 'Transferencia', ),
        _renderSubIcon(Icon(Icons.trending_up, color: Colors.green,), _b2, 'Receita', ),
        _renderSubIcon(Icon(Icons.credit_card, color: Colors.green,), _b3, 'Despesa Cartao', ),
        _renderSubIcon(Icon(Icons.trending_down, color: Colors.redAccent,), _b4, 'Despesa', ),

        Positioned(
          bottom: 60.0,
          right: 10.0,
          child: StreamBuilder<int>(
              stream: _initialBloc.currentPageIndex,
              initialData: 0,
              builder: (context, pageSnapshot) {
                return StreamBuilder<String>(
                    stream: _transacoesBloc.tipoTransacaoSelecionada,
                    initialData: TransacoesConstantes.transacoes,
                    builder: (context, snapshot) {
                      return Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: (pageSnapshot.data != 1 ? Colors.blueAccent : TransacoesConstantes.transacoesColor[snapshot.data]),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: CircleBorder(),
                            onTap: () {
                              if (_active) {
                                _deactiveWidget();
                              } else {
                                _activeWidget();
                              }
                            },
                            child: AnimatedBuilder(
                              animation: _animation,
                              child: Icon(Icons.add, color: Colors.white,),
                              builder: (BuildContext context, Widget child) {
                                return Transform.rotate(
                                  angle: _animation.value * 0.9,
                                  child: child,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }
                );
              }
          ),
        ),
        (_active ? _getTouch(28.0, 97.0, () {}): Container()),
        (_active ? _getTouch(110.0, 120.0, () {
          Navigator.of(context).pushNamed(ReceitaPage.routeName);
        }): Container()),
        (_active ? _getTouch(215.0, 97.0, () {}): Container()),
        (_active ? _getTouch(285, 35.0, () {
          Navigator.of(context).pushNamed(DespesaPage.routeName);
        }): Container()),
      ],
    );
  }
  _getTouch(double bottom, double right, Function onTap) {

    return Positioned(
      width: 120.0,
      height: 70.0,
      bottom: bottom,
      right: right,
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            _deactiveWidget();
            onTap();
          },
        ),
      ),);

  }


  Widget _renderSubIcon(Icon icon, Animation animation, String label) {
    return Positioned(
      bottom: 40.0,
      right: -25.0,
      child: FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          position: animation,
          child: Container(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  height: 70.0,
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: icon,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Text(label, style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deactiveWidget() {
    _controller.reverse();
    setState(() {
      _active = false;
    });
  }

  void _activeWidget() {
    _controller.forward();
    setState(() {
      _active = true;
    });
  }



}
