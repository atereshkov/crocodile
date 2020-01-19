import 'package:flutter/material.dart';
import 'package:crocodile_game/app/model/models.dart';

class CategoryItemWidget extends StatelessWidget {
  CategoryItemWidget({Key key, this.item, this.isSelected}) : super(key: key);

  final CategoryInfoItem item;
  final bool isSelected;

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
            if (isSelected)
            _buildSelectedLabel(context),
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
        if (item.description != null && item.description.isNotEmpty)
        _buildDescription(context, item.description)
      ],
    );
  }

  Widget _buildDescription(BuildContext context, String description) {
    return Padding(
      padding: EdgeInsets.only(top: 4),
      child: Text(
        description,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0),
      ),
    );
  }

  Widget _buildName(BuildContext context, String name) {
    return Text(
      name,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
    );
  }

  Widget _buildSelectedLabel(BuildContext context) {
    return Icon(Icons.check, color: Colors.blue);
  }

}
