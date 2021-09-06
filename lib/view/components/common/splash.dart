import 'package:flutter/material.dart';
import 'package:jisho_study_tool/models/themes/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppTheme.jishoGreen.background),
      child: Center(
        child: Image(image: AssetImage('assets/images/logo/logo_icon_transparent.png'),)
      ),
    );
  }
}