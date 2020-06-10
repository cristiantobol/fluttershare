import 'package:flutter/material.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/cupertino.dart';


final GoogleSignIn googleSignIn = GoogleSignIn();

void main() async {
  runApp(MyApp());
  
//  SystemChrome.setSystemUIOverlayStyle(
//    SystemUiOverlayStyle(
//    statusBarColor: Colors.redAccent,
//    statusBarIconBrightness: Brightness.dark, //top bar icons
//    //systemNavigationBarColor: Colors.red, //bottom bar color
//    //systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
//  ));
}

class MyApp extends StatelessWidget {
//   final materialThemeData = ThemeData(
//     primarySwatch: Colors.blue,
//     scaffoldBackgroundColor: Colors.white,
//     accentColor: Colors.blue,
//     appBarTheme: AppBarTheme(color: Colors.blue.shade600),
//     primaryColor: Colors.blue,
//     secondaryHeaderColor: Colors.blue,
//     canvasColor: Colors.blue,
//     backgroundColor: Colors.red,
//     textTheme: TextTheme().copyWith(body1: TextTheme().body1));
// final cupertinoTheme = CupertinoThemeData(
//     primaryColor: Colors.blue,
//     barBackgroundColor: Colors.blue,
//     scaffoldBackgroundColor: Colors.white);

  @override
  Widget build(BuildContext context) {
    // return PlatformApp(
    //   debugShowCheckedModeBanner: false,
    //   android: (_) => MaterialAppData(theme: materialThemeData),
    //   ios: (_) => CupertinoAppData(theme: cupertinoTheme),
    //   home: Home()
    // );
    return MaterialApp(
        title: 'FlutterShare',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff6042DE),
          accentColor: Color(0xffFFA800),
        ),
        home: SplashScreen(
          imageBackground: AssetImage(
            'assets/images/splash.jpg',
          ),
          seconds: 5,
          navigateAfterSeconds: Home(),
          //loaderColor: Colors.red,
        ),
      );
  }
}
