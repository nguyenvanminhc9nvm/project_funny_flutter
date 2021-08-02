import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';
import 'package:project_funny_flutter/utils/localize/app_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class Licence extends StatelessWidget {
  const Licence({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getString(String key) => AppLocalization.of(context).translate(key);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          getString("key_licence"),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              getString("key_licence_article_1"),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.sp
              ),
            ),
            InkWell(
              onTap: () {
                launch(
                  getString("key_licence_article_2"),
                );
              },
              child: Text(
                getString("key_licence_article_2"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23.sp,
                  color: Colors.blue
                ),
              ),
            ),
            InkWell(onTap: () {
              launch(
                getString("key_licence_article_2"),
              );
            },child: Image.asset(icLogoFlatIcon)),
            Text(
              getString("key_licence_article_3"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23.sp
              ),
            ),
            Image.asset(icLogoFb)
          ],
        ),
      ),
    );
  }
}
