import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_funny_flutter/ui/base/base_state.dart';
import 'package:project_funny_flutter/ui/home/animals/animals.dart';
import 'package:project_funny_flutter/ui/home/games/games.dart';
import 'package:project_funny_flutter/ui/home/gif/gif.dart';
import 'package:project_funny_flutter/ui/home/home_bloc.dart';
import 'package:project_funny_flutter/ui/home/picture/picture.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends BaseState<Home, HomeBloc> {
  int _selectedIndex = 0;

  final _pages = [Picture(), Animals(), Games(), Gif()];

  PageController _controllerPicture = PageController(viewportFraction: 0.9);
  PageController _controllerGif = PageController(viewportFraction: 0.9);
  PageController _controllerAnimals = PageController(viewportFraction: 0.9);
  PageController _controllerGames = PageController(viewportFraction: 0.9);

  Widget _bottomNavigationBar(int selectedIndex) => BottomAppBar(
        shape: CircularNotchedRectangle(),
        //shape of notch
        notchMargin: 5,
        //notch margin between floating button and bottom appbar
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: IconButton(
                  icon: Icon(
                    Icons.auto_awesome_mosaic,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  }),
            ),
            Expanded(
              child: IconButton(
                  icon: Container(
                    child: Image.asset(
                      icAnimals,
                      width: 25.w,
                      height: 25.h,
                    ),
                  ),
                  onPressed: () {
                    setState(() {

                      _selectedIndex = 1;
                    });
                  }),
            ),
            Spacer(),
            Expanded(
              child: IconButton(
                  icon: Container(
                    child: Icon(
                      Icons.videogame_asset,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  }),
            ),
            Expanded(
              child: IconButton(
                  icon: Container(
                    child: Icon(
                      Icons.language,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  }),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: color_blue_100,
        onPressed: () {
          if (_selectedIndex == 0) {
            _controllerPicture.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          }

          if (_selectedIndex == 1) {
            _controllerAnimals.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          }

          if (_selectedIndex == 2) {
            _controllerGames.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          }

          if (_selectedIndex == 3) {
            _controllerGif.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          }
        },
        child: Icon(
          Icons.arrow_forward_rounded,
          size: 30,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: HomeProviderController(
        controller1: _controllerPicture,
        controller2: _controllerGif,
        controller3: _controllerAnimals,
        controller4: _controllerGames,
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 30,
              ),
            ],
          ),
          child: _bottomNavigationBar(_selectedIndex)),
    );
  }

  @override
  void onListenerStream() {
    // TODO: implement onListenerStream
  }
}

class HomeProviderController extends InheritedWidget {
  final PageController controller1;
  final PageController controller2;
  final PageController controller3;
  final PageController controller4;

  HomeProviderController({
    Key? key,
    required Widget child,
    required this.controller1,
    required this.controller2,
    required this.controller3,
    required this.controller4,
  }) : super(key: key, child: child);

  static HomeProviderController of(BuildContext context) {
    final HomeProviderController? result =
        context.dependOnInheritedWidgetOfExactType<HomeProviderController>();
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
