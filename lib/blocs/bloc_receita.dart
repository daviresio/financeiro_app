import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';


class ReceitaBloc extends BlocBase {

  var _valor = BehaviorSubject<String>.seeded('0.0');
  get valor => _valor.stream;
  void reiniciar() => _valor.sink.add('0.0');
  void alteraValor(v) => _valor.sink.add(v);

  var _data = BehaviorSubject<DateTime>.seeded(DateTime.now());
  get data => _data.stream;
  void alteraData(DateTime v) => _data.sink.add(v);

  @override
  void dispose() {
    _valor.close();
    _data.close();
    super.dispose();
  }


}
