import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class HomePageBloc extends BlocBase {

  var _valorTotal = BehaviorSubject<double>.seeded(0.0);
  get valorTotal => _valorTotal.stream;

  var _despesaTotal = BehaviorSubject<double>.seeded(0.0);
  get despesaTotal => _despesaTotal.stream;

  var _receitaTotal = BehaviorSubject<double>.seeded(0.0);
  get receitaTotal => _receitaTotal.stream;

  var _esconderValores = BehaviorSubject<bool>.seeded(false);
  get esconderValores => _esconderValores.stream;
  void alterarEsconderValores() => _esconderValores.sink.add(!_esconderValores.value);

  @override
  void dispose() {
    _valorTotal.close();
    _despesaTotal.close();
    _receitaTotal.close();
    _esconderValores.close();
  }
}