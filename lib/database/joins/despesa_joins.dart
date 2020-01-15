import 'package:financeiro_app/database/database.dart';

class DespesaComRelacionamentos {

  DespesaComRelacionamentos(this.despesa, this.categoria, this.conta);

  final Despesa despesa;
  final Categoria categoria;
  final Conta conta;

}
