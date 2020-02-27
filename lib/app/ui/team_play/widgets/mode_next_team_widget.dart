import 'package:crocodile_game/app/localization/app_localizations.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';
import 'package:flutter/material.dart';

class NextTeamModeWidget extends StatefulWidget {
  final TeamPlayViewModelType _viewModel;

  NextTeamModeWidget(this._viewModel);

  @override
  _NextTeamModeWidgetState createState() => _NextTeamModeWidgetState();
}

class _NextTeamModeWidgetState extends State<NextTeamModeWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildNextTeamLabel(context),
              Padding(padding: EdgeInsets.only(top: 14)),
              _buildTeamName(context),
              Padding(padding: EdgeInsets.only(top: 32)),
              _buildLeadersTable(context),
            ]
          ),
        ),
        _buildRoundsLabel(context),
        Padding(padding: EdgeInsets.only(bottom: 8)),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildBottomContainer(context),
        ),
      ],
    );
  }

  Widget _buildNextTeamLabel(BuildContext context) {
    return Text(
      AppLocalizations.of(context).teamPlayNextTeam,
      style: TextStyle(
        fontSize: 17,
      ),
    );
  }

  Widget _buildTeamName(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.currentTeam,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          TeamItem team = snapshot.data;
          return Text(
            team.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildLeadersTable(BuildContext context) {
    return Table(children: [
      TableRow(children: [
        Center(
          child: Text("Points"),
        ),
        Center(
          child: Text("Team"),
        ),
      ]),
      TableRow(children:[
        Center(
          child: Text("6"),
        ),
        Center(
          child: Text("Team 1"),
        ),
      ]),
      TableRow(children:[
        Center(
          child: Text("2"),
        ),
        Center(
          child: Text("Team 2"),
        ),
      ]),
      TableRow(children:[
        Center(
          child: Text("-2"),
        ),
        Center(
          child: Text("Team 3"),
        ),
      ]),
    ]);
  }

  Widget _buildRoundsLabel(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.roundsLeft,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int rounds = snapshot.data;
          String roundsLeft = AppLocalizations.of(context).teamPlayNextTeamRoundsLeft;
          return Text(
            '$roundsLeft $rounds',
            style: TextStyle(
              fontSize: 13,
            ),
          );
        } else {
          return Container();
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
            child: _buildNextButton(context),
          ),
        ),
      ],
    );
  }

  Widget _buildWordNotGuessedButton(BuildContext context) {
    return InkWell(
      onTap: () {
        widget._viewModel.endGameAction(context);
      },
      child: Container(
        color: Colors.red,
        child: Center(
          child: Text(
            AppLocalizations.of(context).teamPlayNextTeamFinishGame,
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

  Widget _buildNextButton(BuildContext context) {
    return InkWell(
      onTap: () {
        widget._viewModel.nextTeamPlayAction(context);
      },
      child: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            AppLocalizations.of(context).teamPlayNextTeamReadyButton,
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