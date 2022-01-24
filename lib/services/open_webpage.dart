import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> open_webpage(String url) async {
  if (await canLaunch(url)) {
    launch(url);
  } else {
    debugPrint('Could not open url: $url');
  }
}
