import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class BillProvider extends ChangeNotifier {
  String? classid='-1';

  getclassid() {
    return classid;
  }

  setclassid(String classid) {
    this.classid = classid;
    notifyListeners();
  }




}