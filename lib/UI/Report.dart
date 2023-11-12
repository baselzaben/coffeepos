import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:coffeepos/provider/LoginProvider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Model/EmplyeeModel.dart';
import '../Model/HourReportModel.dart';
import '../Model/SumSaleModel.dart';
import '../Model/classessModel.dart';
import '../Model/itemsModel.dart';
import '../Model/userRmodel.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

import 'Widgets/BarChartWidget.dart';

class Report extends StatefulWidget {
  @override
  State<Report> createState() => _NotificationsState();
}


class _NotificationsState extends State<Report> {
  @override
  void initState() {

  //  GetUserR(context);

    super.initState();
  }
  List<Map<String, dynamic>> chartData = [

  ];




  TextEditingController dateinputC = TextEditingController();
  TextEditingController _ClassDescFieldController = TextEditingController();
  TextEditingController addedQTController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }
  List<EmplyeeModel> dataPoints = [
  ];

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
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                'تقارير العمل',
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
                  padding: EdgeInsets.only(left: 18, right: 18),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          SizedBox(
                            child: TextField(
                              controller: dateinputC, //editing controller of this TextField
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.date_range,color: HexColor(
                                    ThemP.getcolor()),size: 27*unitHeightValue,),
                                suffixIcon: GestureDetector(
                                    onTap: (){
                                      dateinputC.text='all';

                                      setState(() {
                                      });
                                    },
                                    child: Icon(color: Colors.redAccent,dateinputC.text.isEmpty||dateinputC.text.toString()==LanguageProvider.Llanguage('SearchbyDate')
                                        ? null
                                        : Icons.cancel)),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(
                                            ThemP.getcolor()),
                                        width: 2.0),
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(
                                            ThemP.getcolor()),
                                        width: 2.0),
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
                                hintText: LanguageProvider.Llanguage(
                                    "SearchbyDate"),
                              ),
                              readOnly: true,  //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context, initialDate: DateTime.now(),
                                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101)
                                );

                                if(pickedDate != null ){
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  print(formattedDate +"formattedDate");
                                  setState(() {
                                    dateinputC.text = formattedDate.toString(); //set output date to TextField value.

                                  });
                                }else{
                                  print("Date is not selected");
                                }
                              },
                            ),
                          )
                          ,

                         Row(
                            children: [
                              Spacer()
,
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                                child: Text(" : مجموع مبيعات الموظفين ",
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                              ),
                            ],
                          ),


Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.black),
    color: Colors.black12,

  ),
  child: Column(
    children: [
      Container(decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.transparent,

      ),
        child: Row(children: [
          Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              color: Colors.transparent,

            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("مجموع المبيعات ",
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 18),),
            ),
          ),
          Spacer(),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              color: Colors.transparent,

            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("اسم الموظف",
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 18),),
            ),
          ),
          Spacer(),



        ],),
      ),

      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width/2,
        child: FutureBuilder(
          future: GetUserR(context),
          builder: (BuildContext
          context, AsyncSnapshot<
              List<userRmodel>>
          snapshot) {
            if (snapshot.hasData) {
              List<userRmodel>?
              Visits = snapshot.data;

              List<userRmodel>? search = Visits!
                  .where((element) => element
                  .name
                  .toString()
                  .contains(
                  dateinputC
                      .text
                      .toString() ) )
                  .toList();

              return ListView(
                children: search
                    .map((userRmodel v) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.transparent,

                  ),
                      child: Row(children: [
                            Spacer(),
                            Container(
                              width: MediaQuery.of(context).size.width/3,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                color: Colors.transparent,

                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(v.total_sales.toString(),
                                  textAlign: TextAlign.center,

                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18),),
                              ),
                            ),
                            Spacer(),
                            Spacer(),
                            Container(
                              width: MediaQuery.of(context).size.width/3,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                color: Colors.transparent,

                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(v.name.toString(),
                                  textAlign: TextAlign.center,

                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18),),
                              ),
                            ),
                            Spacer(),



                          ],),
                    )
                )
                    .toList(),
              );
            } else {
              return Center(
                  child:
                  CircularProgressIndicator());
            }
          },
        ),
      )
      
      
    ],
  ),
)
,

                       //////////////////////////////////////
                          SizedBox(width: 40,),


                          Row(
                            children: [
                              Spacer()
                              ,
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                                child: Text(" : مجموع المبيعات حسب المواد ",
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                              ),
                            ],
                          ),


                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.black12,

                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.transparent,

                                  ),
                                  child: Row(children: [
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.transparent),
                                        color: Colors.transparent,

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("مجموع المبيعات",
                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 18),),
                                      ),
                                    ),
                                    Spacer(),
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.transparent),
                                        color: Colors.transparent,

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(" اسم الماده",
                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 18),),
                                      ),
                                    ),
                                    Spacer(),



                                  ],),
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width/1.4,
                                  child: FutureBuilder(
                                    future: GetitemsR(context),
                                    builder: (BuildContext
                                    context, AsyncSnapshot<
                                        List<userRmodel>>
                                    snapshot) {
                                      if (snapshot.hasData) {
                                        List<userRmodel>?
                                        Visits = snapshot.data;

                                        List<userRmodel>? search = Visits!
                                            .where((element) => element
                                            .name
                                            .toString()
                                            .contains(
                                            dateinputC
                                                .text
                                                .toString() ) )
                                            .toList();

                                        return ListView(
                                          children: Visits
                                              .map((userRmodel v) => Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black),
                                              color: Colors.transparent,

                                            ),
                                                child: Row(children: [
                                                                                            Spacer(),
                                                                                            Container(
                                                width: MediaQuery.of(context).size.width/3,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.transparent),
                                                  color: Colors.transparent,

                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(v.total_sales.toString(),
                                                    textAlign: TextAlign.center,

                                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18),),
                                                ),
                                                                                            ),
                                                                                            Spacer(),
                                                                                            Spacer(),
                                                                                            Container(
                                                width: MediaQuery.of(context).size.width/3,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.transparent),
                                                  color: Colors.transparent,

                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(v.name.toString(),
                                                    textAlign: TextAlign.center,

                                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18),),
                                                ),
                                                                                            ),
                                                                                            Spacer(),



                                                                                          ],),
                                              )
                                          )
                                              .toList(),
                                        );
                                      } else {
                                        return Center(
                                            child:
                                            CircularProgressIndicator());
                                      }
                                    },
                                  ),
                                )


                              ],
                            ),
                          )

////////////////////////////////////////
,
                          SizedBox(width: 40,),


                          Row(
                            children: [
                              Spacer()
                              ,
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                                child: Text(" : مجموع المبيعات حسب المواد ",
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                              ),
                            ],
                          ),


                          Container(
                            margin: EdgeInsets.only(bottom: 100),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.black12,

                            ),
                            child: Column(
                              children: [
                                Container(decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.transparent,

                                ),
                                  child: Row(children: [
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.transparent),
                                        color: Colors.transparent,

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("الساعه",
                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 18),),
                                      ),
                                    ),
                                    Spacer(),
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.transparent),
                                        color: Colors.transparent,

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("متوسط البيع",
                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 18),),
                                      ),
                                    ),
                                    Spacer(),



                                  ],),
                                ),

                               Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height/1.2,
                                    child: FutureBuilder(
                                      future: GetitemsSaleHour(context),
                                      builder: (BuildContext
                                      context, AsyncSnapshot<
                                          List<HourReportModel>>
                                      snapshot) {
                                        if (snapshot.hasData) {
                                          List<HourReportModel>?
                                          Visits = snapshot.data;

                                          List<HourReportModel>? search = Visits!
                                              .where((element) => element
                                              .hour
                                              .toString()
                                              .contains(
                                              dateinputC
                                                  .text
                                                  .toString() ) )
                                              .toList();

                                          return ListView(
                                            children: search
                                                .map((HourReportModel v) => Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black),
                                                color: Colors.transparent,

                                              ),
                                                  child: Row(children: [
                                                                                                Spacer(),
                                                                                                Container(
                                                  width: MediaQuery.of(context).size.width/3,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.transparent),
                                                    color: Colors.transparent,

                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(getHourname(v.hour.toString()),
                                                      textAlign: TextAlign.center,

                                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18),),
                                                  ),
                                                                                                ),
                                                                                                Spacer(),
                                                                                                Spacer(),
                                                                                                Container(
                                                  width: MediaQuery.of(context).size.width/3,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.transparent),
                                                    color: Colors.transparent,

                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(v.count.toString(),
                                                      textAlign: TextAlign.center,

                                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18),),
                                                  ),
                                                                                                ),
                                                                                                Spacer(),



                                                                                              ],),
                                                )
                                            )
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


                              ],
                            ),
                          )
,

                        //////////////////////////



                          SizedBox(width: 40,),


                          Row(
                            children: [
                              Spacer()
                              ,
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                                child: Text(" : مجموع المبيعات حسب الاشهر ",
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                              ),
                            ],
                          ),


                          Container(
                            margin: EdgeInsets.only(bottom: 100),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.black12,

                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.transparent,

                                  ),
                                  child: Row(children: [
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.transparent),
                                        color: Colors.transparent,

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("الشهر",
                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 18),),
                                      ),
                                    ),
                                    Spacer(),
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.transparent),
                                        color: Colors.transparent,

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("متوسط البيع",
                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 18),),
                                      ),
                                    ),
                                    Spacer(),



                                  ],),
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height/1.2,
                                  child: FutureBuilder(
                                    future: GetitemsSaleMonth(context),
                                    builder: (BuildContext
                                    context, AsyncSnapshot<
                                        List<HourReportModel>>
                                    snapshot) {
                                      if (snapshot.hasData) {
                                        List<HourReportModel>?
                                        Visits = snapshot.data;

                                        List<HourReportModel>? search = Visits!
                                            .where((element) => element
                                            .hour
                                            .toString()
                                            .contains(
                                            dateinputC
                                                .text
                                                .toString() ) )
                                            .toList();

                                        return ListView(
                                          children: Visits
                                              .map((HourReportModel v) => Container(decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            color: Colors.transparent,

                                          ),
                                                child: Row(children: [
                                                                                            Spacer(),
                                                                                            Container(
                                                width: MediaQuery.of(context).size.width/3,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.transparent),
                                                  color: Colors.transparent,

                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(numberToArabicMonth(v.hour.toString()),
                                                    textAlign: TextAlign.center,

                                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18),),
                                                ),
                                                                                            ),
                                                                                            Spacer(),
                                                                                            Spacer(),
                                                                                            Container(
                                                width: MediaQuery.of(context).size.width/3,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.transparent),
                                                  color: Colors.transparent,

                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(v.count.toString(),
                                                    textAlign: TextAlign.center,

                                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18),),
                                                ),
                                                                                            ),
                                                                                            Spacer(),



                                                                                          ],),
                                              )
                                          )
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


                              ],
                            ),
                          )
                          ,

                          SizedBox(width: 100,),





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



  Future<List<userRmodel>> GetUserR(BuildContext c) async {
    Uri postsURL = Uri.parse('https://poscoffeesystem.000webhostapp.com/itemssalesreport.php');
    try {
      var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
      DateTime now = DateTime.now();

      var map = new Map<String, dynamic>();
      map['coffeid'] = Loginprovider.getcoffeeId();
      map['type'] = 'userR';

      http.Response res = await http.post(
        postsURL,
        body: map,
      );
//

      if (res.statusCode == 200) {

        print("ddddatttterrrrregeg : "+res.body.toString());
        List<dynamic> body = jsonDecode(res.body);



        List<userRmodel> Doctors = body
            .map((dynamic item) => userRmodel.fromJson(item),
        )
            .toList();

       // print("ProfileDAY" + Doctors.first.username.toString());
        //print("ProfileHOUR" + Doctors.first.totalSales_thidhour.toString());


        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";

      }
    } catch (e) {
      print("ERROR : "+e.toString());
      throw "Unable to retrieve Profile." + e.toString();
    }

  }


  Future<List<userRmodel>> GetitemsR(BuildContext c) async {
    Uri postsURL = Uri.parse('https://poscoffeesystem.000webhostapp.com/itemssalesreport.php');
    try {
      var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
      DateTime now = DateTime.now();

      var map = new Map<String, dynamic>();
      map['coffeid'] = Loginprovider.getcoffeeId();
      map['type'] = 'itemsR';

      http.Response res = await http.post(
        postsURL,
        body: map,
      );
//

      if (res.statusCode == 200) {

        print("itemsDate : "+res.body.toString());
        List<dynamic> body = jsonDecode(res.body);



        List<userRmodel> Doctors = body
            .map((dynamic item) => userRmodel.fromJson(item),
        )
            .toList();

        // print("ProfileDAY" + Doctors.first.username.toString());
        //print("ProfileHOUR" + Doctors.first.totalSales_thidhour.toString());


        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";

      }
    } catch (e) {
      print("ERROR : "+e.toString());
      throw "Unable to retrieve Profile." + e.toString();
    }

  }



  Future<List<HourReportModel>> GetitemsSaleHour(BuildContext c) async {
    Uri postsURL = Uri.parse('https://poscoffeesystem.000webhostapp.com/itemssalesreport.php');
    try {
      var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
      DateTime now = DateTime.now();

      var map = new Map<String, dynamic>();
      map['coffeid'] = Loginprovider.getcoffeeId();
      map['type'] = 'hourR';

      http.Response res = await http.post(
        postsURL,
        body: map,
      );
//

      if (res.statusCode == 200) {

        print("ddddatttte : "+res.body.toString());
        List<dynamic> body = jsonDecode(res.body);



        List<HourReportModel> Doctors = body
            .map((dynamic item) => HourReportModel.fromJson(item),
        )
            .toList();

        // print("ProfileDAY" + Doctors.first.username.toString());
        //print("ProfileHOUR" + Doctors.first.totalSales_thidhour.toString());


        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";

      }
    } catch (e) {
      print("ERROR : "+e.toString());
      throw "Unable to retrieve Profile." + e.toString();
    }

  }


  Future<List<HourReportModel>> GetitemsSaleMonth (BuildContext c) async {
    Uri postsURL = Uri.parse('https://poscoffeesystem.000webhostapp.com/itemssalesreport.php');
    try {

      var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

      var map = new Map<String, dynamic>();
      map['coffeid'] = Loginprovider.getcoffeeId();
      map['type'] = 'monthR';
      map['year'] = '2023';

      http.Response res = await http.post(
        postsURL,
        body: map,
      );
//

      if (res.statusCode == 200) {

        print("TTTTTT : "+res.body.toString());
        List<dynamic> body = jsonDecode(res.body);



        List<HourReportModel> Doctors = body
            .map((dynamic item) => HourReportModel.fromJson(item),
        )
            .toList();

        // print("ProfileDAY" + Doctors.first.username.toString());
        //print("ProfileHOUR" + Doctors.first.totalSales_thidhour.toString());


        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";

      }
    } catch (e) {
      print("ERROR : "+e.toString());
      throw "Unable to retrieve Profile." + e.toString();
    }

  }


  String getHourname(String hourr) {

    var hour=int.parse(hourr);

    if (hour < 0 || hour > 23) {
      return 'وقت غير صالح';
    }

    List<String> hourWords = [
      'الثانية عشرة',
      'الواحدة',
      'الثانية',
      'الثالثة',
      'الرابعة',
      'الخامسة',
      'السادسة',
      'السابعة',
      'الثامنة',
      'التاسعة',
      'العاشرة',
      'الحادية عشرة',
      'الثانية عشرة', // For 12 o'clock and 24 o'clock
      'الواحدة',
      'الثانية',
      'الثالثة',
      'الرابعة',
      'الخامسة',
      'السادسة',
      'السابعة',
      'الثامنة',
      'التاسعة',
      'العاشرة',
      'الحادية عشرة',
    ];

    if (hour >= 0 && hour <= 11) {
      return '${hourWords[hour]} صباحًا';
    } else {
      return '${hourWords[hour]} مساءً';
    }
  }


  String numberToArabicMonth(String monthNumberr) {
    var monthNumber=int.parse(monthNumberr);
    if (monthNumber < 1 || monthNumber > 12) {
      return 'شهر غير صالح';
    }

    List<String> arabicMonths = [
      'يناير',
      'فبراير',
      'مارس',
      'إبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    return arabicMonths[monthNumber - 1];
  }

}

