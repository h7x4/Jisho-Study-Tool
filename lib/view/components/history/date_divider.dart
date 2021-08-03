import 'package:flutter/material.dart';

class DateDivider extends StatelessWidget {
  final String? text;
  final DateTime? date;

  const DateDivider({this.text, this.date, Key? key}) : super(key: key);

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

    int day = date.day;
    String month = monthTable[date.month]!;
    int year = date.year;
    return "$day. $month $year";
  }

  @override
  Widget build(BuildContext context) {
    Widget header = (this.text != null)
        ? Text(this.text!)
        : (this.date != null)
            ? Text(getHumanReadableDate(this.date!))
            : SizedBox.shrink();

    return Container(
      child: DefaultTextStyle.merge(
        child: header,
        style: TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(color: Colors.grey),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
    );
  }
}
