import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/database/database.dart';
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
  Stream<double> transacoesSaldoPrevisto() {
    Database.instance.receitaDao.list().listen((receitas) {
      Database.instance.despesaDao.list().listen((despesas) {
        double d = despesas.length == 0 ? 0.0 : despesas.map((v) => v.valor).reduce((a, b) => a + b);
        double r = receitas.length == 0 ? 0.0 : receitas.map((v) => v.valor).reduce((a, b) => a + b);
        _transacoesSaldoPrevisto.sink.add(r - d);
      });
    });
    return _transacoesSaldoPrevisto.stream;
  }

  var _transacoesBalancoMensal = BehaviorSubject<double>.seeded(0.0);
  Stream<double> transacoesBalancoMensal(DateTime d) {
    Database.instance.receitaDao.listByDate(d).listen((receitas) {
      Database.instance.despesaDao.listByDate(d).listen((despesas) {
        double d = despesas.length == 0 ? 0.0 : despesas.map((v) => v.valor).reduce((a, b) => a + b);
        double r = receitas.length == 0 ? 0.0 : receitas.map((v) => v.valor).reduce((a, b) => a + b);
        _transacoesBalancoMensal.sink.add(r - d);
      });
    });
    return _transacoesBalancoMensal.stream;
  }


  @override
  void dispose() {
    _exibirTipoTransacao.close();
    _mesSelecionado.close();
    _transacoesSaldoPrevisto.close();
    _transacoesBalancoMensal.close();
    _despesaSelecionada.close();

  }
}