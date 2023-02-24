import 'package:flutter/material.dart';
import 'package:ruby_text/ruby_text.dart';

import '../../models/library/library_list.dart';
import '../common/kanji_box.dart';
import '../common/loading.dart';

Future<void> showAddToLibraryDialog({
  required BuildContext context,
  required String entryText,
  String? furigana,
  bool isKanji = false,
}) =>
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AddToLibraryDialog(
        furigana: furigana,
        entryText: entryText,
        isKanji: isKanji,
      ),
    );

class AddToLibraryDialog extends StatefulWidget {
  final String? furigana;
  final String entryText;
  final bool isKanji;

  const AddToLibraryDialog({
    Key? key,
    required this.entryText,
    required this.isKanji,
    this.furigana,
  }) : super(key: key);

  @override
  State<AddToLibraryDialog> createState() => _AddToLibraryDialogState();
}

class _AddToLibraryDialogState extends State<AddToLibraryDialog> {
  Map<LibraryList, bool>? librariesContainEntry;

  /// A lock to make sure that the local data and the database doesn't
  /// get out of sync.
  bool toggleLock = false;

  @override
  void initState() {
    super.initState();

    LibraryList.allListsContains(
      entryText: widget.entryText,
      isKanji: widget.isKanji,
    ).then((data) => setState(() => librariesContainEntry = data));
  }

  Future<void> toggleEntry({required LibraryList lib}) async {
    if (toggleLock) return;

    setState(() => toggleLock = true);

    await lib.toggleEntry(
      entryText: widget.entryText,
      isKanji: widget.isKanji,
    );

    setState(() {
      toggleLock = false;
      librariesContainEntry![lib] = !librariesContainEntry![lib]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add to library'),
      contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      content: Column(
        children: [
          ListTile(
            title: Center(
              child: widget.isKanji
                  ? Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        KanjiBox.headline4(
                          context: context,
                          kanji: widget.entryText,
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    )
                  : RubySpanWidget(
                      RubyTextData(
                        widget.entryText,
                        ruby: widget.furigana,
                      ),
                    ),
            ),
          ),
          const Divider(thickness: 3),
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              child: librariesContainEntry == null
                  ? const LoadingScreen()
                  : ListView(
                      children: librariesContainEntry!.entries.map((e) {
                        final lib = e.key;
                        final checked = e.value;
                        return ListTile(
                          onTap: () => toggleEntry(lib: lib),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                          title: Row(
                            children: [
                              Checkbox(
                                value: checked,
                                onChanged: (_) => toggleEntry(lib: lib),
                              ),
                              Text(lib.name),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
