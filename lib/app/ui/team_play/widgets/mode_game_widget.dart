import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';
import 'package:crocodile_game/app/ui/common/circular_countdown.dart';
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
             _buildTimer(context),
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

  Widget _buildTimer(BuildContext context) {
    double radius = MediaQuery.of(context).size.width * 0.4;

    return StreamBuilder(
      stream: widget._viewModel.timerSecondsLeft,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          double percent = (snapshot.data / widget._viewModel.fullTimerValue);

          String text = "${snapshot.data}";

          Widget centerTextWidget;
          if (snapshot.data >= 10) {
            centerTextWidget = _buildTimerDefaultText(context, text);
          } else {
            centerTextWidget = _buildTimerWarningText(context, text);
          }

          return CircularCountdown(
            radius: radius,
            lineWidth: 5.0,
            percent: percent,
            center: centerTextWidget,
            progressColor: Colors.green,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildTimerDefaultText(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 40,
      ),
    );
  }

  Widget _buildTimerWarningText(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 55,
        color: Colors.red,
      ),
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
        String teamName = widget._viewModel.currentTeamName;

        final snackBar = SnackBar(
          content: Text(
            'Uh, no! $teamName -1 point',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        );

        Scaffold.of(context).showSnackBar(snackBar);

        widget._viewModel.wordNotGuessedAction(context);
      },
      child: Container(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Word is not guessed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 2)),
            Text(
              '-1 point',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordGuessedButton(BuildContext context) {
    return InkWell(
      onTap: () {
        String teamName = widget._viewModel.currentTeamName;

        final snackBar = SnackBar(
          content: Text(
            'Yay! $teamName +2 points',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        );

        Scaffold.of(context).showSnackBar(snackBar);

        widget._viewModel.wordGuessedAction(context);
      },
      child: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
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
            Padding(padding: EdgeInsets.only(top: 2)),
            Text(
              '+2 points',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

}