import 'package:financeiro_app/database/database.dart';

class ReceitaComRelacionamentos {

  ReceitaComRelacionamentos(this.receita, this.categoria, this.conta);

  final Receita receita;
  final Categoria categoria;
  final Conta conta;

}
