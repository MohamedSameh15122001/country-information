import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  // ignore: avoid_print
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

// launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
// Future<void> launchUrlFun(url) async {
//   if (!await launchUrl(Uri.parse(url))) {
//     throw Exception('Could not launch ${Uri.parse(url)}');
//   } else {
//     launchUrl(Uri.parse(url));
//   }
// }
openMap(lat, lon) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=l&query=$lat,$lon';
  if (await canLaunchUrl(Uri.parse(googleUrl))) {
    await launchUrl(Uri.parse(googleUrl));
  }
}

bool isNetworkConnection = true;
Future<void> internetConection(context) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isNetworkConnection = true;
    }
  } on SocketException catch (_) {
    isNetworkConnection = false;
    showSnackBar(context, 'Please Check Your Internet');
    // showTopSnackBar(
    //     context,
    //     const CustomSnackBar.success(
    //       backgroundColor: Colors.red,
    //       message: 'Please Check Your Internet',
    //       // icon: Icon(null),
    //     ),
    //   );
  }
}

showSnackBar(context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        msg,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      )));
}
