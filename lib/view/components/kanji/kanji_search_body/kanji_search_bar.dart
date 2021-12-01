import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KanjiSearchBar extends StatefulWidget {
  final Function(String)? onChanged;

  const KanjiSearchBar({this.onChanged, Key? key}) : super(key: key);

  @override
  KanjiSearchBarState createState() => KanjiSearchBarState(this.onChanged);
}

enum TextFieldButton { clear, paste }

class KanjiSearchBarState extends State<KanjiSearchBar> {
  final TextEditingController textController = TextEditingController();
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

  Future<void> pasteText() async {
    final ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null && clipboardData.text != null) {
      textController.text = clipboardData.text!;
      runOnChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    final IconButton clearButton = IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () => clearText(),
    );

    final IconButton pasteButton = IconButton(
      icon: const Icon(Icons.content_paste),
      onPressed: () => pasteText(),
    );

    return TextField(
      controller: textController,
      onChanged: (text) {
        if (onChanged != null) onChanged!(text);
      },
      onSubmitted: (_) => {},
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
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
