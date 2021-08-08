import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';
import 'package:jisho_study_tool/models/themes/theme.dart';

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
    return "$day. $month $year";
  }

  @override
  Widget build(BuildContext context) {
    final Widget header = (this.text != null)
        ? Text(this.text!)
        : (this.date != null)
            ? Text(getHumanReadableDate(this.date!))
            : SizedBox.shrink();

    final ColorSet _menuColors =
        BlocProvider.of<ThemeBloc>(context).state.theme.menuGreyNormal;

    return Container(
      child: DefaultTextStyle.merge(
        child: header,
        style: TextStyle(color: _menuColors.foreground),
      ),
      decoration: BoxDecoration(color: _menuColors.background),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      margin: this.margin,
    );
  }
}
