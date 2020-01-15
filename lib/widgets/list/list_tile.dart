import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {

  final bool selected;
  final Widget title;
  final Widget subtitle;
  final Function onTap;
  final Function onLongPress;
  final Widget leading;
  final Widget trailing;

  MyListTile({this.selected = false, this.title, this.subtitle, this.onTap, this.onLongPress, this.leading, this.trailing});


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: selected ? Colors.grey[200] : Colors.transparent,
          height: 80.0,
        ),
          ListTile(
            onTap: () {
             if(onTap != null) onTap();
            },
            onLongPress: () {
             if(onLongPress != null) onLongPress();
            },
            leading: leading,
            title: title,
            subtitle: subtitle,
            trailing: trailing,
          ),
      ],
    );
  }
}
