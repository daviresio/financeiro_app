import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';


class CalculadoraBloc extends BlocBase {

  var _valor = BehaviorSubject<String>.seeded('');
  get valor => _valor.stream;
  void reiniciar() => _valor.sink.add('');
  void adicionaValor(v) => _valor.sink.add(_valor.value + v);
  void alteraValor(v) => _valor.sink.add(v);
  void apagaValor() {
    String valorAtual = _valor.value;
    if(valorAtual.length > 0) {
      _valor.sink.add(valorAtual.substring(0, valorAtual.length -1));
    } else {
      _valor.sink.add('');
    }
  }

  @override
  void dispose() {
    _valor.close();
    super.dispose();
  }


}
