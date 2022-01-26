import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

import '../../../bloc/theme/theme_bloc.dart';
import '../../../routing/routes.dart';
import '../../../settings.dart';

class Radical extends StatelessWidget {
  final jisho.Radical radical;

  const Radical({
    required this.radical,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final colors = state.theme.kanjiResultColor;

          return InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.kanjiSearchRadicals,
              arguments: radical.symbol,
            ),
            child: 
              Expanded(
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.background,
                        ),
                        child: FittedBox(
                          child: Text(
                            radical.symbol,
                            style: TextStyle(color: colors.foreground)
                                .merge(japaneseFont.textStyle),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
          );
        },
      );
}
