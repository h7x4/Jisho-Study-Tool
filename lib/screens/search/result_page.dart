import 'package:flutter/material.dart';

import '../../components/common/loading.dart';
import '../../components/kanji/kanji_result_body.dart';
import '../../components/library/add_to_library_dialog.dart';
import '../../components/search/search_result_body.dart';
import '../../models/history/history_entry.dart';
import '../../models/library/library_list.dart';
import '../../services/jisho_api/jisho_search.dart';
import '../../services/jisho_api/kanji_search.dart';

class ResultPage extends StatefulWidget {
  final String searchTerm;
  final bool isKanji;

  const ResultPage({
    Key? key,
    required this.searchTerm,
    required this.isKanji,
  }) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool addedToDatabase = false;
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isKanji) return;
    LibraryList.favourites
        .containsKanji(widget.searchTerm)
        .then((b) => setState(() => isFavourite = b));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: !widget.isKanji
            ? []
            : [
                IconButton(
                  onPressed: () async {
                    await showAddToLibraryDialog(
                      context: context,
                      entryText: widget.searchTerm,
                      isKanji: true,
                    );
                    final updatedFavouriteStatus = await LibraryList.favourites
                        .containsKanji(widget.searchTerm);
                    setState(() => isFavourite = updatedFavouriteStatus);
                  },
                  icon: const Icon(Icons.bookmark),
                ),
                IconButton(
                  onPressed: () async {
                    await LibraryList.favourites.toggleEntry(
                      entryText: widget.searchTerm,
                      isKanji: true,
                      overrideToggleOn: !isFavourite,
                    );
                    setState(() => isFavourite = !isFavourite);
                  },
                  icon: isFavourite
                      ? const Icon(Icons.star, color: Colors.yellow)
                      : const Icon(Icons.star_border),
                )
              ],
      ),
      body: FutureBuilder(
        future: widget.isKanji
            ? fetchKanji(widget.searchTerm)
            : fetchJishoResults(widget.searchTerm),
        builder: (context, snapshot) {
          // TODO: provide proper error handling
          if (snapshot.hasError) return ErrorWidget(snapshot.error!);
          if (!snapshot.hasData) return const LoadingScreen();

          if (!addedToDatabase) {
            if (widget.isKanji) {
              HistoryEntry.insertKanji(kanji: widget.searchTerm);
            } else {
              HistoryEntry.insertWord(word: widget.searchTerm);
            }
            addedToDatabase = true;
          }

          return widget.isKanji
              ? KanjiResultBody(result: snapshot.data! as KanjiResult)
              : SearchResultsBody(
                  results: (snapshot.data! as JishoAPIResult).data!,
                );
        },
      ),
    );
  }
}
