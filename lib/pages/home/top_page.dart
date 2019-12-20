import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_home.dart';
import 'package:financeiro_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopHomePage extends StatelessWidget {

  final HomePageBloc _homeBloc = BlocProvider.getBloc<HomePageBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 1.0,
                offset: Offset(0.0, 0.0))
          ]),
      child: Column(
        children: <Widget>[
          _renderTopBar(),
          _renderTotal(),
          StreamBuilder<bool>(
              stream: _homeBloc.esconderValores,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                  icon: Icon(
                    (snapshot.data
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash),
                    size: 14.0,
                    color: Colors.black54,
                  ),
                  onPressed: _homeBloc.alterarEsconderValores,
                );
              }),
          _renderBottomValues(),
        ],
      ),
    );
  }

  Widget _renderTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/usuario.png',
                  ))),
        ),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(getMonth(DateTime.now().month)),
                SizedBox(
                  width: 20.0,
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(icon: Icon(FontAwesomeIcons.bell), onPressed: () {}),
            /*PopupMenuButton(
              child: Icon(Icons.more_vert),
            ),*/
          ],
        )
      ],
    );
  }

  Widget _renderTotal() {
    return StreamBuilder<double>(
        stream: _homeBloc.valorTotal,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Text(
                'Saldo em contas',
                style: TextStyle(fontSize: 12.0, color: Colors.black54),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'R\$ ${snapshot.data}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: Colors.black.withOpacity(0.8)),
              ),
            ],
          );
        });
  }

  Widget _renderBottomValues() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.green[600]
              ),
              child: Icon(Icons.arrow_upward, color: Colors.white,),
            ),
            SizedBox(width: 10.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Receitas', style: TextStyle(fontSize: 12.0, color: Colors.black54, fontWeight: FontWeight.bold,),),
                SizedBox(height: 5.0,),
                StreamBuilder<double>(
                    stream: _homeBloc.receitaTotal,
                    builder: (context, snapshot) {
                      return Text('R\$ ${snapshot.data}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.green[600]),);
                    }
                ),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.red[600]
              ),
              child: Icon(Icons.arrow_downward, color: Colors.white,),
            ),
            SizedBox(width: 10.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Despesas', style: TextStyle(fontSize: 12.0, color: Colors.black54, fontWeight: FontWeight.bold,),),
                SizedBox(height: 5.0,),
                StreamBuilder<double>(
                    stream: _homeBloc.despesaTotal,
                    builder: (context, snapshot) {
                      return Text('R\$ ${snapshot.data}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.red[600]),);
                    }
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

}
