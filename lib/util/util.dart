

String getMonth(int m) {
  switch(m) {
    case 1:
      return 'Janeiro';
    case 2:
      return 'Fevereiro';
    case 3:
      return 'Marco';
    case 4:
      return 'Abril';
    case 5:
      return 'Maio';
    case 6:
      return 'Junho';
    case 7:
      return 'Julho';
    case 8:
      return 'Agosto';
    case 9:
      return 'Setembro';
    case 10:
      return 'Outubro';
    case 11:
      return 'Novembro';
    case 12:
      return 'Dezembro';
  }
}

String getWeekDay(int w) {
  switch(w) {
    case 1:
      return 'Segunda';
    case 2:
      return 'Terca';
    case 3:
      return 'Quarta';
    case 4:
      return 'Quinta';
    case 5:
      return 'Sexta';
    case 6:
      return 'Sabado';
    case 7:
      return 'Domingo';
  }
}

String formatDateDayMonthYear(DateTime d) {
  return '${d.day} ${getMonth(d.month).substring(0, 3)}, ${d.year}';
}

bool isToday(DateTime d) {
  if(d == null) return false;
  var tempD = DateTime.now();
  return DateTime(d.year, d.month, d.day).millisecondsSinceEpoch == DateTime(tempD.year, tempD.month, tempD.day).millisecondsSinceEpoch;
}

bool isYesterday(DateTime d) {
  if(d == null) return false;
  var tempD = DateTime.now();
  return DateTime(d.year, d.month, d.day).millisecondsSinceEpoch == DateTime(tempD.year, tempD.month, tempD.day - 1).millisecondsSinceEpoch;
}

String formateWeekDayAndMonthDay(DateTime d) {
  String weekDay = getWeekDay(d.weekday);
  int day = d.day;
  return '$weekDay, ${day.toString().length == 1 ? '0' + day.toString() : day}';
}



String getTextDay(DateTime d) {
  String text;
  if(isToday(d)) text = 'Hoje';
  else if(isYesterday(d)) text = 'Ontem';
  else text = formateWeekDayAndMonthDay(d);
  return text;
}