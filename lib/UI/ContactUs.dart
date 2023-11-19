import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Bill.dart';
import 'Home.dart';
import 'Settings.dart';

class ContactUs extends StatefulWidget {
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final phonenum = TextEditingController();
  final notecontroller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    var Loginproviderr = Provider.of<LoginProvider>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);

    var colors = [HexColor((Globalvireables.secondcolor)), HexColor((ThemP.getcolor()))];
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [ 0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    return Stack(children: <Widget>[
      Image.asset(
        "assets/background2.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            selectedItemColor: HexColor(Globalvireables.white),
            unselectedItemColor: Colors.white,
            backgroundColor: HexColor(ThemP.getcolor()),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: LanguageProvider.Llanguage('settings'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: LanguageProvider.Llanguage('Home')
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: LanguageProvider.Llanguage('profile')
              ),
            ],
            iconSize: 30 * unitHeightValue,
            unselectedFontSize: 12 * unitHeightValue,
            selectedFontSize: 16 * unitHeightValue,
            showUnselectedLabels: true,
            currentIndex: selectedIndex,
            selectedIconTheme:
            IconThemeData(color: HexColor(Globalvireables.white)),
            onTap: _onItemTapped,
          ),

          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(context,'تواصل معنا', unitHeightValue,LanguageProvider.langg,LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/1.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HexColor((Globalvireables.secondcolor)), HexColor((ThemP.getcolor()))
                ],
                stops: stops,
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),
            child: SafeArea(

              child: Container(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.24,
                  decoration: BoxDecoration(

                    image: DecorationImage(
                      image: AssetImage("assets/background2.png"),
                      fit: BoxFit.cover,
                    ),

                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(0.0),
                        bottomLeft: Radius.circular(40.0)),
                  ),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        SizedBox(height: 20,),

                        Container(
                            margin: EdgeInsets.only(
                                left: 25, right: 25, top: 10),
                            child: TextField(
                              controller: phonenum,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(
                                            Globalvireables.black),
                                        width: 0.0),
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(
                                            ThemP.getcolor()),
                                        width: 1.0),
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                contentPadding: EdgeInsets.only(
                                    top: 18,
                                    bottom: 18,
                                    right: 20,
                                    left: 20),
                                fillColor:
                                HexColor(Globalvireables.white),
                                filled: true,
                                hintText:
                                    "رقم هاتفك",
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                left: 25, right: 25, top: 10),
                            child: TextField(
                              controller: notecontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(
                                            Globalvireables.black),
                                        width: 0.0),
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(
                                            ThemP.getcolor()),
                                        width: 1.0),
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                contentPadding: EdgeInsets.only(
                                    top: 18,
                                    bottom: 18,
                                    right: 20,
                                    left: 20),
                                fillColor:
                                HexColor(Globalvireables.white),
                                filled: true,
                                hintText:
                                    "الملاحظه",
                              ),
                            )),


                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 50,
                            width:
                            MediaQuery.of(context).size.width / 1.2,
                            margin: EdgeInsets.only(top: 40, bottom: 5),
                            color: HexColor(Globalvireables.white),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                HexColor(ThemP.getcolor()),
                              ),
                              child: Text(
                                ('ارسال'),
                                style: ArabicTextStyle(
                                    arabicFont: ArabicFont.tajawal,
                                    color:
                                    HexColor(Globalvireables.white),
                                    fontSize: 13 * unitHeightValue),
                              ),
                              onPressed: () async {
                                SendNote(context);
                              },
                            ),
                          ),
                        ),




                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    ]);
  }
  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nav[index]),);
    });
  }
  int selectedIndex = 1;

  final List<Widget> nav = [
    Settings(),
    Home(),
    Bill()

  ];

  SendNote(BuildContext context ) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();



    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('تواصل معنا'),
          content: Text(l.getLanguage() == "AR"
              ? 'ارسال الملاحظه ...'
              : 'update password..'),
        ));


    var map = new Map<String, dynamic>();
    map['phone'] = phonenum.text.toString();
    map['note'] = notecontroller.text.toString();
    map['coffeid'] = Loginprovider.coffeeId.toString();
    map['name'] = Loginprovider.name.toString();


    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://coffepoint.net/Api/addnote.php');

      http.Response response = await http
          .post(apiUrl,body: map,).whenComplete(() => Navigator.pop(context));

      print("OUT   : "+response.body.toString());

      if (response.body.toString().contains('1S')) {
        Navigator.pop(context);


        setState(() {});


        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(''),
              content: Icon(Icons.cloud_done_rounded,color: Colors.green,size: 55,),
            ));
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('ارسال الملاحظه'),
              content: Text(l.Llanguage('anerror')),
            ));
      }
    } catch (e) {
      Navigator.pop(context);
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('ارسال الملاحظه'),
          content: Text(l.Llanguage('anerror') + e.toString()),
          actions: <Widget>[],
        ),
      );
    }
  }

}
