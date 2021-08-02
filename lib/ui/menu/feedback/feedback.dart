import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_funny_flutter/ui/base/base_state.dart';
import 'package:project_funny_flutter/ui/menu/feedback/feedback_bloc.dart';
import 'package:project_funny_flutter/utils/localize/app_localization.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends BaseState<FeedBack, FeedbackBloc> {
  TextEditingController _controller = TextEditingController();

  String textButton = "Send";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          getString("key_feedback"),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.loose,
                flex: 8,
                child: Platform.isIOS
                    ? CupertinoTextField(
                        controller: _controller,
                        placeholder: getString("key_feedback_hint"),
                        textAlignVertical: TextAlignVertical.top,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      )
                    : TextField(
                        controller: _controller,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: getString("key_feedback_hint"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_controller.text.isEmpty) {
                        setState(() {
                          textButton = "error";
                        });
                        return;
                      }
                      bloc.insertComment(_controller.text);
                      setState(() {
                        textButton = "Complete";
                      });
                    },
                    child: Text(textButton),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onListenerStream() {
    // TODO: implement onListenerStream
  }
}
