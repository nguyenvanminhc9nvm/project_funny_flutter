import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';
import 'package:project_funny_flutter/utils/localize/app_localization.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getString(String key) => AppLocalization.of(context).translate(key);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          getString("key_menu_title"),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.w),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, privacy);
              },
              child: _buildButton(context, "key_privacy"),
            ),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, feedback);
              },
              child: _buildButton(context, "key_feedback"),
            ),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, licence);
              },
              child: _buildButton(context, "key_licence"),
            )
          ],
        ),
      ),
    );
  }

  Row _buildButton(BuildContext context, String key) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalization.of(context).translate(key),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
          ),
          Icon(Icons.arrow_forward_ios)
        ],
      );
}
