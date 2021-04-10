import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';

class KanjiSearchBar extends StatefulWidget {
  @override
  _KanjiSearchBarState createState() => new _KanjiSearchBarState();
}

enum TextFieldButton {clear, paste}

class _KanjiSearchBarState extends State<KanjiSearchBar> {
  FocusNode focus = new FocusNode();
  TextEditingController textController = new TextEditingController();
  TextFieldButton button = TextFieldButton.paste;

  @override
  void initState() {
    super.initState();
    focus.addListener(_onFocusChange);
  }

  void _getKanjiSuggestions(String text) =>
      BlocProvider.of<KanjiBloc>(context).add(GetKanjiSuggestions(text));

  void updateSuggestions() => _getKanjiSuggestions(textController.text);

  void _onFocusChange() {
    debugPrint('TextField Focus Changed: ${focus.hasFocus.toString()}');

    setState(() {
      button = focus.hasFocus ? TextFieldButton.clear : TextFieldButton.paste;
    });

    if (focus.hasFocus)
      updateSuggestions();
    else
      FocusScope.of(context).unfocus();
  }

  void _clearText() {
    textController.text = '';
    updateSuggestions();
  }

  void _pasteText() async {
    ClipboardData clipboardData = await Clipboard.getData('text/plain');
    textController.text = clipboardData.text;
    updateSuggestions();
  }

  @override
  Widget build(BuildContext context) {
    IconButton clearButton = IconButton(
      icon: Icon(Icons.clear),
      onPressed: () => _clearText(),
    );

    IconButton pasteButton = IconButton(
      icon: Icon(Icons.content_paste),
      onPressed: () => _pasteText(),
    );

    return TextField(
      focusNode: focus,
      controller: textController,
      onChanged: (text) => _getKanjiSuggestions(text),
      onSubmitted: (text) =>
          BlocProvider.of<KanjiBloc>(context).add(GetKanji(text)),
      decoration: new InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search for kanji',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        isDense: false,
        suffixIcon: (button == TextFieldButton.clear) ? clearButton : pasteButton,
      ),
      style: TextStyle(
        fontSize: 14.0,
      ),
    );
  }
}