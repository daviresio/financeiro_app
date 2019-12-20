import 'package:flutter/material.dart';

class FormItem extends StatelessWidget {

  IconData icon;
  Widget body;
  Widget right;
  Function onTap;

  FormItem(IconData icon, Widget body, Widget right, Function onTap) : this.icon = icon, this.body = body, this.right = right, this.onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12, width: 0.7))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon, color: Colors.black54,),
            body,
            right,
          ],
        ),
      ),
    );
  }
}
