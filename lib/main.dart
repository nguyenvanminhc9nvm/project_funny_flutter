import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_funny_flutter/ui/home/home.dart';
import 'package:project_funny_flutter/ui/menu/feedback/feedback.dart';
import 'package:project_funny_flutter/ui/menu/licence/licence.dart';
import 'package:project_funny_flutter/ui/menu/menu.dart';
import 'package:project_funny_flutter/ui/menu/privacy/privacy.dart';
import 'package:project_funny_flutter/ui/on_boarding/on_boarding.dart';
import 'package:project_funny_flutter/ui/splash/splash.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';
import 'package:project_funny_flutter/utils/localize/app_localization.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // status bar color
    systemNavigationBarColor: Colors.white
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          onBoarding: (context) => OnBoarding(),
          home: (context) => Home(),
          menu: (context) => Menu(),
          feedback: (context) => FeedBack(),
          privacy: (context) => Privacy(),
          licence: (context) => Licence(),
        },
        supportedLocales: [Locale("vi", "VN"), Locale("en", "US")],
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == (locale!.languageCode) &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Splash(),
      ),
    );
  }
}

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> users =
        FirebaseFirestore.instance.collection('tb_funny_image').snapshots();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: users,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return new ListTile(
                title: Image.network(data['image']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
