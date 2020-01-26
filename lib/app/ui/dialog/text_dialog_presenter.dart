import 'package:crocodile_game/app/ui/dialog/text_dialog_presenter_type.dart';
import 'package:flutter/material.dart';

class TextDialogPresenter implements TextDialogPresenterType {
  final String title;
  final String textFieldValue;
  final Function onSaveAction;

  TextDialogPresenter(this.title, this.textFieldValue, this.onSaveAction);

  final TextEditingController _textEditController = TextEditingController();

  @override
  void show(BuildContext context) {
    List<Widget> actions = [
      FlatButton(
        child: Text('Cancel'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      FlatButton(
        child: Text('Save'),
        onPressed: () {
          Navigator.of(context).pop();
          onSaveAction(_textEditController.text);
        },
      ),
    ];

    _textEditController.text = textFieldValue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _SystemPadding(
          child: AlertDialog(
            contentPadding: EdgeInsets.only(left: 24, right: 24, top: 12),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditController,
                    autofocus: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Team name',
                    ),
                  ),
                ),
              ],
            ),
            title: Text(title),
            actions: actions,
          ),
        );
      },
    );
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
      padding: mediaQuery.padding,
      duration: Duration(milliseconds: 300),
      child: child,
    );
  }
}