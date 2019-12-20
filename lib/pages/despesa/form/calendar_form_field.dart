import 'package:financeiro_app/database/database.dart';
import 'package:financeiro_app/util/util.dart';
import 'package:flutter/material.dart';

import 'form_item.dart';

class CalendarFormField extends StatefulWidget {
  @override
  _CalendarFormFieldState createState() => _CalendarFormFieldState();
}

class _CalendarFormFieldState extends State<CalendarFormField> {

  var _despesa = Despesa().copyWith(data: DateTime.now(), pago: false, favorito: false);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.redAccent, accentColor: Colors.redAccent, splashColor: Colors.redAccent, buttonColor: Colors.redAccent),
      child: Builder(
        builder: (BuildContext context) => FormItem(Icons.calendar_today, ((_despesa.data != null && !isToday(_despesa.data) && !isYesterday(_despesa.data)) ? Text(formatDateDayMonthYear(_despesa.data)) : Container(
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _itemCalendario('Hoje', isToday(_despesa.data), () {}),
              _itemCalendario('Ontem', isYesterday(_despesa.data), () {}),
              _itemCalendario('Outros...', false, () async {
                DateTime dateSelected = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2016), lastDate: DateTime(2025));
                setState(() => _despesa = _despesa.copyWith(data: dateSelected));
              }),
            ],
          ),
        )), Container(), () async {
          DateTime dateSelected = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2016), lastDate: DateTime(2025));
          setState(() => _despesa = _despesa.copyWith(data: dateSelected));
        }),
      ),
    );
  }

  Widget _itemCalendario(String text, bool active, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 6.0, bottom: 6.0),
        decoration: BoxDecoration(
          color: (active ? Colors.redAccent : Colors.grey[300]),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(text, style: TextStyle(color: (active ? Colors.white : Colors.black87)),
        ),
      ),
    );
  }

}
