import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/rules/view_model/rules_view_model_type.dart';

class RulesPage extends StatefulWidget {
  final RulesViewModelType _viewModel;

  RulesPage(this._viewModel);

  @override
  _RulesPageState createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(title: Text('Rules'));
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        _gradientBackground(),
        Column(
          children: <Widget>[
            _buildSinglePlayRules(context),
            _buildTeamPlayRules(context),
          ],
        ),
      ],
    );
  }

  Widget _buildSinglePlayRules(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.person,
                color: Colors.white,
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Icon(
                Icons.person,
                color: Colors.white,
              ),
              Padding(padding: EdgeInsets.only(left: 12)),
              Text(
                "Обычная игра",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 12)),
          Text(
            "Игрок должен изобразить слово, используя только жесты и мимику (говорить нельзя), а остальные игроки должны угадать это слово. Тот, кто угадал - занимает место ведущего игрока и игра продолжается.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamPlayRules(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.people,
                color: Colors.white,
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Icon(
                Icons.people,
                color: Colors.white,
              ),
              Padding(padding: EdgeInsets.only(left: 12)),
              Text(
                "Командная игра",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 12)),
          Text(
            "Игроки делятся на команды с произвольным количеством игроков. Далее команды по кругу показывают слова (один игрок от команды). Игрок показывает слово и только его команда пытается отгадать слово. Если слово отгадано за отведенное время, команде начисляются баллы и очередь переходит к следущей команде по кругу.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _gradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xB300A010), Color(0xFFF2E6E6)]
        )
      ),
    );
  }

}