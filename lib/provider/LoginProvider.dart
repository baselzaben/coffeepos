import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class LoginProvider extends ChangeNotifier {
  String? coffeeId;
  String? id;
  String? image;
  String? name;
  String? passwordd;
  String? phone;
  String? username;
  String? usertype;
  String? locationn;
  String? coffename;
  String? message='';

  String? maxinv='0';

/////
  String? inititem;
  String? debitpersion;
  String? debtbook;
  String? addqt;
  String? report;


  String? ip;
  String? Appmessage;
  String? terms;
  String? version;
  String? link;
  String? show;
////

  getshow() {
    return show;
  }

  setshow(String show) {
    this.show = show;
    notifyListeners();
  }


  getlink() {
    return link;
  }

  setlink(String link) {
    this.link = link;
    notifyListeners();
  }


  getip() {
    return ip;
  }

  setip(String ip) {
    this.ip = ip;
    notifyListeners();
  }


  getversion() {
    return version;
  }

  setversion(String version) {
    this.version = version;
    notifyListeners();
  }

  getterms() {
    return terms;
  }

  setterms(String terms) {
    this.terms = terms;
    notifyListeners();
  }

  getAppmessage() {
    return Appmessage;
  }

  setAppmessage(String Appmessage) {
    this.Appmessage = Appmessage;
    notifyListeners();
  }



////

  getinititem() {
    return inititem;
  }

  setinititem(String inititem) {
    this.inititem = inititem;
    notifyListeners();
  }
  getdebitpersion() {
    return debitpersion;
  }

  setdebitpersion(String debitpersion) {
    this.debitpersion = debitpersion;
    notifyListeners();
  }

  getdebtbook() {
    return debtbook;
  }

  setdebtbook(String debtbook) {
    this.debtbook = debtbook;
    notifyListeners();
  }

  getaddqt() {
    return addqt;
  }

  setaddqt(String addqt) {
    this.addqt = addqt;
    notifyListeners();
  }

  getreport() {
    return report;
  }

  setreport(String report) {
    this.report = report;
    notifyListeners();
  }
  ////
  getmessage() {
    return message;
  }

  setmessage(String message) {
    this.message = message;
    notifyListeners();
  }

  getmaxinv() {
    return maxinv;
  }

  setmaxinv(String maxinv) {
    this.maxinv = maxinv;
    notifyListeners();
  }



  getcoffename() {
    return coffename;
  }

  setcoffename(String coffename) {
    this.coffename = coffename;
    notifyListeners();
  }


  getlocationn() {
    return locationn;
  }

  setlocationn(String locationn) {
    this.locationn = locationn;
    notifyListeners();
  }


  getusertype() {
    return usertype;
  }

  setusertype(String usertype) {
    this.usertype = usertype;
    notifyListeners();
  }

  getusername() {
    return username;
  }

  setusername(String username) {
    this.username = username;
    notifyListeners();
  }


  getphone() {
    return phone;
  }

  setphone(String phone) {
    this.phone = phone;
    notifyListeners();
  }

  getpasswordd() {
    return passwordd;
  }

  setpasswordd(String passwordd) {
    this.passwordd = passwordd;
    notifyListeners();
  }


  getname() {
    return name;
  }

  setname(String name) {
    this.name = name;
    notifyListeners();
  }


  getimage() {
    return image;
  }

  setimage(String image) {
    this.image = image;
    notifyListeners();
  }

  getid() {
    return id;
  }

  setid(String id) {
    this.id = id;
    notifyListeners();
  }

  getcoffeeId() {
    return coffeeId;
  }

  setcoffeeId(String coffeeId) {
    this.coffeeId = coffeeId;
    notifyListeners();
  }



}