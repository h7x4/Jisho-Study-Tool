import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/themes/theme.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late final SharedPreferences prefs;
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = [false, false, false];

    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
      setState(() {
        isSelected = _getSelectedStatus() ?? isSelected;
      });
    });
  }

  void _updateSelectedStatus() {
    prefs.setStringList(
      'languageSelectorStatus',
      isSelected.map((b) => b ? '1' : '0').toList(),
    );
  }

  List<bool>? _getSelectedStatus() {
    return prefs
        .getStringList('languageSelectorStatus')
        ?.map((s) => s == '1')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      selectedColor: AppTheme.jishoGreen.background,
      isSelected: isSelected,
      children: const <Widget>[
        _LanguageOption('Auto'),
        _LanguageOption('日本語'),
        _LanguageOption('English')
      ],
      onPressed: (buttonIndex) {
        setState(() {
          for (final int i in Iterable.generate(isSelected.length)) {
            isSelected[i] = i == buttonIndex;
          }
          _updateSelectedStatus();
        });
      },
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;

  const _LanguageOption(this.language);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Center(child: Text(language)),
    );
  }
}
