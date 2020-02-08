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
              _buildResultsWidget(context),
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

  Widget _buildResultsWidget(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.15;
    double containerWidth = MediaQuery.of(context).size.width * 0.25;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildSecondPlaceWidget(context, containerHeight, containerWidth),
        _buildFirstPlaceWidget(context, containerHeight, containerWidth),
        _buildThirdPlaceWidget(context, containerHeight, containerWidth),
      ],
    );
  }

  Widget _buildSecondPlaceWidget(BuildContext context, double containerHeight, double containerWidth) {
    return Column(
      children: <Widget>[
        Container(
          width: containerWidth,
          child: Center(
            child: Text(
              'Kekers Team',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4)),
        Container(
          height: containerHeight + 35,
          width: containerWidth,
          color: Colors.transparent,
          child: Center(
            child: Image(
              image: AssetImage('resources/images/place_2.png'),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4)),
        Text('10 points'),
      ],
    );
  }

  Widget _buildFirstPlaceWidget(BuildContext context, double containerHeight, double containerWidth) {
    return Column(
      children: <Widget>[
        Container(
          width: containerWidth,
          child: Center(
            child: Text(
              'Whooopers Team',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4)),
        Container(
          height: containerHeight + 80,
          width: containerWidth,
          color: Colors.transparent,
          child: Center(
            child: Image(
              image: AssetImage('resources/images/place_1.png'),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4)),
        Text('15 points'),
      ],
    );
  }

  Widget _buildThirdPlaceWidget(BuildContext context, double containerHeight, double containerWidth) {
    return Column(
      children: <Widget>[
        Container(
          width: containerWidth,
          child: Center(
            child: Text(
              'Boomers Team',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4)),
        Container(
          height: containerHeight + 10,
          width: containerWidth,
          color: Colors.transparent,
          child: Center(
            child: Image(
              image: AssetImage('resources/images/place_3.png'),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4)),
        Text('5 points'),
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