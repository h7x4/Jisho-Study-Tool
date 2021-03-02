
import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  final List<String> _languages;

  LanguageSelector(this._languages);

  @override
  LanguageSelectorState createState() => new LanguageSelectorState(this._languages);
}

class LanguageSelectorState extends State<LanguageSelector> {
  final List<String> _languages;
  List<bool> isSelected = [true, false, false];

  LanguageSelectorState(this._languages);

  @override
  void initState() {
    super.initState();
    isSelected = [true, false, false];
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        LanguageOption("Auto"),
        LanguageOption("Japanese"),
        LanguageOption("English")
      ],
      isSelected: isSelected
    );
  }

}

class LanguageOption extends StatelessWidget {
  final String _language;

  LanguageOption(this._language);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Center(child: Text(_language)),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
            color: Colors.white),
      ),
    );
  }
}