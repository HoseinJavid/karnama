import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchMyUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

Future<void> lunchBazar() async {
  var uri = Uri.parse('bazaar://details?id=ir.mci.ecareapp');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    print('Bazaar app not installed. Trying web...');
    var webUri = Uri.parse('https://cafebazaar.ir/app/ir.mci.ecareapp');
    await launchUrl(webUri);
  }

//   if (Platform.isAndroid) {
//   AndroidIntent intent = const AndroidIntent(
//       action: 'android.intent.action.VIEW',
//       data: 'bazaar://details?id=ir.mci.ecareapp',
//       package: 'com.farsitel.bazaar'
//   );
//   await intent.launch();
// }
}

Future<void> lunchEmail() async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'hosein.javid.dev@gmail.com',
    query: encodeQueryParameters(<String, String>{
      'subject': 'انتقادات و پیشنهادات اپلیکیشن کارنما',
    }),
  );
  launchUrl(emailUri);
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
