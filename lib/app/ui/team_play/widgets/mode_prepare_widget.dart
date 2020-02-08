import 'package:crocodile_game/app/localization/app_localizations.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';
import 'package:flutter/material.dart';

class PrepareModeWidget extends StatefulWidget {
  final TeamPlayViewModelType _viewModel;

  PrepareModeWidget(this._viewModel);

  @override
  _PrepareModeWidgetState createState() => _PrepareModeWidgetState();
}

class _PrepareModeWidgetState extends State<PrepareModeWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTeamLabel(context),
              Padding(padding: EdgeInsets.only(top: 14)),
              _buildTeamName(context),
              Padding(padding: EdgeInsets.only(top: 14)),
              _buildPrepareLabel(context),
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

  Widget _buildTeamLabel(BuildContext context) {
    return Text(
      AppLocalizations.of(context).teamPlayPrepareTeamLabel,
      style: TextStyle(
        fontSize: 16,
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
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildPrepareLabel(BuildContext context) {
    return Text(
      AppLocalizations.of(context).teamPlayPrepareStartingTeam,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  Widget _buildBottomContainer(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 15.0,
                spreadRadius: 3.0,
              ),
            ],
          ),
          height: 50,
          width: double.infinity,
          child: _buildStartGameButton(context),
        ),
      ],
    );
  }

  Widget _buildStartGameButton(BuildContext context) {
    return InkWell(
      onTap: () {
        widget._viewModel.startGameAction(context);
      },
      child: Container(
        color: Colors.lightBlue,
        child: Center(
          child: Text(
            AppLocalizations.of(context).teamPlayPrepareStartButton,
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