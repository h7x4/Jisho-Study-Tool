import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/themes/theme.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  final SharedPreferences prefs = GetIt.instance.get<SharedPreferences>();
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = _getSelectedStatus() ?? [false, false, false];
  }

  Future<void> _updateSelectedStatus() async => prefs.setStringList(
        'languageSelectorStatus',
        isSelected.map((b) => b ? '1' : '0').toList(),
      );

  List<bool>? _getSelectedStatus() => prefs
      .getStringList('languageSelectorStatus')
      ?.map((s) => s == '1')
      .toList();

  Widget _languageOption(String language) => 
    Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Center(child: Text(language)),
    );

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      selectedColor: AppTheme.jishoGreen.background,
      isSelected: isSelected,
      children: <Widget>[
        _languageOption('Auto'),
        _languageOption('日本語'),
        _languageOption('English')
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
