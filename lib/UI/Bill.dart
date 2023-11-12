import 'dart:async';
import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:coffeepos/provider/BillProvider.dart';
import 'package:coffeepos/provider/LoginProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';

import '../Model/classessModel.dart';
import '../Model/itemsModel.dart';
import '../Model/maxmodel.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;


import 'dart:math' as math;import 'dart:convert';

class Bill extends StatefulWidget {
  @override
  State<Bill> createState() => _NotificationsState();
}

class _NotificationsState extends State<Bill> {
  Timer? timer;

  @override
  void initState() {



    getMaxId(context);
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => getMaxId(context));
    super.initState();

  }

  TextEditingController dateinputC = TextEditingController();
  TextEditingController _ClassDescFieldController = TextEditingController();

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List<itemsModel>? cart =[];
  List<itemsModel>? inititem =[];
var total=0.0;

  @override
  Widget build(BuildContext context) {
    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;


    var stops = [0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var billprovider = Provider.of<BillProvider>(context, listen: false);

    return Stack(children: <Widget>[
      Image.asset(
        "assets/background2.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage('bill') + " "+Loginprovider.getmaxinv(),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
          ),
    bottomNavigationBar: Container(
    color: HexColor(ThemP.getcolor()).withOpacity(0.8),
    height: 70,
    child: Row(
    children: <Widget>[
    GestureDetector(
    onTap: () {},
    child: GestureDetector(
    onTap: () {
    ShowItems();
    },
    child: Container(
    width: 66,
    color: HexColor(ThemP.getcolor()),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Icon(Icons.add, color: Colors.white),
    Text(LanguageProvider.Llanguage('Add'),
    style: TextStyle(color: Colors.white))
    ],
    ),
    ),
    ),
    ),
    SizedBox(
    width: 3,
    ),
    GestureDetector(
    onTap: () {
      saveinvoiceHDR(context);

    //SaveInvoice(cart);
    },
    child: Container(
    width: 90,
    color: HexColor(ThemP.getcolor()),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Icon(Icons.save_alt_sharp, color: Colors.white),
    Text(LanguageProvider.Llanguage('save'),
    style: TextStyle(color: Colors.white))
    ],
    ),
    ),
    ),

    Expanded(
    child: Container(
    alignment: Alignment.center,
    color: HexColor(ThemP.getcolor()).withOpacity(0.8),
    child: Row(
    children: [
    Spacer(),
    Spacer(),
    Text(
    total.toStringAsFixed(3),
    style: ArabicTextStyle(
    arabicFont: ArabicFont.tajawal,
    fontSize: 15 * unitHeightValue,
    color: Colors.white,
    fontWeight: FontWeight.w600),
    ),
    Text(
    ' : ',
    style: ArabicTextStyle(
    arabicFont: ArabicFont.tajawal,
    fontSize: 20 * unitHeightValue,
    color: Colors.white,
    fontWeight: FontWeight.w900),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
      LanguageProvider.Llanguage('Total'),
      style: ArabicTextStyle(
      arabicFont: ArabicFont.tajawal,
      fontSize: 15 * unitHeightValue,
      color: Colors.white,
      fontWeight: FontWeight.w500),
      ),
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height ,
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
                          Container(
                            height: MediaQuery.of(context).size.height/1.1,

                            child: ListView(
                              children: cart
                              !.map((itemsModel v) => SizedBox(
                                width: MediaQuery.of(context).size.width/3.6,
    child: Dismissible(
    direction: DismissDirection.horizontal,
    // Only allow horizontal swiping
    resizeDuration: Duration(milliseconds: 500),
    background: Container(
    color: Colors.red,
    alignment: Alignment.center,
    child: Icon(
    Icons.delete,
    color: Colors.white,
    size: 40 * unitHeightValue,
    ),
    ),
    secondaryBackground: Container(
    color: Colors.red,
    alignment: Alignment.center,
    child: Icon(
    Icons.delete,
    color: Colors.white,
    size: 40 * unitHeightValue,
    ),
    ),

    confirmDismiss: (DismissDirection
    dismissDirection) async {
    var bool = false;
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
    "deletetxt"),
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
    setState(() {
      var staticprice=double.parse(v.itemprice.toString());
      total-=staticprice;
    bool = true;
    Navigator.of(context)
        .pop();
    cart!.removeWhere(
    (item) =>
    item.id
        .toString() ==
    v.id.toString());
    });
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
    bool = false;
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

    return bool;
    },
    key: Key(v.id.toString()),
      child: Card(
        color: Colors.white,
        child: Row(
          children: [
            Container(
              child: SizedBox(
                width: MediaQuery.of(context).size.width/5,
                height: MediaQuery.of(context).size.width/5,
                child: Center(
                  child: Container(
                    child: Image.network(
                      v.itemimage.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width/3,
                  child: Center(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        textAlign: TextAlign.left,
                        v.itemname.toString(),
                        style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 18 * unitHeightValue, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/3.6,
                    child: Center(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          textAlign: TextAlign.right,
                          v.itemprice.toString() + "  JD",
                          style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 18 * unitHeightValue, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
            Text(
              textAlign: TextAlign.left,
              v.nowqt.toString(),
              style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 18 * unitHeightValue, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Container(
              child: Row(children: [

                GestureDetector(
                    onTap: () {
                      //_showToast(context,"غير متوفر هذا المنتج في المخزون");
                      if(int.parse(v.nowqt.toString())>int.parse(v.qt.toString() ) || v.enableqt.toString()=='0') {
                        var staticprice = double.parse(v.itemprice.toString()) /
                            v.qt;

                        for (int i = 0; i < cart!.length; i++) {
                          if (cart![i].id == v.id.toString()) {
                            cart![i].qt = cart![i].qt + 1;
                            cart![i].itemprice =
                                (double.parse(cart![i].itemprice.toString()) +
                                    staticprice).toString();


                            total += double.parse(staticprice.toString());
                          }
                        }

                        setState(() {
                        });
                      }else{
                        _showToast(context,"غير متوفر هذا المنتج في المخزون");

                      }
                    },
                    child: Icon(Icons.add_circle,size: 28,color: Colors.green,)),
                SizedBox(width: 10,),
                Text(
                  textAlign: TextAlign.right,
                  v.qt.toString(),
                  style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black
                      , fontSize: 18 * unitHeightValue, fontWeight: FontWeight.w900),
                ),
                SizedBox(width: 10,),
                GestureDetector(
                    onTap: () {
                      var staticprice=double.parse(v.itemprice.toString())/v.qt;

                      for(int i=0;i<cart!.length;i++){
                        if(cart![i].id==v.id.toString()){
                          if(cart![i].qt>1)
                            cart![i].qt   =   cart![i].qt-1;
                          cart![i].itemprice=(double.parse(cart![i].itemprice.toString())- staticprice).toString();
                          total-=double.parse(staticprice.toString());

                        }
                      }
                      setState(() {

                      });

                    },

                    child: Container(
                      width: 25 * unitHeightValue,
                      height: 25 * unitHeightValue,
                      child: SvgPicture.asset(
                        "assets/min.svg",
                        color:  Colors.redAccent,
                        height: 25 * unitHeightValue,
                        width: 25 * unitHeightValue,
                      ),
                    )),

                /*     GestureDetector(
                                              onTap: () {



                                                var staticprice=double.parse(v.itemprice.toString());

                                                cart!.removeWhere((element) => element.id==v.id);


                                                total-=staticprice;



                                                setState(() {

                                                });

                                              },
                                              child: Icon(Icons.delete,size: 35,color: Colors.redAccent,)),*/


              ],),
            ),
            Spacer(),

          ],
        ),
      ),

    ),
                              ))
                                  .toList(),
                            ),
                          ),

                          Row(
                            children: [
                              Spacer(),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "  JD  " + total.toString()  ,
                                  style: ArabicTextStyle(arabicFont: ArabicFont.tajawal,
                                      color: Colors.black, fontSize: 30 * unitHeightValue, fontWeight: FontWeight.w900),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  ' : المجموع',
                                  style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black,
                                      fontSize: 26 * unitHeightValue, fontWeight: FontWeight.w900),
                                ),
                              ),
                              SizedBox(width: 5,)
                            ],
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 60,
                              width: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.width/6:


                              MediaQuery.of(context).size.width / 1.2,
                              margin: EdgeInsets.only(top: 30, bottom: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                  HexColor(ThemP.getcolor()),
                                ),
                                child: Text(
                                  'حفظ',
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      color:
                                      HexColor(Globalvireables.white),
                                      fontSize: 20 * unitHeightValue
                                      , fontWeight: FontWeight.w700),
                                ),
                                onPressed: () async {








                                },
                              ),
                            ),
                          )

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

  Future<String?> addClasses(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    TextEditingController searchusercontroller = TextEditingController();
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);

    var itemVar='';

    TextEditingController itemanem = TextEditingController();
    TextEditingController itemorice = TextEditingController();
    TextEditingController iteminitprice = TextEditingController();
    TextEditingController classidc = TextEditingController();


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
                                  color: HexColor(Globalvireables.base3),

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    // if you need this
                                    side: BorderSide(
                                      width: MediaQuery.of(context)
                                          .size
                                          .height,
                                      //  color: HexColor(Colors.white)12.withOpacity(0.1),
                                    ),
                                  ),
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
      Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/additems.php');

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
    Uri postsURL = Uri.parse('https://poscoffeesystem.000webhostapp.com/getClassess.php');
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

  deleteItem(BuildContext context, String coffeeid) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(l.Llanguage('deleteclass')),
          content: Text(l.getLanguage() == "AR"
              ? 'جار حذف الماده ...'
              : 'delete item ..'),
        ));

    var map = new Map<String, dynamic>();
    map['itemid'] = coffeeid;

    print(map.toString() + " inputt");
    try {

      Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/deleteitem.php');
      http.Response response = await http
          .post(
        apiUrl,
        body: map,)
          .whenComplete(() => Navigator.pop(context));

      print("response.toString()"+response.body.toString());

      if (response.body.toString().contains('1S')) {
        Navigator.pop(context);
        setState(() {

        });
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(l.Llanguage('deleteitem')),
              content: Text(l.getLanguage() == "AR"
                  ? 'تم حذف الماده بنجاح'
                  : 'delete item is done..'),
            ));
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(l.Llanguage('deleteitem')),
              content: Text(l.Llanguage('anerror')),
            ));
      }
    } catch (e) {
      Navigator.pop(context);

      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(l.Llanguage('deleteitem')),
          content: Text(l.Llanguage('anerror')+e.toString()),
          actions: <Widget>[],
        ),
      );
    }
  }


  Future<List<itemsModel>> getAllitems(
      BuildContext c, String coffeeid) async {
    var billprovider = Provider.of<BillProvider>(context, listen: false);

    Uri postsURL = Uri.parse('https://poscoffeesystem.000webhostapp.com/getitems.php');
    try {
      var map = new Map<String, dynamic>();
      map['coffeid'] = coffeeid;
      map['classid'] = billprovider.getclassid().toString();

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


        inititem=Doctors;

        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";
      }
    } catch (e) {
    }

    throw "Unable to retrieve Profile.";
  }


  saveinvoiceDTL(BuildContext context, String json) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();




    var map = new Map<String, dynamic>();
    map['json'] = json;

    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/addinvoicedtl.php');

      http.Response response = await http
          .post(
        apiUrl,
        body: map,
      )
          .whenComplete(() => Navigator.pop(context));


print("OUT   "+response.body.toString());
      if (response.body.toString().contains('1S')) {

        cart?.clear();
        total=0.0;

  setState(() {

  });
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
  saveinvoiceHDR(BuildContext context) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(l.Llanguage('addclasses')),
          content: Text(l.getLanguage() == "AR"
              ? 'حفظ الفاتوره ...'
              : 'Add invoice..'),
        ));

    var map = new Map<String, dynamic>();
    map['discount'] = '0.0';
    map['invdate'] = now.toString();

    map['paytype'] = '1';
    map['totalcost'] = '0.0';


    map['total'] = total.toString();
    map['coffeid'] = Loginprovider.getcoffeeId().toString();
    map['userid'] = Loginprovider.getid().toString();
    map['invid'] = Loginprovider.getmaxinv().toString();


    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/addinvoicehdr.php');

      http.Response response = await http
          .post(
        apiUrl,
        body: map,
      )
          .whenComplete(() => Navigator.pop(context));



      if (response.body.toString().contains('1S')) {


        for(int i=0;i<cart!.length;i++){

          cart![i].nowqt=(int.parse(cart![i].nowqt.toString())-int.parse(cart![i].qt.toString())).toString();
        }

        String jsonstringmap = jsonEncode(cart);
        print("jsson    "+jsonstringmap);
        saveinvoiceDTL(context,jsonstringmap);

        setState(() {

        });
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

  getMaxId(BuildContext context) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);


    print("MAXXX :" +Loginprovider.getmaxinv().toString());


    try {
      Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/getmaxinvid.php');

      http.Response response = await http
          .post(
        apiUrl,
        body: null,
      );

      List<dynamic> body = jsonDecode(response.body);


      //print("MAXXXin :" +body.toString());


    /*  List<maxmodel> max = body
          .map(
          (dynamic item) => maxmodel.fromJson(item),)
          .toList();

*/


      if(body[0]['maxinv'].toString()!=Loginprovider.getmaxinv().toString()){
        setState(() {

        });

      }


    Loginprovider.setmaxinv(body[0]['maxinv'].toString() + Loginprovider.getcoffeeId().toString()+Loginprovider.getid().toString());



    } catch (e) {


    }
  }


  ShowItems() {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var billprovider = Provider.of<BillProvider>(context, listen: false);

    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;

    showModalBottomSheet(
       // backgroundColor: HexColor(ThemP.getcolor()),
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
    top: Radius.circular(5),
    ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (context) {
    return FractionallySizedBox(
    heightFactor: 0.9,
    child: Padding(
    padding: const EdgeInsets.all(15.0),
    child: Directionality(
    textDirection: LanguageProvider.getDirectionPres(),
    child: Container(
   // color: HexColor(ThemP.getcolor()),
    child: SingleChildScrollView(
    child: Column(children: [

      SizedBox(
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
                  dateinputC.clear();
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
      SizedBox(height: 3,),
    /*  SizedBox(
        height: 100,
        child:
        FutureBuilder(
          future:
          getallclassess(
              context,Loginprovider.coffeeId.toString()),
          builder: (BuildContext
          context,
              AsyncSnapshot<
                  List<
                      classessModel>>
              snapshot) {
            if (snapshot.hasData) {
              List<classessModel>?
              search =
                  snapshot
                      .data;




              return ListView(
                scrollDirection: Axis.horizontal,
                children: search!
                    .map((classessModel v) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {

                        billprovider.setclassid(v.id.toString());
                        setState(() {

                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Card(
                          color: Color((math.Random().nextDouble() * 0xffffffff).toInt()).withOpacity(0.10),

                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              child: Center(
                                child: Container(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    v.classname.toString(),
                                    style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 16 * unitHeightValue, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
      ),*/
      SizedBox(height: 3,),

      SizedBox(
        height: MediaQuery.of(context).size.height / 1.345,
        width: MediaQuery.of(context).size.width / 1,
        child: FutureBuilder(
          future: getAllitems(
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

              return GridView(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:  Globalvireables.getDeviceType()=='tablet'?6: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: Globalvireables.getDeviceType()=='tablet'?200:300,
                ),
                children: search!
                    .map((itemsModel v) =>      GestureDetector(
                  onTap: () {
                    if(int.parse(v.nowqt.toString())>0  ||v.enableqt.toString()=='0') {
                      var exiet = 0;


                      for (int i = 0; i < cart!.length; i++) {
                        var staticprice = double.parse(
                            cart![i].itemprice.toString()) / cart![i].qt;

                        if (cart![i].id == v.id.toString()) {
                          cart![i].qt = cart![i].qt + 1;
                          cart![i].itemprice =
                              (double.parse(cart![i].itemprice.toString()) +
                                  staticprice).toString();
                          total += double.parse(staticprice.toString());

                          exiet = 1;
                        }
                      }
                      if (exiet == 0) {
                        cart!.add(itemsModel(id:
                        v.id.toString(),
                            itemname: v.itemname.toString(),
                            itemimage: v.itemimage.toString()
                            ,
                            coffeid: v.coffeid.toString(),
                            itemprice: v.itemprice.toString(),
                            iteminitprice: v.iteminitprice.toString(),
                            classid: v.classid.toString(),
                            qt: 1
                            ,
                            invid: Loginprovider.getmaxinv(),
                            nowqt: v.nowqt.toString(),
                            userid: int.parse(Loginprovider.getid())));
                        setState(() {

                        });
                        total += double.parse(v.itemprice.toString());
                      }

                      setState(() {

                      });
                      Navigator.pop(context);
                    }
                    else{
                      Navigator.pop(context);
                      _showToast(context,"غير متوفر هذا المنتج في المخزون");

                    }
                  },


                  child: Card(
                    child: Padding(
                      padding:
                      const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Spacer(),
                          SizedBox(
                            width: Globalvireables.getDeviceType()=='tablet'?100:100,
                            height: Globalvireables.getDeviceType()=='tablet'?100:100,

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

    ]))))));});}


  void _showToast(BuildContext context,String txt) {
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }


}