import 'package:flutter/material.dart';

import '../../../bloc/theme/theme_bloc.dart';
import '../../../models/themes/theme.dart';

class DateDivider extends StatelessWidget {
  final String? text;
  final DateTime? date;
  final EdgeInsets? margin;

  const DateDivider({
    this.text,
    this.date,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
    Key? key,
  }) : super(key: key);

  String getHumanReadableDate(DateTime date) {
    const Map<int, String> monthTable = {
      1: 'Jan',
      2: 'Feb',
      3: 'Mar',
      4: 'Apr',
      5: 'May',
      6: 'Jun',
      7: 'Jul',
      8: 'Aug',
      9: 'Sep',
      10: 'Oct',
      11: 'Nov',
      12: 'Dec',
    };

    final int day = date.day;
    final String month = monthTable[date.month]!;
    final int year = date.year;
    return '$day. $month $year';
  }

  @override
  Widget build(BuildContext context) {
    final Widget header = (text != null)
        ? Text(text!)
        : (date != null)
            ? Text(getHumanReadableDate(date!))
            : const SizedBox.shrink();

    final ColorSet _menuColors =
        BlocProvider.of<ThemeBloc>(context).state.theme.menuGreyNormal;

    return Container(
      decoration: BoxDecoration(color: _menuColors.background),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      margin: margin,
      child: DefaultTextStyle.merge(
        child: header,
        style: TextStyle(color: _menuColors.foreground),
      ),
    );
  }
}
