import 'package:crocodile_game/app/ui/main/view_model/main_view_model_type.dart';
import 'package:crocodile_game/app/ui/single_play/module.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class MainViewModel implements MainViewModelType {
  Injector _injector;

  MainViewModel(this._injector);

  @override
  void initState() {
    
  }

  @override
  void dispose() {
    
  }

  @override
  void singlePlayAction(BuildContext context) {
    SinglePlayViewModelType vm = SinglePlayViewModel(_injector);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SinglePlayPage(vm)));
  }

}
