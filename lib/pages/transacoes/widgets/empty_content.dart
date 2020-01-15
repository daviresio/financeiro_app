import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SvgPicture.asset('assets/vetores/search.svg', height: 300.0, width: 300.0, fit: BoxFit.contain,),
            Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 50.0, right: 50.0),
              child: Text('Ops! Voce nao possui transacoes registradas.', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Text('Para criar um novo item, clique no botao (+)', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black54), textAlign: TextAlign.center,),
            ),
          ],
        ),
      );
    }
  }
