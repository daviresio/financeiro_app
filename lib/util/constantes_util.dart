import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Map<String, IconData> iconMapping = {
  'alimentacao': FontAwesomeIcons.utensils,
  'educacao': FontAwesomeIcons.bookOpen,
  'lazer': FontAwesomeIcons.umbrellaBeach,
  'moradia': FontAwesomeIcons.home,
  'pagamentos': FontAwesomeIcons.barcode,
  'roupa': FontAwesomeIcons.tshirt,
  'saude': FontAwesomeIcons.heartbeat,
  'transporte': FontAwesomeIcons.busAlt,
  'investimentos': FontAwesomeIcons.chartLine,
  'outros': FontAwesomeIcons.ellipsisH,
  'presente': FontAwesomeIcons.gift,
  'premios': FontAwesomeIcons.trophy,
  'salario': FontAwesomeIcons.moneyBill,

};


Map<String, Color> colorMapping = {
  'azul': Colors.blueAccent,
  'azul_claro': Colors.blueAccent[400],
  'vermelho': Colors.redAccent,
  'roxo': Colors.purpleAccent,
  'roxo_claro': Colors.purpleAccent[400],
  'laranjado': Colors.orangeAccent,
  'verde': Colors.green,
};