import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_despesa.dart';
import 'package:financeiro_app/util/util.dart';
import 'package:flutter/material.dart';

import 'form_item.dart';

class CalendarFormField extends StatelessWidget {

  final bloc;
  
  final Color color;

  CalendarFormField(this.color, this.bloc);

  void _changeDate(DateTime d) {
    bloc.alteraData(d);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: color, accentColor: color, splashColor: color, buttonColor: color),
      child: Builder(
        builder: (BuildContext context) => StreamBuilder<DateTime>(
          stream: bloc.data,
          initialData: DateTime.now(),
          builder: (context, snapshot) {
            DateTime d = snapshot.data;
            return FormItem(Icons.calendar_today, ((d != null && !isToday(d) && !isYesterday(d)) ? Text(formatDateDayMonthYear(d)) : Container(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _itemCalendario('Hoje', isToday(d), () {
                    _changeDate(DateTime.now());
                  }),
                  _itemCalendario('Ontem', isYesterday(d), () {
                    var d = DateTime.now();
                    _changeDate(DateTime(d.year, d.month, d.day - 1));
                  }),
                  _itemCalendario('Outros...', false, () async {
                    DateTime dateSelected = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2016), lastDate: DateTime(2025));
                    _changeDate(dateSelected);
                  }),
                ],
              ),
            )), Container(), () async {
              DateTime dateSelected = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2016), lastDate: DateTime(2025));
              _changeDate(dateSelected);
            });
          }
        ),
      ),
    );
  }

  Widget _itemCalendario(String text, bool active, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 6.0, bottom: 6.0),
        decoration: BoxDecoration(
          color: (active ? color : Colors.grey[300]),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(text, style: TextStyle(color: (active ? Colors.white : Colors.black87)),
        ),
      ),
    );
  }

}
