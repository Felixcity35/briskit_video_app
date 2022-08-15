// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Helpers/Models/TopShows.dart';

import 'package:movies_app/Screens/Home/movie_home.dart';
import 'package:movies_app/Splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TopShows(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Briskit vid',
        routes: {
          '/': (context) => Splash(),
          '/home': (context) => MovieHome(),
        },
        initialRoute: '/',
      ),
    );
  }
}
