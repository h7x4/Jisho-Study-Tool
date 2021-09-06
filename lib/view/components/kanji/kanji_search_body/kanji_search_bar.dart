import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KanjiSearchBar extends StatefulWidget {
  final Function(String)? onChanged;

  KanjiSearchBar({this.onChanged, Key? key}) : super(key: key);

  @override
  KanjiSearchBarState createState() => new KanjiSearchBarState(this.onChanged);
}

enum TextFieldButton { clear, paste }

class KanjiSearchBarState extends State<KanjiSearchBar> {
  final TextEditingController textController = new TextEditingController();
  TextFieldButton button = TextFieldButton.paste;
  final Function(String)? onChanged;

  KanjiSearchBarState(this.onChanged);

  @override
  void initState() {
    super.initState();
  }

  void runOnChanged() {
      if (onChanged != null) onChanged!(textController.text);
  }

  void clearText() {
    textController.text = '';
    runOnChanged();
  }

  void pasteText() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null && clipboardData.text != null) {
      textController.text = clipboardData.text!;
      runOnChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    IconButton clearButton = IconButton(
      icon: Icon(Icons.clear),
      onPressed: () => clearText(),
    );

    IconButton pasteButton = IconButton(
      icon: Icon(Icons.content_paste),
      onPressed: () => pasteText(),
    );

    return TextField(
      controller: textController,
      onChanged: (text) {
        if (this.onChanged != null) this.onChanged!(text);
      },
      onSubmitted: (_) => {},
      decoration: new InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search',
        // fillColor: Colors.white,
        // filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        isDense: false,
        suffixIcon:
            (button == TextFieldButton.clear) ? clearButton : pasteButton,
      ),
    );
  }
}
