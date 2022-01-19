import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../../bloc/theme/theme_bloc.dart';
import '../../services/handwriting.dart';

class DrawingBoard extends StatefulWidget {
  final Function(String)? onSuggestionChosen;
  final bool onlyOneCharacterSuggestions;
  final bool allowKanji;
  final bool allowHiragana;
  final bool allowKatakana;
  final bool allowOther;

  const DrawingBoard({
    this.onSuggestionChosen,
    this.onlyOneCharacterSuggestions = false,
    this.allowKanji = true,
    this.allowHiragana = false,
    this.allowKatakana = false,
    this.allowOther = false,
    Key? key,
  }) : super(key: key);

  @override
  _DrawingBoardState createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  List<String> suggestions = [];

  final List<List<TimedPoint>> strokes = [];
  final List<List<TimedPoint>> undoQueue = [];

  GlobalKey signatureW = GlobalKey();
  GlobalKey suggestionBarW = GlobalKey();

  static const double fontSize = 30;
  static const double suggestionCirclePadding = 13;

  late ColorSet panelColor =
      BlocProvider.of<ThemeBloc>(context).state.theme.menuGreyLight;
  late ColorSet barColor =
      BlocProvider.of<ThemeBloc>(context).state.theme.menuGreyNormal;

  late final SignatureController controller = SignatureController(
    penColor: panelColor.foreground,
    onDrawStart: () {
      strokes.add([]);
      undoQueue.clear();
    },
    onDrawMove: () => strokes.last
        .add(TimedPoint(time: DateTime.now(), point: controller.points.last)),
    onDrawEnd: () => updateSuggestions(),
  );

  Future<void> updateSuggestions() async {
    if (strokes.isEmpty) return setState(() => suggestions.clear());

    final newSuggestions = await HandwritingRequest(
      writingAreaHeight: signatureW.currentContext!.size!.width.toInt(),
      writingAreaWidth: signatureW.currentContext!.size!.width.toInt(),
      ink: strokes,
    ).fetch();
    setState(() {
      suggestions = newSuggestions;
    });
  }

  List<String> get filteredSuggestions {
    const kanjiR = r'\p{Script=Hani}';
    const hiraganaR = r'\p{Script=Hiragana}';
    const katakanaR = r'\p{Script=Katakana}';
    const otherR = '[^$kanjiR$hiraganaR$katakanaR]';

    final x = widget.allowKanji ? kanjiR : '';
    final y = widget.allowHiragana ? hiraganaR : '';
    final z = widget.allowKatakana ? katakanaR : '';

    late final RegExp combinedRegex;
    if ((widget.allowKanji || widget.allowHiragana || widget.allowKatakana) &&
        widget.allowOther) {
      combinedRegex = RegExp('^(?:[$x$y$z]|$otherR)+\$', unicode: true);
    } else if (widget.allowOther) {
      combinedRegex = RegExp('^$otherR+\$', unicode: true);
    } else {
      combinedRegex = RegExp('^[$x$y$z]+\$', unicode: true);
    }

    return suggestions
        .where((s) => combinedRegex.hasMatch(s))
        .where((s) => !widget.onlyOneCharacterSuggestions || s.length == 1)
        .toList();
  }

  Widget kanjiChip(String kanji) => InkWell(
        onTap: () => widget.onSuggestionChosen?.call(kanji),
        child: Container(
          height: fontSize + 2 * suggestionCirclePadding,
          width: fontSize + 2 * suggestionCirclePadding,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: BlocProvider.of<ThemeBloc>(context)
                .state
                .theme
                .menuGreyLight
                .background,
          ),
          child: Center(
            child: Text(
              kanji,
              style: const TextStyle(fontSize: fontSize),
            ),
          ),
        ),
      );

  Widget suggestionBar() {
    const padding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);

    return Container(
      key: suggestionBarW,
      color: barColor.background,
      alignment: Alignment.center,
      padding: padding,

      // TODO: calculate dynamically
      constraints: BoxConstraints(
        minHeight: 8 +
            suggestionCirclePadding * 2 +
            fontSize +
            (2 * 4) +
            padding.vertical,
      ),

      child: Wrap(
        spacing: 20,
        runSpacing: 5,
        children: filteredSuggestions.map((s) => kanjiChip(s)).toList(),
      ),
    );
  }

  Widget buttonRow() => Container(
        color: panelColor.background,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => setState(() {
                controller.clear();
                strokes.clear();
                suggestions.clear();
              }),
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                if (strokes.isNotEmpty) {
                  undoQueue.add(strokes.removeLast());
                  controller.undo();
                  updateSuggestions();
                }
              },
              icon: const Icon(Icons.undo),
            ),
            IconButton(
              onPressed: () {
                if (undoQueue.isNotEmpty) {
                  strokes.add(undoQueue.removeLast());
                  controller.redo();
                  updateSuggestions();
                }
              },
              icon: const Icon(Icons.redo),
            ),
            if (!widget.onlyOneCharacterSuggestions)
              IconButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('TODO: implement scrolling page feature!'),
                  ),
                ),
                icon: const Icon(Icons.arrow_forward),
              ),
          ],
        ),
      );

  Widget drawingPanel() => AspectRatio(
        aspectRatio: 1.2,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipRect(
              child: Signature(
                key: signatureW,
                controller: controller,
                backgroundColor: panelColor.background,
              ),
            ),
            buttonRow(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) => setState(() {
        panelColor = state.theme.menuGreyLight;
        barColor = state.theme.menuGreyDark;
      }),
      child: Column(
        children: [
          suggestionBar(),
          drawingPanel(),
        ],
      ),
    );
  }
}
