import 'package:injector/injector.dart';
import 'package:crocodile_game/app/ui/main/view_model/main_view_model_type.dart';

class MainViewModel implements MainViewModelType {

  final Injector _injector;

  MainViewModel(this._injector) {
    
  }

  @override
  void dispose() {
    
  }
}
