import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';
import 'package:flutter/material.dart';

class ResultsModeWidget extends StatefulWidget {
  final TeamPlayViewModelType _viewModel;

  ResultsModeWidget(this._viewModel);

  @override
  _ResultsModeWidgetState createState() => _ResultsModeWidgetState();
}

class _ResultsModeWidgetState extends State<ResultsModeWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Results'),
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

  Widget _buildBottomContainer(BuildContext context) {
    return Row(
      children: <Widget>[
        // Expanded(
        //   child: Container(
        //     decoration: BoxDecoration(
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey.withOpacity(0.4),
        //           blurRadius: 15.0,
        //           spreadRadius: 3.0,
        //         ),
        //       ],
        //     ),
        //     height: 50,
        //     child: _buildShareButton(context),
        //   ),
        // ),
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
            height: 50,
            child: _buildPlayAgainButton(context),
          ),
        ),
      ],
    );
  }

  Widget _buildShareButton(BuildContext context) {
    return InkWell(
      onTap: () {
        widget._viewModel.shareResultsAction(context);
      },
      child: Container(
        color: Colors.purple,
        child: Center(
          child: Text(
            'Share',
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

  Widget _buildPlayAgainButton(BuildContext context) {
    return InkWell(
      onTap: () {
        widget._viewModel.playAgainAction(context);
      },
      child: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            'Play again',
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