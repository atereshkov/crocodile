import 'package:crocodile_game/app/ui/rules/view_model/rules_view_model_type.dart';
import 'package:injector/injector.dart';

class RulesViewModel implements RulesViewModelType {
  final Injector _injector;

  RulesViewModel(this._injector);

  @override
  void dispose() {
    
  }

}
