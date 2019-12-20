import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/pages/planejamento/planejamento_page.dart';
import 'package:rxdart/rxdart.dart';

class PlanejamentoPageBloc extends BlocBase {

  var _tipoPlanejamento = BehaviorSubject<String>.seeded(PlanejamentoConstants.planejamentoMensal);
  get tipoPlanejamento => _tipoPlanejamento.stream;
  void alteraTipoPlanejamento(v) => _tipoPlanejamento.sink.add(v);



  var _mesSelecionado = BehaviorSubject<DateTime>.seeded(DateTime.now());
  get mesSelecionado => _mesSelecionado.stream;

  void avancarMes() {
    var d = _mesSelecionado.stream.value;
    _mesSelecionado.sink.add(DateTime(d.year, d.month + 1, d.day));
  }

  void voltarMes() {
    var d = _mesSelecionado.stream.value;
    _mesSelecionado.sink.add(DateTime(d.year, d.month - 1, d.day));
  }

  @override
  void dispose() {
    _tipoPlanejamento.close();
    _mesSelecionado.close();

  }


}