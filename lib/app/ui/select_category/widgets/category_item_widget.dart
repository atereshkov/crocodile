import 'package:flutter/material.dart';
import 'package:crocodile_game/app/model/models.dart';

class CategoryItemWidget extends StatelessWidget {
  CategoryItemWidget({Key key, this.item, this.isSelected}) : super(key: key);

  final CategoryItem item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.0, right: 12.0),
      alignment: Alignment.centerLeft,
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildName(context, item.name),
          if (isSelected)
          _buildSelectedLabel(context),
        ],
      ),
    );
  }

  Widget _buildName(BuildContext context, String name) {
    //FontWeight weight = isHighlighted ? FontWeight.w600 : FontWeight.w400;
    return Text(
      name,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
    );
  }

  Widget _buildSelectedLabel(BuildContext context) {
    return Icon(Icons.check);
  }

}
