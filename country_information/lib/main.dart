import 'package:country_information/bloc_observer.dart';
import 'package:country_information/main_cubit.dart';
import 'package:country_information/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Country information',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
