

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