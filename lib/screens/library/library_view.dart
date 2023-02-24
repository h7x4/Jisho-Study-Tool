import 'package:flutter/material.dart';

import '../../components/common/loading.dart';
import '../../components/library/library_list_tile.dart';
import '../../models/library/library_list.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  List<LibraryList>? libraries;

  Future<void> getEntriesFromDatabase() =>
      LibraryList.allLibraries.then((libs) => setState(() => libraries = libs));

  @override
  void initState() {
    super.initState();
    getEntriesFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    if (libraries == null) return const LoadingScreen();
    return Column(
      children: [
        LibraryListTile(
          library: LibraryList.favourites,
          leading: const Icon(Icons.star),
          onDelete: getEntriesFromDatabase,
          onUpdate: getEntriesFromDatabase,
          isEditable: false,
        ),
        Expanded(
          child: ListView(
            children: libraries!
                // Skip favourites
                .skip(1)
                .map(
                  (e) => LibraryListTile(
                    library: e,
                    onDelete: getEntriesFromDatabase,
                    onUpdate: getEntriesFromDatabase,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
