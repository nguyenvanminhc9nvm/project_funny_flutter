import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../application.dart';

typedef AsyncCallback<T> = Function(T);

abstract class BaseBloc implements Disposable {
  final progressBar = PublishSubject<bool>();
  final trackingError = PublishSubject<String>();
  final dataManager = Application().dataManager;
  final CompositeSubscription compositeSubscription = CompositeSubscription();

  void coroutineScope<T>(Future<T> asyncCallback, AsyncCallback<T> response,
      {bool isShowLoading = true}) async {
    void showLoading({required bool isShow}) {
      if (!isShowLoading) return;
      progressBar.add(isShow);
    }

    showLoading(isShow: true);
    try {
      var result = await asyncCallback;
      showLoading(isShow: false);
      response(result);
    } catch (ex) {
      showLoading(isShow: false);
      print("error $ex");
    }
  }

  @override
  void dispose() {
    trackingError.close();
    progressBar.close();
    compositeSubscription.dispose();
  }
}

abstract class Disposable {
  void dispose();
}
class BlocProvider<T extends BaseBloc> extends StatefulWidget {
  BlocProvider({
    Key? key,
    required this.child,
    required this.bloc,
  }) : super(key: key);
  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() {
    return _BlocProviderState();
  }

  static T of<T extends BaseBloc>(BuildContext context) {
    final _BlocProviderInherited<T>? blocProvider = context
        .getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>()
        ?.widget as _BlocProviderInherited<T>?;
    // var block = context.dependOnInheritedWidgetOfExactType<_BlocProviderInherited<T>>();
    return blocProvider!.bloc;
  }
}

class _BlocProviderState<T extends BaseBloc> extends State<BlocProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited(child: widget.child, bloc: widget.bloc);
  }
}

class _BlocProviderInherited<T extends BaseBloc> extends InheritedWidget {
  _BlocProviderInherited({
    Key? key,
    required Widget child,
    required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) {
    return false;
  }
}
