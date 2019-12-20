import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/pages/transacoes/transacoes_page.dart';
import 'package:rxdart/rxdart.dart';

class TransacoesPageBloc extends BlocBase {

  var _exibirTipoTransacao = BehaviorSubject<String>.seeded(TransacoesConstantes.transacoes);
  get tipoTransacaoSelecionada => _exibirTipoTransacao.stream;
  void alterarTransacaoSelecionada(String tipo) => _exibirTipoTransacao.sink.add(tipo);



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



  var _transacoesSaldoPrevisto = BehaviorSubject<double>.seeded(0.0);
  get transacoesSaldoPrevisto => _transacoesSaldoPrevisto.stream;

  var _transacoesBalancoMensal = BehaviorSubject<double>.seeded(0.0);
  get transacoesBalancoMensal => _transacoesBalancoMensal.stream;

  var _despesasTotalPendente = BehaviorSubject<double>.seeded(0.0);
  get despesasTotalPendente => _despesasTotalPendente.stream;

  var _despesasTotalPago = BehaviorSubject<double>.seeded(0.0);
  get despesasTotalPago => _despesasTotalPago.stream;

  var _receitasTotalPendente = BehaviorSubject<double>.seeded(0.0);
  get receitasTotalPendente => _receitasTotalPendente.stream;

  var _receitasTotalRecebido = BehaviorSubject<double>.seeded(0.0);
  get receitasTotalRecebido => _receitasTotalRecebido.stream;


  @override
  void dispose() {
    _exibirTipoTransacao.close();
    _mesSelecionado.close();
    _transacoesSaldoPrevisto.close();
    _transacoesBalancoMensal.close();
    _despesasTotalPendente.close();
    _despesasTotalPago.close();
    _receitasTotalPendente.close();
    _receitasTotalRecebido.close();

  }
}