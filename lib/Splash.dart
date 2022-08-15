// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:movies_app/Helpers/Constants/API_Key.dart';
import 'package:movies_app/Helpers/Constants/MyLists.dart';
import 'package:movies_app/auth/LoginScreen.dart';
import 'Helpers/Models/TopShows.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    print('getData');
    getData();
    print('getData');
    controller = AnimationController(
        duration: Duration(milliseconds: 2750), vsync: this);
    animation = ColorTween(begin: Colors.pink, end: Colors.deepPurple)
        .animate(controller!);
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });

    Timer(Duration(milliseconds: 3500), () {
      Get.off(
        () => LoginScreen(),
        duration: Duration(milliseconds: 100),
        transition: Transition.fade,
      );
    });
  }

// preload the api here
  void getData() async {
    await getTop250Movies();
  }

  Future<void> getTop250Movies() async {
    String url = "https://imdb-api.com/en/API/Top250Movies/$api_key";
    print(url);

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    Map data = json.decode(utf8.decode(response.bodyBytes));
    top250Movies =
        (data['items'] as List).map((e) => TopShows.fromJson(e)).toList();

    print(" data : " + top250Movies.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      body: Center(
        child: Stack(
          children: [
            Image(
              image: AssetImage("assets/images/log.png"),
              height: 200.0,
              width: 250.0,
              alignment: Alignment.topCenter,
            ),
          ],
        ),
      ),
    );
  }
}
