import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/pages/planejamento/planejamento_page.dart';
import 'package:rxdart/rxdart.dart';

class NovaCategoriaBloc extends BlocBase {

  var _cor = BehaviorSubject<String>.seeded('azul');
  get cor => _cor.stream;
  void alteraCor(v) => _cor.sink.add(v);

  var _icone = BehaviorSubject<String>.seeded('alimentacao');
  get icone => _icone.stream;
  void alteraIcone(v) => _icone.sink.add(v);




  @override
  void dispose() {
    _cor.close();
    _icone.close();

  }


}

class ListaCategoriaBloc extends BlocBase {

  var _pesquisaText = BehaviorSubject<String>.seeded('');
  get pesquisaText => _pesquisaText.stream;
  void setPesquisaText(v) => _pesquisaText.sink.add(v);

  var _modalExpandido = BehaviorSubject<double>.seeded(0.5);
  get modalExpandido => _modalExpandido.stream;
  void expandeModal() => _modalExpandido.sink.add(0.9);
  void retraiModal() => _modalExpandido.sink.add(0.5);

  @override
  void dispose() {
    _pesquisaText.close();
    _modalExpandido.close();

  }


}