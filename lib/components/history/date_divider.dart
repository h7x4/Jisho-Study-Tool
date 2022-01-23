import 'package:flutter/material.dart';

import '../../bloc/theme/theme_bloc.dart';

class DateDivider extends StatelessWidget {
  final String? text;
  final DateTime? date;

  const DateDivider({
    this.text,
    this.date,
    Key? key,
  })  : assert((text == null) ^ (date == null)),
        super(key: key);

  String getHumanReadableDate(DateTime date) {
    const List<String> monthTable = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final int day = date.day;
    final String month = monthTable[date.month - 1];
    final int year = date.year;
    return '$day. $month $year';
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final colors = state.theme.menuGreyNormal;

          return Container(
            decoration: BoxDecoration(color: colors.background),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: DefaultTextStyle.merge(
              child: (text != null)
                  ? Text(text!)
                  : Text(getHumanReadableDate(date!)),
              style: TextStyle(color: colors.foreground),
            ),
          );
        },
      );
}
