import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:coffeepos/provider/LoginProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';

import '../Model/classessModel.dart';
import '../Model/itemsModel.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

class Qtitems extends StatefulWidget {
  @override
  State<Qtitems> createState() => _NotificationsState();
}

class _NotificationsState extends State<Qtitems> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController dateinputC = TextEditingController();
  TextEditingController _ClassDescFieldController = TextEditingController();
  TextEditingController addedQTController = TextEditingController();

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
      /*    floatingActionButton: Align(
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
          ),*/
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage('addQtitems'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.0,
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
                  height: MediaQuery.of(context).size.height / 1.24,
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
                          SizedBox(
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 1.345,
                            width: MediaQuery.of(context).size.width / 1,
                            child: FutureBuilder(
                              future: getAllQtitems(
                                  context, Loginprovider.coffeeId.toString()),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<itemsModel>> snapshot) {
                                if (snapshot.hasData) {
                                  List<itemsModel>? Visits = snapshot.data;

                                  List<itemsModel>? search = Visits!
                                      .where((element) => element.itemname
                                      .toString()
                                      .contains(dateinputC.text.toString()))
                                      .toList();

                                  return  Padding(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    child: ListView(
                                      children: search!
                                          .map((itemsModel v) => Card(
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
                                                          title: Center(
                                                            child: v.enableqt.toString()=='1'?Text(
                                                                (
                                                                    v.nowqt.toString()+' : الكميه الحاليه هي  '),
                                                                style: ArabicTextStyle(
                                                                    arabicFont:
                                                                    ArabicFont.tajawal,
                                                                    fontSize: 18 *
                                                                        unitHeightValue)):
                                                            Text(
                                                                (
                                                                   '--'),
                                                                style: ArabicTextStyle(
                                                                    arabicFont:
                                                                    ArabicFont.tajawal,
                                                                    fontSize: 18 *
                                                                        unitHeightValue)),
                                                          ),
                                                          content:  TextField(
                                                            keyboardType: TextInputType.number,
                                                            textAlign: TextAlign.center,
                                                            controller: addedQTController,
                                                            decoration: InputDecoration(hintText: "الكميه المراد اضافتها"),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              //  textColor: Colors.black,
                                                              onPressed: () {

                                                                if(v.enableqt.toString()=='1')
                                                                {
                                                                  AddQT(context,v.id.toString(),int.parse(v.nowqt.toString())+int.parse(addedQTController.text.toString()),'add');
                                                                }else{
                                                                  AddQT(context,v.id.toString(),int.parse(v.nowqt.toString())+int.parse(addedQTController.text.toString()),'enable');

                                                                }
                                                              },
                                                              child: Text(
                                                                LanguageProvider.Llanguage(
                                                                    'Add'),
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


                                                            TextButton(
                                                              // textColor: Colors.black,
                                                              onPressed: () {

                                                                AddQT(context,v.id.toString(),int.parse(v.nowqt.toString())+int.parse(addedQTController.text.toString()),'disable');




                                                              },
                                                              child: Text(
                                                               'ايقاف المخزون',
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
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width/2.8,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(
                                                          textAlign:
                                                          TextAlign.center,
                                                          v.itemname
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
                                                    Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: v.enableqt.toString()=='1'?Text(
                                                        textAlign:
                                                        TextAlign.center,
                                                        v.nowqt
                                                            .toString() +
                                                            "",
                                                        style: ArabicTextStyle(
                                                            arabicFont:
                                                            ArabicFont
                                                                .tajawal,
                                                            color: int.parse(v.nowqt
                                                                .toString())>20?
                                                            Colors.green:Colors.redAccent,
                                                            fontSize: 18 *
                                                                unitHeightValue,
                                                            fontWeight:
                                                            FontWeight
                                                                .w900),
                                                      ):Text(
                                                        textAlign: TextAlign.center,
                                                       'المخزون غير مفعل',
                                                        style: ArabicTextStyle(
                                                            arabicFont: ArabicFont
                                                                .tajawal,
                                                            color: Colors.redAccent,
                                                            fontSize: 12 *
                                                                unitHeightValue,
                                                            fontWeight:
                                                            FontWeight
                                                                .w400),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Icon(Icons.add,size: 40,color: HexColor(ThemP.getcolor()))
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                    ),/*GridView(
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:  Globalvireables.getDeviceType()=='tablet'?6: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        mainAxisExtent: 230,
                                      ),
                                      children: search!
                                          .map((itemsModel v) => Card(
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
                                                                "txxtitem"),
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
                                                                deleteItem(context,v.id.toString());
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
                                                        .itemimage
                                                        .toString())),
                                              ),
                                              Spacer(),
                                              SizedBox(
                                                child: Container(
                                                  width: 100,
                                                  child: Text(
                                                    textAlign:
                                                    TextAlign.center,
                                                    v.itemname
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
                                    ),*/
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Container(
                                        child: SvgPicture.asset(
                                          "assets/nodata.svg",
                                        ),
                                      ),

                                      Text(
                                        textAlign: TextAlign.center,
                                        "يجب تعريف المواد من شاشة تعريف المواد ثم يمكنك إضافة الكميات"   ,
                                        style: ArabicTextStyle(arabicFont: ArabicFont.tajawal,
                                            color: Colors.black, fontSize: 16 * unitHeightValue, fontWeight: FontWeight.w700),
                                      ),

                                    ],
                                  );
                                }
                              },
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
      Navigator.push(
        context,
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

  Future<List<itemsModel>> getAllQtitems(
      BuildContext c, String coffeeid) async {
    Uri postsURL = Uri.parse('https://coffepoint.net/Api/getitems.php');
    try {
      var map = new Map<String, dynamic>();
      map['coffeid'] = coffeeid;
      map['classid'] = '-1';

      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        print("Profile" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<itemsModel> Doctors = body
            .map(
              (dynamic item) => itemsModel.fromJson(item),
        )
            .toList();

        return Doctors;
      } else {
        print("Profile error " + res.statusCode.toString());

        throw "Unable to retrieve Profile.";
      }
    } catch (e) {
    }

    throw "Unable to retrieve Profile.";
  }

  Future<String?> addClasses(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    TextEditingController searchusercontroller = TextEditingController();
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);


    var itemVar='';

    TextEditingController itemanem = TextEditingController();
    TextEditingController itemorice = TextEditingController();
    TextEditingController iteminitprice = TextEditingController();
    TextEditingController classidc = TextEditingController();
    var ThemP = Provider.of<Them>(context, listen: false);


    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
            Center(child: Text(LanguageProvider.Llanguage('addclasses'))),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text('اسم الماده'),
                  TextField(
                    textAlign: TextAlign.center,
                    controller: itemanem,
                    decoration: InputDecoration(hintText: ""),
                  ),
                  SizedBox(height: 25,),
                  Text('سعر بيع الماده'),

                  TextField(
                    textAlign: TextAlign.center,
                    controller: itemorice,
                    decoration: InputDecoration(hintText: ""),
                  ),

                  SizedBox(height: 25,),
                  Text('سعر تكلفه الماده'),

                  TextField(
                    textAlign: TextAlign.center,
                    controller: iteminitprice,
                    decoration: InputDecoration(hintText: ""),
                  ),

                  SizedBox(height: 25,),
                  Text('صنف الماده'),


                  SizedBox(
                    child: SizedBox(
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: classidc,
                        //editing controller of this TextField
                        decoration: InputDecoration(




                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor(ThemP.getcolor()),
                                  width: 2.0),
                              borderRadius:
                              BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor(ThemP.getcolor()),
                                  width: 2.0),
                              borderRadius:
                              BorderRadius.circular(10.0)),
                          contentPadding: EdgeInsets.only(
                              top: 18, bottom: 18, right: 20, left: 20),
                          fillColor: HexColor(Globalvireables.white),
                          filled: true,
                          hintText: LanguageProvider.Llanguage('usersController'),
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          // _showTextInputDialog(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Container(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height /
                                          1.4,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          1.3,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                8.0),
                                            child: SizedBox(
                                              child: Text(
                                                  LanguageProvider.Llanguage('usersController'),
                                                  style: ArabicTextStyle(
                                                      arabicFont:
                                                      ArabicFont
                                                          .tajawal,
                                                      color: HexColor(
                                                          Globalvireables
                                                              .black2),
                                                      fontSize: 18 *
                                                          unitHeightValue,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700)),
                                            ),
                                          ),
                                          Divider(
                                              thickness: 1.0,
                                              color: Colors.grey),
                                          SizedBox(
                                            child: TextField(
                                              onChanged: (content) {
                                                setState(() {});
                                              },
                                              controller:
                                              searchusercontroller,
                                              //editing controller of this TextField
                                              decoration:
                                              InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.search,
                                                  color: HexColor(
                                                      ThemP.getcolor()),
                                                  size: 27 *
                                                      unitHeightValue,
                                                ),
                                                suffixIcon:
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        searchusercontroller
                                                            .text = '';
                                                      });
                                                    },
                                                    child: Icon(
                                                        null
                                                    )),
                                                border:
                                                OutlineInputBorder(),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: HexColor(
                                                            ThemP.getcolor()),
                                                        width: 2.0),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        10.0)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: HexColor(
                                                            ThemP.getcolor()),
                                                        width: 2.0),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        10.0)),
                                                contentPadding:
                                                EdgeInsets.only(
                                                    top: 18,
                                                    bottom: 18,
                                                    right: 20,
                                                    left: 20),
                                                fillColor: HexColor(
                                                    Globalvireables
                                                        .white),
                                                filled: true,
                                                hintText:
                                                LanguageProvider
                                                    .Llanguage(
                                                    "Search"),
                                              ),
                                              //a  readOnly: true,  //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                            MediaQuery.of(context)
                                                .size
                                                .height /
                                                2.8,
                                            width:
                                            MediaQuery.of(context)
                                                .size
                                                .width /
                                                1,
                                            child: FutureBuilder(
                                              future:
                                              getallclassess(context,Loginprovider.coffeeId.toString()),
                                              builder: (BuildContext
                                              context,
                                                  AsyncSnapshot<
                                                      List<
                                                          classessModel>>
                                                  snapshot) {
                                                if (snapshot.hasData) {
                                                  List<classessModel>?
                                                  Visits =
                                                      snapshot.data;

                                                  List<classessModel>? search = Visits!
                                                      .where((element) => element
                                                      .classname
                                                      .toString()
                                                      .contains(
                                                      searchusercontroller
                                                          .text
                                                          .toString()))
                                                      .toList();

                                                  return ListView(
                                                    children: search!
                                                        .map(
                                                            (classessModel
                                                        v) =>
                                                            Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    classidc.text = v.classname.toString();
                                                                    itemVar=v.id.toString();
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: SizedBox(
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Row(
                                                                            children: [

                                                                              Container(
                                                                                width:  MediaQuery.of(context).size.width/3,
                                                                                child: Text(
                                                                                  v.classname.toString(),
                                                                                  style: ArabicTextStyle(arabicFont: ArabicFont.tajawal,
                                                                                      color: Colors.black, fontSize: 16 * unitHeightValue,
                                                                                      fontWeight: FontWeight.w400),
                                                                                ),
                                                                              ),
                                                                              Spacer(),

                                                                              Container(
                                                                                width: 30,
                                                                                height: 50,
                                                                                child:  Image.network(
                                                                                  v.classimage.toString(),
                                                                                  height: MediaQuery.of(context).size.height,
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),



                                                                            ],
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                              ],
                                                            ))
                                                        .toList(),
                                                  );
                                                } else {
                                                  return Center(
                                                      child:
                                                      CircularProgressIndicator());
                                                }
                                              },
                                            ),
                                          ),
                                          Spacer(),
                                          Align(
                                            alignment:
                                            Alignment.bottomCenter,
                                            child: SizedBox(
                                              width:
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  4,
                                              child: ElevatedButton(
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  primary: HexColor(
                                                      ThemP.getcolor()),
                                                ),
                                                child: Text(
                                                  LanguageProvider
                                                      .Llanguage(
                                                      'cancel'),
                                                  style: ArabicTextStyle(
                                                      arabicFont:
                                                      ArabicFont
                                                          .tajawal,
                                                      color: HexColor(
                                                          Globalvireables
                                                              .white),
                                                      fontSize: 14 *
                                                          unitHeightValue),
                                                ),
                                                onPressed: () async {
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),











                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(LanguageProvider.Llanguage('cancel')),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: Text(LanguageProvider.Llanguage('save')),
                onPressed: () => SaveClass(
                  context, itemanem.text.toString(),
                  itemorice.text.toString(),
                  iteminitprice.text.toString(),
                  itemVar.toString(),),
              ),
            ],
          );
        });
  }

  SaveClass(BuildContext context, String itemname,String itemprice,
      String iteminitprice,String classid) async {
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
    map['itemname'] = itemname.toString();
    map['itemprice'] = itemprice.toString();
    map['classid'] = classid.toString();
    map['iteminitprice'] = iteminitprice.toString();

    map['coffeid'] = Loginprovider.getcoffeeId();


    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://coffepoint.net/Api/addQtitems.php');

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

  Future<List<classessModel>> getallclassess(
      BuildContext c, String coffeeid) async {
    Uri postsURL = Uri.parse('https://coffepoint.net/Api/getClassess.php');
    try {
      var map = new Map<String, dynamic>();
      map['coffeid'] = coffeeid;

      http.Response res = await http.post(
        postsURL,
        body: map,
      );


      print("inputt " + map.toString());


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

  AddQT(BuildContext context, String itemid ,int qt ,String type) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(l.Llanguage('addQtitems')),
          content: Text(l.getLanguage() == "AR"
              ? ' ...'
              : ' ..'),
        ));

    var map = new Map<String, dynamic>();
    map['itemid'] = itemid;
    map['qt'] = qt.toString();
    map['type'] = type;

    print(map.toString() + " inputt");
    try {

      Uri apiUrl = Uri.parse('https://coffepoint.net/Api/addqtitem.php');
      http.Response response = await http
          .post(apiUrl, body: map,)
          .whenComplete(() => Navigator.pop(context));

      print("response.toString()"+response.body.toString());

      if (response.body.toString().contains('1S')) {
        Navigator.pop(context);
        setState(() {

        });
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(l.Llanguage('addQtitems')),
              content: Text(l.getLanguage() == "AR"
                  ? 'تم اضافه الماده بنجاح'
                  : 'delete item is done..'),
            ));
        setState(() {

        });
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(l.Llanguage('addQtitems')),
              content: Text(l.Llanguage('anerror')),
            ));
      }
    } catch (e) {
      Navigator.pop(context);

      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(l.Llanguage('addQtitems')),
          content: Text(l.Llanguage('anerror')+e.toString()),
          actions: <Widget>[],
        ),
      );
    }
  }



}
