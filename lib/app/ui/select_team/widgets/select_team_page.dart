import 'package:crocodile_game/app/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/ui/select_team/module.dart';

class SelectTeamPage extends StatefulWidget {
  final SelectTeamViewModelType _viewModel;

  SelectTeamPage(this._viewModel);

  @override
  _SelectTeamPageState createState() => _SelectTeamPageState();
}

class _SelectTeamPageState extends State<SelectTeamPage> {

  @override
  void initState() {
    _bindViewModel();

    Future.delayed(Duration.zero, () {
      widget._viewModel.initState(context);
    });

    super.initState();
  }

  void _bindViewModel() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Play'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12, bottom: 4, left: 12, right: 12),
          child: _buildSettings(context),
        ),
        Divider(),
        Expanded(
          child: _buildList(context),
        ),
        _buildBottomContainerBuilder(context),
      ],
    );
  }

  Widget _buildSettings(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTimerSettings(context),
      ],
    );
  }

  Widget _buildTimerSettings(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.isTimerChecked,
      builder: (context, snapshot) {
        bool isChecked = snapshot.data;

        if (snapshot.hasData) {
          return Row(
            children: <Widget>[
              Expanded(
                child: _buildTimerCheckbox(context, isChecked),
              ),
              if (isChecked)
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: _buildTimerDropdown(context),
              ),
            ],
          );
        } else {
          return Text('Loading');
        }
      }
    );
  }

  Widget _buildTimerCheckbox(BuildContext context, bool isChecked) {
    return CheckboxListTile(
      title: Text('Timer (s)'),
      onChanged: (newValue) {
        widget._viewModel.onTimerCheckboxAction(newValue);
      },
      value: isChecked,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildTimerDropdown(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.timerValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton(
            hint: Text(snapshot.data),
            style: TextStyle(color: Colors.blue),
            items: ['15', '30', '45', '60', '75', '90'].map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (newValue) {
              setState(
                () {
                  widget._viewModel.timerDropdownAction(newValue);
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.getTeamsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TeamItem> items = snapshot.data;
          return Scrollbar(
            child: ListView.separated(
              key: PageStorageKey('select-team-page-key'),
              separatorBuilder: (context, index) {
                return Divider(indent: 12, height: 2.0);
              },
              itemBuilder: (BuildContext context, int index) {
                TeamItem item = items[index];
                return _buildItem(context, item);
              },
              itemCount: items == null ? 0 : items.length,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildItem(BuildContext context, TeamItem item) {
    return InkWell(
      onTap: () {
        widget._viewModel.handleTeamItemTap(item);
      },
      child: TeamItemWidget(
        item: item, 
        onDeleteCallback: () {
          widget._viewModel.onTeamDeleteTap(item);
        },
      ),
    );
  }

  Widget _buildBottomContainerBuilder(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.startGameButtonEnabledStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool isEnabled = snapshot.data;
          return _buildBottomContainer(context, isEnabled);
        } else {
          return Container();
        }
      },
    ); 
  }

  Widget _buildBottomContainer(BuildContext context, bool isEnabled) {
    return Column(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 20.0,
                spreadRadius: 5.0,
              )
            ],
          ),
          height: 50,
          width: double.infinity,
          child: _buildStartGameButton(context, isEnabled),
        ),
        Container(
          height: MediaQuery.of(context).padding.bottom,
          color: isEnabled ? Colors.lightBlue : Colors.grey,
        ),
      ],
    );
  }

  Widget _buildStartGameButton(BuildContext context, bool isEnabled) {
    return InkWell(
      onTap: () {
        if (isEnabled)
        widget._viewModel.startGameAction(context);
      },
      child: Container(
        color: isEnabled ? Colors.lightBlue : Colors.grey,
        child: Center(
          child: Text(
            AppLocalizations.of(context).selectGameStartGameButton,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: isEnabled ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

}
