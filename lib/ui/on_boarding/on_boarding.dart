import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_funny_flutter/data/model/local/on_boar.dart';
import 'package:project_funny_flutter/ui/base/base_state.dart';
import 'package:project_funny_flutter/ui/on_boarding/on_boarding_bloc.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends BaseState<OnBoarding, OnBoardingBloc> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<OnBoar>>(
        future: bloc.doGetListOnBoar(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OnBoar> list = snapshot.data as List<OnBoar>;
            return Stack(
              children: [
                Positioned.fill(
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    children: [
                      _buildItemOb(list[0]),
                      _buildItemOb(list[1]),
                      _buildItemOb(list[2]),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: TextButton(
                    onPressed: () {
                      if (_controller.page == 2) {
                        Navigator.pushReplacementNamed(context, home);
                        bloc.loggedInToApp();
                      } else {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }
                    },
                    child: Text(
                      "TIẾP",
                      style: TextStyle(color: color_blue),
                    ),
                  ),
                ),
              ],
            );
          }
          return Text("no data");
        },
      ),
    );
  }

  Container _buildItemOb(OnBoar onBoar) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            onBoar.imgContent,
            fit: BoxFit.fitWidth,
          )),
          Positioned(
            top: 76.h,
            left: 1,
            right: 1,
            child: onBoar.imageUrl == icObThird
                ? Image.asset(
                    onBoar.imageUrl,
                    width: 353.w,
                    height: 358.h,
                  )
                : Image.asset(
                    onBoar.imageUrl,
                    width: 236.w,
                    height: 236.h,
                  ),
          ),
          Positioned(
            bottom: 314.h,
            left: 0,
            right: 0,
            child: Container(
              child: Text(
                getString(onBoar.title),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 232.h,
            left: 0,
            right: 0,
            child: Text(
              getString(onBoar.content),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20.sp,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onListenerStream() {}
}
