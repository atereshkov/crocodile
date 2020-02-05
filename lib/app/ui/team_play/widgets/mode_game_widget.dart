import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';
import 'package:flutter/material.dart';

class GameModeWidget extends StatefulWidget {
  final TeamPlayViewModelType _viewModel;

  GameModeWidget(this._viewModel);

  @override
  _GameModeWidgetState createState() => _GameModeWidgetState();
}

class _GameModeWidgetState extends State<GameModeWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
             _buildTeamName(context),
             _buildWord(context),
            ]
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildBottomContainer(context),
        ),
      ],
    );
  }

  Widget _buildTeamName(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.currentTeam,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          TeamItem team = snapshot.data;
          return Text(team.name);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildWord(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.item,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String word = snapshot.data;
          return Text(word);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildBottomContainer(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 15.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            height: 60,
            child: _buildWordNotGuessedButton(context),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 15.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            height: 60,
            child: _buildWordGuessedButton(context),
          ),
        ),
      ],
    );
  }

  Widget _buildWordNotGuessedButton(BuildContext context) {
    return InkWell(
      onTap: () {
        widget._viewModel.wordNotGuessedAction(context);
      },
      child: Container(
        color: Colors.red,
        child: Center(
          child: Text(
            'Word is not guessed',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWordGuessedButton(BuildContext context) {
    return InkWell(
      onTap: () {
        widget._viewModel.wordGuessedAction(context);
      },
      child: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            'Word is guessed',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

}