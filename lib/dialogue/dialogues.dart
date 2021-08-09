import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';


class Dialogues{

  static ProgressDialog _pr;

  static Future showProgressDialogue( BuildContext context ,String msg) async{
    if(_pr !=null) _pr = null;

    _pr =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: false);

    _pr.style(
        message: msg,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        textAlign: TextAlign.center,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );

    await _pr.show();

  }

  static Future updateProgressDialogue(String msg) async{
    if(_pr!=null&&_pr.isShowing()){
        _pr.update(
        progress: 50.0,
        message: msg,
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
      );
    }
  }

  static Future hideProgressDialogue() async{
    if(_pr!=null&&_pr.isShowing()){
      await _pr.hide();
    }

  }

}