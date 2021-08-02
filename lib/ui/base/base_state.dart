import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../application.dart';
import '../../utils/localize/app_localization.dart';
import 'base_bloc.dart';

abstract class BaseState<W extends StatefulWidget, B extends BaseBloc>
    extends State<W> {
  late B bloc;
  late BuildContext mContext;
  final blocFactory = Application().blocProviderFactory;

  void onListenerStream();

  @override
  void initState() {
    bloc = blocFactory.createBlocClass(B);
    onListenerStream();
    bloc.progressBar.listen((value) {
      if (value) {
        showLoading();
      }
    });
    bloc.trackingError.listen((value) {
      if (value.isEmpty) {
        return;
      }
      showMyDialog(value);
    });
    super.initState();
  }

  void showLoading() async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          mContext = context;
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void showMyDialog(String message)  {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Thông báo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String getString(String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  bool isDarkMode() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    return darkModeOn;
  }

  Color gradient1 = Color.fromRGBO(238, 9, 121, 1);
  Color gradient2 = Color.fromRGBO(255, 106, 0, 1);
}
