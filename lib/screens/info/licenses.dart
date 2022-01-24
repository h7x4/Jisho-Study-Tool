import 'package:flutter/material.dart';

import '../../settings.dart';

class LicensesView extends StatelessWidget {
  const LicensesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LicensePage(
        applicationName: 'Jisho Study Tool',
        applicationVersion: 'Version: $appVersion',
        applicationIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: Image.asset(
                  'assets/images/logo/logo_icon_transparent_green.png',
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      );
}
