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

import '../Model/ImageModel.dart';
import '../Model/classessModel.dart';
import '../Model/itemsModel.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

class items extends StatefulWidget {
  @override
  State<items> createState() => _NotificationsState();
}

class _NotificationsState extends State<items> {
  @override
  void initState() {
    super.initState();
  }

  bool qtactive = true;
  TextEditingController dateinputC = TextEditingController();
  TextEditingController _ClassDescFieldController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  var PATH='';

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
                LanguageProvider.Llanguage('additems'),
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: SizedBox(
                              width: Globalvireables.getDeviceType() == 'tablet'
                                  ? MediaQuery.of(context).size.width / 1.2
                                  : MediaQuery.of(context).size.width,
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
                                                      LanguageProvider
                                                          .Llanguage('Search')
                                              ? null
                                              : Icons.cancel)),
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
                                  hintText:
                                      LanguageProvider.Llanguage("Search"),
                                ),
                                //a  readOnly: true,  //set it true, so that user will not able to edit text
                                onTap: () async {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
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

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    child:Visits.length>0? GridView(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            Globalvireables.getDeviceType() ==
                                                    'tablet'
                                                ? 6
                                                : 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        mainAxisExtent: 230,
                                      ),
                                      children: search!
                                          .map(
                                              (itemsModel v) => GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Expanded(
                                                            child: AlertDialog(
                                                              title: Center(
                                                                  child: Text(
                                                                      (v.enableqt.toString() ==
                                                                              '1'
                                                                          ? 'المخزون مفعل هل تريد ايقافه '
                                                                          : 'المخزون غير مفعل هل تريد تفعيله'),
                                                                      style: ArabicTextStyle(
                                                                          arabicFont: ArabicFont
                                                                              .tajawal,
                                                                          fontSize:
                                                                              18 * unitHeightValue))),
                                                              actions: [
                                                                TextButton(
                                                                  //  textColor: Colors.black,
                                                                  onPressed:
                                                                      () {
                                                                    ChangeItemState(
                                                                        context,
                                                                        v.enableqt.toString() ==
                                                                                '1'
                                                                            ? 'disable'
                                                                            : 'enable',
                                                                        v.id.toString());

                                                                    // AddQT(context,v.id.toString(),int.parse(v.nowqt.toString())+int.parse(addedQTController.text.toString()));
                                                                  },
                                                                  child: Text(
                                                                    v.enableqt.toString() ==
                                                                            '1'
                                                                        ? 'ايقاف المخزون'
                                                                        : 'تفعيل المخزون',
                                                                    style: ArabicTextStyle(
                                                                        arabicFont:
                                                                            ArabicFont
                                                                                .tajawal,
                                                                        color: Colors
                                                                            .redAccent,
                                                                        fontSize:
                                                                            15 *
                                                                                unitHeightValue),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  // textColor: Colors.black,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    LanguageProvider
                                                                        .Llanguage(
                                                                            'cancel'),
                                                                    style: ArabicTextStyle(
                                                                        arabicFont:
                                                                            ArabicFont
                                                                                .tajawal,
                                                                        color: Colors
                                                                            .black87,
                                                                        fontSize:
                                                                            15 *
                                                                                unitHeightValue),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Expanded(
                                                                      child:
                                                                          AlertDialog(
                                                                        title: Text(
                                                                            LanguageProvider.Llanguage(
                                                                                'delete'),
                                                                            style:
                                                                                ArabicTextStyle(arabicFont: ArabicFont.tajawal, fontSize: 22 * unitHeightValue)),
                                                                        content:
                                                                            Text(
                                                                          LanguageProvider.Llanguage(
                                                                              "txxtitem"),
                                                                          style: ArabicTextStyle(
                                                                              arabicFont: ArabicFont.tajawal,
                                                                              fontSize: 14 * unitHeightValue),
                                                                        ),
                                                                        actions: [
                                                                          TextButton(
                                                                            //  textColor: Colors.black,
                                                                            onPressed:
                                                                                () {
                                                                              deleteItem(context, v.id.toString());
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              LanguageProvider.Llanguage('delete'),
                                                                              style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.redAccent, fontSize: 15 * unitHeightValue),
                                                                            ),
                                                                          ),
                                                                          TextButton(
                                                                            // textColor: Colors.black,
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              LanguageProvider.Llanguage('cancel'),
                                                                              style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black87, fontSize: 15 * unitHeightValue),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete,
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
                                                                  image: new NetworkImage(v
                                                                      .itemimage
                                                                      .toString())),
                                                            ),
                                                            Spacer(),
                                                            SizedBox(
                                                              child: Container(
                                                                width: 100,
                                                                child: Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  v.itemname
                                                                          .toString() +
                                                                      "",
                                                                  style: ArabicTextStyle(
                                                                      arabicFont:
                                                                          ArabicFont
                                                                              .tajawal,
                                                                      color: Colors
                                                                          .black,
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
                                    ):Column(
                                  children: [
                                  Container(
                                  child: SvgPicture.asset(
                                    "assets/nodata.svg",
                                  ),
                                ),

                                Text(
                                "عرف المواد الخاصة بك الآن"   ,
                                style: ArabicTextStyle(arabicFont: ArabicFont.tajawal,
                                color: Colors.black, fontSize: 18 * unitHeightValue, fontWeight: FontWeight.w700),
                                ),

                                ],
                                )
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
                                        "عرف المواد الخاصة بك الآن"   ,
                                        style: ArabicTextStyle(arabicFont: ArabicFont.tajawal,
                                            color: Colors.black, fontSize: 18 * unitHeightValue, fontWeight: FontWeight.w700),
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

  Future<List<itemsModel>> getAllitems(BuildContext c, String coffeeid) async {
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
        throw "Unable to retrieve Profile.";
      }
    } catch (e) {}

    throw "Unable to retrieve Profile.";
  }

  Future<List<ImageModel>> GetImages(BuildContext c) async {
    Uri postsURL = Uri.parse('https://coffepoint.net/Api/getimage.php');
    try {
      var map = new Map<String, dynamic>();
      map['type'] = '1';

      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        print("Profile" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<ImageModel> Doctors = body
            .map(
              (dynamic item) => ImageModel.fromJson(item),
            )
            .toList();

        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";
      }
    } catch (e) {}

    throw "Unable to retrieve Profile.";
  }

  Future<String?> addClasses(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    TextEditingController searchusercontroller = TextEditingController();
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    var itemVar = '';
    var ThemP = Provider.of<Them>(context, listen: false);

    TextEditingController itemanem = TextEditingController();
    TextEditingController itemorice = TextEditingController();
    TextEditingController iteminitprice = TextEditingController();
    TextEditingController classidc = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
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
                    SizedBox(
                      height: 25,
                    ),
                    Text('سعر بيع الماده'),
                    TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      controller: itemorice,
                      decoration: InputDecoration(hintText: ""),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text('سعر تكلفه الماده'),
                    TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      controller: iteminitprice,
                      decoration: InputDecoration(hintText: ""),
                    ),
                    SizedBox(
                      height: 25,
                    ),
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
                            hintText:
                                LanguageProvider.Llanguage('usersController'),
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
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.4,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.3,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                child: Text(
                                                    LanguageProvider.Llanguage(
                                                        'usersController'),
                                                    style: ArabicTextStyle(
                                                        arabicFont:
                                                            ArabicFont.tajawal,
                                                        color: HexColor(
                                                            Globalvireables
                                                                .black2),
                                                        fontSize: 18 *
                                                            unitHeightValue,
                                                        fontWeight:
                                                            FontWeight.w700)),
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
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.search,
                                                    color: HexColor(
                                                        ThemP.getcolor()),
                                                    size: 27 * unitHeightValue,
                                                  ),
                                                  suffixIcon: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          searchusercontroller
                                                              .text = '';
                                                        });
                                                      },
                                                      child: Icon(null)),
                                                  border: OutlineInputBorder(),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: HexColor(
                                                              ThemP.getcolor()),
                                                          width: 2.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: HexColor(
                                                              ThemP.getcolor()),
                                                          width: 2.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 18,
                                                          bottom: 18,
                                                          right: 20,
                                                          left: 20),
                                                  fillColor: HexColor(
                                                      Globalvireables.white),
                                                  filled: true,
                                                  hintText: LanguageProvider
                                                      .Llanguage("Search"),
                                                ),
                                                //a  readOnly: true,  //set it true, so that user will not able to edit text
                                                onTap: () async {
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2.8,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1,
                                              child: FutureBuilder(
                                                future: getallclassess(
                                                    context,
                                                    Loginprovider.coffeeId
                                                        .toString()),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            List<classessModel>>
                                                        snapshot) {
                                                  if (snapshot.hasData) {
                                                    List<classessModel>?
                                                        Visits = snapshot.data;

                                                    List<classessModel>? search = Visits!
                                                        .where((element) => element
                                                            .classname
                                                            .toString()
                                                            .contains(
                                                                searchusercontroller
                                                                    .text
                                                                    .toString()))
                                                        .toList();

                                                    return  ListView(
                                                      children: search!
                                                          .map(
                                                              (classessModel
                                                                      v) =>
                                                                  Column(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          classidc.text = v
                                                                              .classname
                                                                              .toString();
                                                                          itemVar = v
                                                                              .id
                                                                              .toString();
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child: SizedBox(
                                                                              child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width / 3,
                                                                                  child: Text(
                                                                                    v.classname.toString(),
                                                                                    style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 16 * unitHeightValue, fontWeight: FontWeight.w400),
                                                                                  ),
                                                                                ),
                                                                                Spacer(),
                                                                                Container(
                                                                                  width: 30,
                                                                                  height: 50,
                                                                                  child: Image.network(
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
                                                    ) ;
                                                  } else {
                                                    return Column(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width/3,
                                                          height: MediaQuery.of(context).size.width/3,
                                                          child: SvgPicture.asset(
                                                            "assets/nodata.svg",
                                                          ),
                                                        ),

                                                        Text(
                                                          "يجب تعريف الاصناف الخاصة بك اولا"   ,
                                                          style: ArabicTextStyle(arabicFont: ArabicFont.tajawal,
                                                              color: Colors.black, fontSize: 12 * unitHeightValue, fontWeight: FontWeight.w400),
                                                        ),

                                                      ],
                                                    );;
                                                  }
                                                },
                                              ),
                                            ),
                                            Spacer(),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: HexColor(
                                                        ThemP.getcolor()),
                                                  ),
                                                  child: Text(
                                                    LanguageProvider.Llanguage(
                                                        'cancel'),
                                                    style: ArabicTextStyle(
                                                        arabicFont:
                                                            ArabicFont.tajawal,
                                                        color: HexColor(
                                                            Globalvireables
                                                                .white),
                                                        fontSize: 14 *
                                                            unitHeightValue),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 1,
                        child: FutureBuilder(
                          future: GetImages(context),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ImageModel>> snapshot) {
                            if (snapshot.hasData) {
                              List<ImageModel>? Visits = snapshot.data;

                              List<ImageModel>? search = Visits!
                                  .where((element) => element.type
                                      .toString()
                                      .contains(dateinputC.text.toString()))
                                  .toList();

                              return ListView(
                                scrollDirection: Axis.horizontal,
                                children: search
                                    .map((ImageModel v) => Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child:  GestureDetector(
                                            onTap: () {

                                              setState(() {
                                                PATH=v.path.toString();
                                              });

                                            },
                                            child: PATH==v.path.toString()?Container(
                                                width: 80,
                                                height: 80,
                                                color: Colors.black12,
                                                child: Image.network(
                                                    v.path.toString(),
                                                  opacity: const AlwaysStoppedAnimation(.5),)

                                            )
                                                :Container(
                                                width: 80,
                                                height: 80,
                                                child: Image.network(
                                                    v.path.toString())),
                                          ),
                                        ))
                                    .toList(),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: qtactive,
                            //set variable for value
                            onChanged: (bool? value) async {
                              // if(!checkusers)

                              setState(() {
                                qtactive = !qtactive;
                              });
                            }),
                        Text('البيع من خلال المخزون',
                            style: ArabicTextStyle(
                                arabicFont: ArabicFont.tajawal,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Globalvireables.getDeviceType() == 'tablet'
                                        ? 17 * unitHeightValue
                                        : 12 * unitHeightValue)),
                      ],
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
                    context,
                    itemanem.text.toString(),
                    itemorice.text.toString(),
                    iteminitprice.text.toString(),
                    itemVar.toString(),
                    PATH
                  ),
                ),
              ],
            );
          });
        });
  }

  SaveClass(BuildContext context, String itemname, String itemprice,
      String iteminitprice, String classid, String path) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(l.Llanguage('additems')),
              content: Text(
                  l.getLanguage() == "AR" ? 'اضافه المواد ...' : 'Add Item..'),
            ));

    var map = new Map<String, dynamic>();
    map['itemname'] = itemname.toString();
    map['itemprice'] = itemprice.toString();
    map['classid'] = classid.toString();
    map['iteminitprice'] = iteminitprice.toString();

    map['coffeid'] = Loginprovider.getcoffeeId();
    map['path'] = path;

    map['enableqt'] = qtactive ? '1' : '0';

    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://coffepoint.net/Api/additems.php');

      http.Response response = await http
          .post(
            apiUrl,
            body: map,
          )
          .whenComplete(() => Navigator.pop(context));

      if (response.body.toString().contains('1S')) {
        Navigator.pop(context);
        setState(() {});
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
    } catch (e) {}

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
      Uri apiUrl = Uri.parse('https://coffepoint.net/Api/deleteitem.php');
      http.Response response = await http
          .post(
            apiUrl,
            body: map,
          )
          .whenComplete(() => Navigator.pop(context));

      print("response.toString()" + response.body.toString());

      if (response.body.toString().contains('1S')) {
        Navigator.pop(context);
        setState(() {});
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
          content: Text(l.Llanguage('anerror') + e.toString()),
          actions: <Widget>[],
        ),
      );
    }
  }

  ChangeItemState(BuildContext context, String type, String itemid) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(l.Llanguage('deleteclass')),
              content: Text(l.getLanguage() == "AR" ? ' ...' : ' ..'),
            ));

    var map = new Map<String, dynamic>();
    map['itemid'] = itemid;
    map['qt'] = '0';
    map['type'] = type;

    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://coffepoint.net/Api/addqtitem.php');
      http.Response response = await http
          .post(
            apiUrl,
            body: map,
          )
          .whenComplete(() => Navigator.pop(context));

      print("response.toString()" + response.body.toString());

      if (response.body.toString().contains('1S')) {
        Navigator.pop(context);
        setState(() {});
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('المخزون'),
                  content: Text(l.getLanguage() == "AR"
                      ? 'تم تنفيذ طلبك بنجاح'
                      : 'delete item is done..'),
                ));
        setState(() {});
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(l.Llanguage('anerrortitle')),
                  content: Text(l.Llanguage('anerror')),
                ));
      }
    } catch (e) {
      Navigator.pop(context);

      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(l.Llanguage('anerrortitle')),
          content: Text(l.Llanguage('anerror') + e.toString()),
          actions: <Widget>[],
        ),
      );
    }
  }
}
