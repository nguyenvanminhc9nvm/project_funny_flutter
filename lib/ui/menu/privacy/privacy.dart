import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_funny_flutter/utils/localize/app_localization.dart';

class Privacy extends StatelessWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getString(String key) => AppLocalization.of(context).translate(key);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          getString("key_privacy"),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(getString("key_licence_article"), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 23.sp
        ),),
      ),
    );
  }
}
