import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:coffeepos/provider/LoginProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';

import '../Model/classessModel.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

class classess extends StatefulWidget {
  @override
  State<classess> createState() => _NotificationsState();
}

class _NotificationsState extends State<classess> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController dateinputC = TextEditingController();
  TextEditingController _ClassDescFieldController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ThemP = Provider.of<Them>(context, listen: false);

    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    return Stack(children: <Widget>[
      Image.asset(
        "assets/background2.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          floatingActionButton: Align(
            alignment: new FractionalOffset(0.55, 1.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: FloatingActionButton(
                backgroundColor: HexColor(ThemP.getcolor()),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  addClasses(context);
                },
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage('addclasses'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HexColor((Globalvireables.secondcolor)),
                  HexColor((ThemP.getcolor()))
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
                  height: MediaQuery.of(context).size.height / 1.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/background2.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0)),
                  ),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              width: Globalvireables.getDeviceType()=='tablet'?
                              MediaQuery.of(context).size.width/1.2: MediaQuery.of(context).size.width,
                              child: TextField(
                                onChanged: (content) {
                                  setState(() {});
                                },
                                controller: dateinputC,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: HexColor(ThemP.getcolor()),
                                    size: 27 * unitHeightValue,
                                  ),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        dateinputC.text = '';
                                        setState(() {});
                                      },
                                      child: Icon(
                                          color: Colors.redAccent,
                                          dateinputC.text.isEmpty ||
                                                  dateinputC.text.toString() ==
                                                      LanguageProvider.Llanguage(
                                                          'Search')
                                              ? null
                                              : Icons.cancel)),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor(ThemP.getcolor()),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor(ThemP.getcolor()),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0)),
                                  contentPadding: EdgeInsets.only(
                                      top: 18, bottom: 18, right: 20, left: 20),
                                  fillColor: HexColor(Globalvireables.white),
                                  filled: true,
                                  hintText: LanguageProvider.Llanguage("Search"),
                                ),
                                //a  readOnly: true,  //set it true, so that user will not able to edit text
                                onTap: () async {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(

                              height: MediaQuery.of(context).size.height / 1.345,
                              width: MediaQuery.of(context).size.width / 1,
                              child: FutureBuilder(
                                future: getAllClasses(
                                    context, Loginprovider.coffeeId.toString()),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<classessModel>> snapshot) {
                                  if (snapshot.hasData) {
                                    List<classessModel>? Visits = snapshot.data;

                                    List<classessModel>? search = Visits!
                                        .where((element) => element.classname
                                            .toString()
                                            .contains(dateinputC.text.toString()))
                                        .toList();

                                    return GridView(
                                      gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: Globalvireables.getDeviceType()=='tablet'?6: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        mainAxisExtent: 200,
                                      ),
                                      children: search!
                                          .map((classessModel v) => Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {

                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return Expanded(
                                                                child: AlertDialog(
                                                                  title: Text(
                                                                      LanguageProvider.Llanguage(
                                                                          'delete'),
                                                                      style: ArabicTextStyle(
                                                                          arabicFont:
                                                                          ArabicFont.tajawal,
                                                                          fontSize: 22 *
                                                                              unitHeightValue)),
                                                                  content: Text(
                                                                    LanguageProvider.Llanguage(
                                                                        "txxt"),
                                                                    style: ArabicTextStyle(
                                                                        arabicFont:
                                                                        ArabicFont.tajawal,
                                                                        fontSize:
                                                                        14 * unitHeightValue),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      //  textColor: Colors.black,
                                                                      onPressed: () {

                                                                        deleteClass(context, v.id
                                                                            .toString() );
                                                                      },
                                                                      child: Text(
                                                                        LanguageProvider.Llanguage(
                                                                            'delete'),
                                                                        style: ArabicTextStyle(
                                                                            arabicFont:
                                                                            ArabicFont.tajawal,
                                                                            color: Colors.redAccent,
                                                                            fontSize: 15 *
                                                                                unitHeightValue),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      // textColor: Colors.black,
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Text(
                                                                        LanguageProvider.Llanguage(
                                                                            'cancel'),
                                                                        style: ArabicTextStyle(
                                                                            arabicFont:
                                                                            ArabicFont.tajawal,
                                                                            color: Colors.black87,
                                                                            fontSize: 15 *
                                                                                unitHeightValue),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );


                                                        },
                                                        child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: Colors
                                                                  .redAccent,
                                                              size: 30,
                                                            )),
                                                      ),
                                                      Spacer(),
                                                      SizedBox(
                                                        width: 100,
                                                        height: 100,
                                                        child: Image(
                                                            image:
                                                                new NetworkImage(v
                                                                    .classimage
                                                                    .toString())),
                                                      ),
                                                      Spacer(),
                                                      SizedBox(
                                                        child: Container(
                                                          width: 100,
                                                          child: Text(
                                                            textAlign:
                                                                TextAlign.center,
                                                            v.classname
                                                                    .toString() +
                                                                "",
                                                            style: ArabicTextStyle(
                                                                arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 18 *
                                                                    unitHeightValue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    );
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
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
            ),
          )),
    ]);
  }

  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      Navigator.push( context,
        MaterialPageRoute(builder: (context) => nav[index]),
      );
    });
  }


  int selectedIndex = 1;

  final List<Widget> nav = [
    Home(),
    Home(),
    Home(),
  ];

  Future<List<classessModel>> getAllClasses(
      BuildContext c, String coffeeid) async {
    Uri postsURL = Uri.parse('https://poscoffeesystem.000webhostapp.com/getClassess.php');
    try {
      var map = new Map<String, dynamic>();
      map['coffeid'] = coffeeid;

      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        print("Profile" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<classessModel> Doctors = body
            .map(
              (dynamic item) => classessModel.fromJson(item),
            )
            .toList();

        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";
      }
    } catch (e) {
    }

    throw "Unable to retrieve Profile.";
  }

  Future<String?> addClasses(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Center(child: Text(LanguageProvider.Llanguage('addclasses'))),
            content: TextField(
              textAlign: TextAlign.center,
              controller: _ClassDescFieldController,
              decoration: InputDecoration(hintText: "اسم الصنف"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(LanguageProvider.Llanguage('cancel')),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: Text(LanguageProvider.Llanguage('save')),
                onPressed: () => SaveClass(
                    context, _ClassDescFieldController.text.toString()),
              ),
            ],
          );
        });
  }

  SaveClass(BuildContext context, String desc) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(l.Llanguage('addclasses')),
              content: Text(l.getLanguage() == "AR"
                  ? 'اضافه الاصناف ...'
                  : 'Add class..'),
            ));

    var map = new Map<String, dynamic>();
    map['classname'] = desc;
    map['coffeid'] = Loginprovider.coffeeId.toString();

    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/addClassess.php');

      http.Response response = await http
          .post(
            apiUrl,
            body: map,
          )
          .whenComplete(() => Navigator.pop(context));



      if (response.body.toString().contains('1S')) {
        Navigator.pop(context);
        setState(() {

        });
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(l.Llanguage('addclasses')),
                  content: Text(l.getLanguage() == "AR"
                      ? 'تم اضافه الصنف'
                      : 'send class is done..'),
                ));
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(l.Llanguage('addclasses')),
                  content: Text(l.Llanguage('anerror')),
                ));
      }
    } catch (e) {
      Navigator.pop(context);
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(l.Llanguage('addclasses')),
          content: Text(l.Llanguage('anerror') + e.toString()),
          actions: <Widget>[],
        ),
      );
    }
  }


  deleteClass(BuildContext context, String classid) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(l.Llanguage('deleteclass')),
          content: Text(l.getLanguage() == "AR"
              ? 'جار حذف الصنف ...'
              : 'delete item ..'),
        ));

    var map = new Map<String, dynamic>();
    map['classid'] = classid;

    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/deleteClassess.php');

      http.Response response = await http
          .post(
        apiUrl,
        body: map,
      )
          .whenComplete(() => Navigator.pop(context));

print("response.toString()"+response.body.toString());

      if (response.body.toString().contains('1S')) {
        Navigator.pop(context);
        setState(() {

        });
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(l.Llanguage('deleteclass')),
              content: Text(l.getLanguage() == "AR"
                  ? 'تم حذف الصنف بنجاح'
                  : 'delete item is done..'),
            ));
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(l.Llanguage('deleteclass')),
              content: Text(l.Llanguage('anerror')),
            ));
      }
    } catch (e) {
      Navigator.pop(context);

      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(l.Llanguage('deleteclass')),
          content: Text(l.Llanguage('anerror')+e.toString()),
          actions: <Widget>[],
        ),
      );
    }
  }


}
