import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class InitlalPageBloc extends BlocBase {

  var _currentPageIndex = BehaviorSubject<int>.seeded(0);
  get currentPageIndex => _currentPageIndex.stream;
  setPage(int indexPage) => _currentPageIndex.sink.add(indexPage);


  @override
  void dispose() {
    _currentPageIndex.close();

  }
}