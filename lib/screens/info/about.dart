import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

import '../../components/common/denshi_jisho_background.dart';
import '../../services/open_webpage.dart';
import '../../settings.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  static const double _verticalSeparation = 18.0;

  Widget _header(context) => Column(
        children: [
          const SizedBox(height: _verticalSeparation),
          Text(
            'Jisho Study Tool',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: _verticalSeparation),
          Row(
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
          const SizedBox(height: _verticalSeparation),
          Text(
            'Version: $appVersion',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: _verticalSeparation),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: DenshiJishoBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _header(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Jisho Study Tool is a frontend for Jisho.org, a a powerful Japanese-English dictionary. '
                  "It's made to aid you in your journey towards Japanese proficiency. "
                  'More features to come!',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),

              const SizedBox(height: 2 * _verticalSeparation),

              Text('Contact:', style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: _verticalSeparation),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                        color: Colors.white,
                        iconSize: 50,
                        onPressed: () => open_webpage(
                          'https://github.com/h7x4ABk3g/Jisho-Study-Tool',
                        ),
                        icon: const Icon(Mdi.github),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () => open_webpage(
                          'mailto:developer@jishostudytool.app',
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('You can reach me at:'),
                            Text(
                              'developer@jishostudytool.app',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: _verticalSeparation),
              Text(
                'File a bug report:',
                style: Theme.of(context).textTheme.headline6,
              ),
              InkWell(
                onTap: () => open_webpage(
                  'mailto:bugs@jishostudytool.app',
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: _verticalSeparation,
                  ),
                  child: const Text(
                    'bugs@jishostudytool.app',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              Text(
                'I would really appreciate it if you send in some bug reports! '
                'If you find something weird, '
                'please send me a mail, or open an issue on GitHub.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(height: _verticalSeparation),
              Center(
                child: Text(
                  '頑張れ！',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.merge(japaneseFont.textStyle),
                ),
              ),
              // const SizedBox(height: 6 * _verticalSeparation),
            ],
          ),
        ),
      ),
    );
  }
}
