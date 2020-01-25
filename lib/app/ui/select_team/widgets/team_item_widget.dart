import 'package:flutter/material.dart';
import 'package:crocodile_game/app/model/models.dart';

class TeamItemWidget extends StatelessWidget {
  TeamItemWidget({Key key, this.item, this.onDeleteCallback}) : super(key: key);

  final TeamItem item;
  final Function onDeleteCallback;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 60),
      child: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: _buildContent(context),
            ),
            _buildDeleteIcon(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildName(context, item.name),
      ],
    );
  }

  Widget _buildName(BuildContext context, String name) {
    return Text(
      name,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
    );
  }

  Widget _buildDeleteIcon(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.blue),
      onPressed: () {
        onDeleteCallback();
      },
    );
  }

}
