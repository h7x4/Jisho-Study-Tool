
import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => new _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = [true, false, false];
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: isSelected,
      children: <Widget> [
        _LanguageOption("Auto"),
        _LanguageOption("Japanese"),
        _LanguageOption("English")
      ],
      selectedColor: Colors.blue,
      onPressed: (int buttonIndex) {
        setState(() {
          for (var i in Iterable.generate(isSelected.length)) {
            isSelected[i] = i == buttonIndex;
          }
        });
      },
    );
  }

}

class _LanguageOption extends StatelessWidget {
  final String language;

  _LanguageOption(this.language);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Center(child: Text(language)),
      ),
    );
  }
}