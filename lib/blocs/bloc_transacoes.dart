import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/database/joins/despesa_joins.dart';
import 'package:financeiro_app/database/joins/receita_joins.dart';
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

  var _despesaSelecionada = BehaviorSubject<DespesaComRelacionamentos>.seeded(null);
  get despesaSelecionada => _despesaSelecionada.stream;
  void selecionaDespesa(DespesaComRelacionamentos d) => _despesaSelecionada.sink.add(d);
  void removeDespesaSelecionada() => _despesaSelecionada.sink.add(null);

  var _receitaSelecionada = BehaviorSubject<ReceitaComRelacionamentos>.seeded(null);
  get receitaSelecionada => _receitaSelecionada.stream;
  void selecionaReceita(ReceitaComRelacionamentos d) => _receitaSelecionada.sink.add(d);
  void removeReceitaSelecionada() => _receitaSelecionada.sink.add(null);

  var _transacoesSaldoPrevisto = BehaviorSubject<double>.seeded(0.0);
  get transacoesSaldoPrevisto => _transacoesSaldoPrevisto.stream;

  var _transacoesBalancoMensal = BehaviorSubject<double>.seeded(0.0);
  get transacoesBalancoMensal => _transacoesBalancoMensal.stream;


  @override
  void dispose() {
    _exibirTipoTransacao.close();
    _mesSelecionado.close();
    _transacoesSaldoPrevisto.close();
    _transacoesBalancoMensal.close();
    _despesaSelecionada.close();

  }
}