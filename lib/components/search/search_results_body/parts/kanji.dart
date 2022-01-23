import 'package:flutter/material.dart';

import '../../../../bloc/theme/theme_bloc.dart';
import '../../../../routing/routes.dart';

class KanjiRow extends StatelessWidget {
  final List<String> kanji;
  const KanjiRow({
    Key? key,
    required this.kanji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kanji',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: kanji
              .map(
                (k) => InkWell(
                  onTap: () => Navigator.pushNamed(context, Routes.kanjiSearch, arguments: k),
                  child: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      final colors = state.theme.menuGreyLight;
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                        color: colors.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            Text(k, style: TextStyle(color: colors.foreground, fontSize: 25)),
                      );
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
