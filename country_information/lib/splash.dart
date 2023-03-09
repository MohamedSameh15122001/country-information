import 'package:country_information/home.dart';
import 'package:flutter/material.dart';

import 'package:splash_view/source/presentation/pages/splash_view.dart';
import 'package:splash_view/source/presentation/widgets/done.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Color.fromARGB(255, 68, 70, 84),
    //     statusBarIconBrightness: Brightness.dark,
    //   ),
    // );
    return SplashView(
      // logo: const FlutterLogo(),
      loadingIndicator: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 100),
        child: Center(child: LinearProgressIndicator()),
      ),
      backgroundColor: const Color.fromARGB(255, 68, 70, 84),
      bottomLoading: false,
      showStatusBar: true,
      title: Image.asset(
        'lib/assets/countries.png',
        width: 100,
        height: 100,
      ),

      // gradient: const LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: <Color>[Colors.green, Colors.blue]),
      done: Done(
        const Home(),
        animationDuration: const Duration(seconds: 2),
        // curve: Curves.easeInOut,
      ),
    );
  }
}
