import 'package:financeiro_app/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:flutter/material.dart';

Future<dynamic> showCalculadora(BuildContext context) {

  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) => roundedBottomSheet(Container(), height: 0.8,));

}