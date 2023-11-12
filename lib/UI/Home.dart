import 'dart:convert';
import 'package:coffeepos/UI/Creditors.dart';
import 'package:coffeepos/UI/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import '../Model/HourReportModel.dart';
import '../Model/SumSaleModel.dart';
import '../Model/classessModel.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:arabic_font/arabic_font.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import 'Bill.dart';
import 'DeptBook.dart';
import 'Employee.dart';
import 'Qtitems.dart';
import 'Report.dart';
import 'classess.dart';
import 'items.dart';




class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {

    ShowMessage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
var state="";
  var message='';
  var summsale='0.0';
  @override
  Widget build(BuildContext context) {

    GetSaleState(context);

    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var ThemP = Provider.of<Them>(context, listen: false);
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
                icon: Icon(Icons.inventory_2_outlined),
                label: LanguageProvider.Llanguage('Invoices')),
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

        backgroundColor: Colors.transparent,
        body: Directionality(
          textDirection: LanguageProvider.getDirection(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 30 * unitHeightValue,
                              height: 30 * unitHeightValue,
                              child: Image.asset(
                                "assets/persion.png",
                                height: 30,
                                width: 30,
                                color: HexColor(ThemP.getcolor()),
                              ),

                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(

                              LanguageProvider.getLanguage() == "AR"
                                  ? Loginprovider.getname().toString()
                                  : Loginprovider.getname().toString(),
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.tajawal,
                                  color: HexColor(Globalvireables.black2),
                                  fontSize: 18 * unitHeightValue,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {

                          //GetReport(context);

                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topRight,
                          child: Text(
    textAlign:TextAlign.right,
    Loginprovider.getcoffename().toString(),
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.tajawal,
                                  color: HexColor(Globalvireables.black2),
                                  fontSize: 20 * unitHeightValue,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Column(children: [
  SizedBox(

      child:Column(children: [
          Row(children: [
            Text("التاريخ : ",
                style: ArabicTextStyle(
                    arabicFont: ArabicFont.tajawal,
                    color: HexColor(Globalvireables.black),
                    fontSize: 18 * unitHeightValue,
                    fontWeight: FontWeight.w700)),

            SizedBox(
              height: 10,
            ),
            Text(DateTime.now().toString().substring(0,10),
                style: ArabicTextStyle(
                    arabicFont: ArabicFont.tajawal,
                    color: HexColor(Globalvireables.black),
                    fontSize: 18 * unitHeightValue,
                    fontWeight: FontWeight.w700))

          ]),


          Container(
            width: MediaQuery.of(context).size.width/1,
            child: Row(children: [
              Text("مبيعات اليوم : ",
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.tajawal,
                      color: HexColor(Globalvireables.black),
                      fontSize: 18 * unitHeightValue,
                      fontWeight: FontWeight.w700)),

              SizedBox(
                height: 10,
              ),



                FutureBuilder(
                future: GetSumDaySale(context),
                builder: (BuildContext context,
                AsyncSnapshot<List<SumSaleModel>> snapshot) {
                List<SumSaleModel>? Doctors = snapshot.data;
                  if (snapshot.hasData ) {

                    summsale=Doctors!.first.totalSales_thidhour.toString();

                    return   Text(Doctors.first.totalSales.toString() +" دينار ",
                        style: ArabicTextStyle(
                            arabicFont: ArabicFont.tajawal,
                            color: HexColor(Globalvireables.black),
                            fontSize: 18 * unitHeightValue,
                            fontWeight: FontWeight.w700));
                }   else {
                    return Padding(
                      padding: const EdgeInsets.only(left:12.0,right: 12.0),
                      child: Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator()),
                    );
                  }
                },
              ),





            ]),
          ),


    ],)



  ),
  SizedBox(


      child:Column(children: [

        Row(children: [
          Text("حاله البيع : ",
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color: HexColor(Globalvireables.black),
                  fontSize: 18 * unitHeightValue,
                  fontWeight: FontWeight.w700)),

          SizedBox(
            height: 10,
          ),
          /*Text(state,
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color:state.contains('اقل')? Colors.redAccent:Colors.green,
                  fontSize: 18 * unitHeightValue,
                  fontWeight: FontWeight.w700))*/
          FutureBuilder(
            future: GetSaleState(context),
            builder: (BuildContext context,
                AsyncSnapshot<String> snapshot) {
              String? Doctors = snapshot.data;

              if (snapshot.hasData) {
                return   Text(Doctors! ,
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.tajawal,
                        color:Doctors.contains('اقل')? Colors.redAccent:Colors.green,
                        fontSize: 18 * unitHeightValue,
                        fontWeight: FontWeight.w700));
              }   else {
                return CircularProgressIndicator();
              }
            },
          ),

        ]),


      ],)



  ),
  SizedBox(

      child:Column(children: [
        Row(children: [
          Text("تاريخ صلاحيه النظام : ",
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color: HexColor(Globalvireables.black),
                  fontSize: 18 * unitHeightValue,
                  fontWeight: FontWeight.w700)),

          SizedBox(
            height: 10,
          ),
          Text(DateTime.now().toString().substring(0,10),
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color: HexColor(Globalvireables.black),
                  fontSize: 18 * unitHeightValue,
                  fontWeight: FontWeight.w700))

        ]),





      ],)



  ),


                        Loginprovider.getmessage().toString().length>7? Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                color: Colors.transparent,

                              ),
                              child:Column(children: [
                                Row(children: [
                                  Container(
width: MediaQuery.of(context).size.width/1.3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(Loginprovider.getmessage(),
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              color: Colors.redAccent,
                                              fontSize: 14 * unitHeightValue,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),



                                ]),




                              ],)



                          ),
                        ):Container(),



                      ],),

Container(
  alignment: Alignment.center,
  width: MediaQuery.of(context).size.width/1.05,
  height: 2,
  color:HexColor(ThemP.getcolor()),
),


                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          children: [
                            Spacer(),

                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {

                                    print(Loginprovider.getinititem() +"proooov");
if(Loginprovider.getinititem()=='1'){
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => items()),
  );
}else{
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('الصلاحيات'),
        content: Text('لا تملك الصلاحية'),
      ));
}




                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: HexColor(ThemP.getcolor())),
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        width:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,
                                        height:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Image.asset(
                                              "assets/item.png",
                                              color: HexColor(ThemP.getcolor()),
                                              height: 40* unitHeightValue,
                                              width: 40* unitHeightValue,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("تعريف المواد",
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              color: HexColor(ThemP.getcolor()),
                                              fontSize: 14 * unitHeightValue,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40,),

                                GestureDetector(
                                  onTap: () {

                                    if(Loginprovider.getusertype()=='1'){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Employee()),
                                      );
                                    }else{
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text('الصلاحيات'),
                                            content: Text('لا تملك الصلاحية'),
                                          ));
                                    }


                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(

                                          border: Border.all(
                                              color: HexColor(ThemP.getcolor())),
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        width:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                        height:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Image.asset(
                                              "assets/employee.png",
                                              color: HexColor(ThemP.getcolor()),
                                              height: 40* unitHeightValue,
                                              width: 40* unitHeightValue,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("تعريف الموظفين",
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              color: HexColor(ThemP.getcolor()),
                                              fontSize: 14 * unitHeightValue,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),






                              ],
                            ),
                            Spacer(),

                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {


                                    if(Loginprovider.getusertype()=='1'){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Bill()),
                                      );
                                    }else{
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Bill()),
                                      );
                                    }




                                  },
                                  child: Column(
                                    children: [
                                      Container(

                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: HexColor(ThemP.getcolor())),
                                          borderRadius: BorderRadius.circular(15.0),
                                     ),
                                        width:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                        height:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Image.asset(
                                              "assets/bill.png",
                                              color: HexColor(ThemP.getcolor()),
                                              height: 40* unitHeightValue,
                                              width: 40* unitHeightValue,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("الفاتوره",
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              color: HexColor(ThemP.getcolor()),
                                              fontSize: 14 * unitHeightValue,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40,),

                                GestureDetector(
                                  onTap: () {

                                    if(Loginprovider.getdebtbook()=='1'){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DeptBook()),
                                      );
                                    }else{
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text('الصلاحيات'),
                                            content: Text('لا تملك الصلاحية'),
                                          ));
                                    }




                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(

                                          border: Border.all(
                                              color: HexColor(ThemP.getcolor())),
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        width:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                        height:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Image.asset(
                                              "assets/debt.png",
                                              color: HexColor(ThemP.getcolor()),
                                              height: 40* unitHeightValue,
                                              width: 40* unitHeightValue,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('دفتر الديون',
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              color: HexColor(ThemP.getcolor()),
                                              fontSize: 14 * unitHeightValue,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            Spacer(),

                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {


                                    if(Loginprovider.getinititem()=='1'){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => classess()),
                                      );
                                    }else{
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text('الصلاحيات'),
                                            content: Text('لا تملك الصلاحية'),
                                          ));
                                    }



                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: HexColor(ThemP.getcolor())),
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        width:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                        height:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Image.asset(
                                              "assets/categorize.png",
                                              color: HexColor(ThemP.getcolor()),
                                              height: 40* unitHeightValue,
                                              width: 40* unitHeightValue,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(LanguageProvider.Llanguage('addclasses'),
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              color: HexColor(ThemP.getcolor()),
                                              fontSize: 14 * unitHeightValue,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40,),
                                GestureDetector(
                                  onTap: () {


                                    if(Loginprovider.getaddqt()=='1'){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Qtitems()),
                                      );
                                    }else{
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text('الصلاحيات'),
                                            content: Text('لا تملك الصلاحية'),
                                          ));
                                    }

                                  //  GetReport(context);

                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: HexColor(ThemP.getcolor())),
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        width:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                        height:
                                        Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Container(
                                                width: 60,
                                                height: 60,
                                                child: SvgPicture.asset("assets/qticon.svg",color: HexColor(ThemP.getcolor())))
                                            ,Spacer(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("المخزون",
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              color: HexColor(ThemP.getcolor()),
                                              fontSize: 14 * unitHeightValue,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            Spacer(),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child:     Row(
                          children: [
                            GestureDetector(
                              onTap: () {


                                if(Loginprovider.getreport()=='1'){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Report()),
                                  );
                                }else{
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text('الصلاحيات'),
                                        content: Text('لا تملك الصلاحية'),
                                      ));
                                }





                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    width:
                                    Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,
                                    height:
                                    Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Image.asset(
                                          "assets/report.png",
                                          color: HexColor(ThemP.getcolor()),
                                          height: 40* unitHeightValue,
                                          width: 40* unitHeightValue,
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("تقارير العمل",
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize: 14 * unitHeightValue,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                            Spacer(),
                            Spacer(),
                            GestureDetector(
                              onTap: () {



                                if(Loginprovider.getdebitpersion()=='1'){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Creditors()),
                                  );
                                }else{
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text('الصلاحيات'),
                                        content: Text('لا تملك الصلاحية'),
                                      ));
                                }



                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),

                                    width : Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,
                                    height: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.height / 4.8: MediaQuery.of(context).size.width / 4.5,

                                    child: Column(
                                      children: [
                                        Spacer(),


                                        Image.asset(
                                          "assets/employee.png",
                                          color: HexColor(ThemP.getcolor()),
                                          height: 40* unitHeightValue,
                                          width: 40* unitHeightValue,
                                        ),

                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),


                                  Text("تعريف الدائنين",
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize: 14 * unitHeightValue,
                                          fontWeight: FontWeight.w700)
                                  ),


                                ],
                              ),
                            ),
                            Spacer(),
                            Spacer(),
                            Spacer(),
                            Spacer(),
                            Spacer(),
                            Spacer(),
                            Spacer(),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  _onItemTapped(int index) {
    if (index != 1) {
      setState(() {
        selectedIndex = index;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nav[index]),
        );
      });
    }
  }

  int selectedIndex = 1;

  final List<Widget> nav = [
    Settings(),
    Home(),
    Bill()


  ];

  Future<String> GetSaleState(BuildContext context) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    var map = new Map<String, dynamic>();
    map['coffeid'] = Loginprovider.getcoffeeId();
    map['type'] = 'hourR';

    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/itemssalesreport.php');

      http.Response response = await http.post(apiUrl, body: map);

      print("countValue " + response.body.toString());

      DateTime now = DateTime.now();
    //  int hourToFind = now.hour;
      int hourToFind = 16;

      List<HourReportModel> data = (json.decode(response.body.toString()) as List)
          .map((json) => HourReportModel.fromJson(json))
          .toList();

      HourReportModel? result = data.firstWhere((element) => element.hour.toString() == hourToFind.toString());

      print("No data found for hour " + result.count);

      String countValue = '0.0';
      if (result != null) {
        countValue = result.count;
        print("Count for hour $hourToFind: $countValue");
      } else {
        print("No data found for hour $hourToFind.");
      }

      var currentSale = summsale;


      print("currentSale : "+currentSale.toString());
      print("countValue : "+countValue.toString());
      print("currentSale : "+map.toString());

      state = 'غير متوفر حاليا';

      if (double.parse(currentSale.toString()) > double.parse(countValue.toString())) {
        state = "أعلى من المعتاد";
      } else {
        state = "اقل من المعتاد";
      }

      return state; // Ensure a value is returned on all code paths

    } catch (e) {
      print("errrrrror");
      state = "غير متوفر حاليا";
      return state; // Ensure a value is returned on all code paths
    }
  }

 /*Future<String> GetSaleState(BuildContext context) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();


    var map = new Map<String, dynamic>();
    map['coffeid'] = Loginprovider.getcoffeeId();
     map['type'] = 'hourR';


    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/itemssalesreport.php');

      http.Response response = await http
          .post(
        apiUrl,
        body: map,
      )
          .whenComplete(() => null);


      print("countValue  "+response.body.toString());


      DateTime now = DateTime.now();
      int hourToFind= now.hour;


      List<HourReportModel> data = (json.decode(response.body.toString()) as List)
          .map((json) => HourReportModel.fromJson(json))
          .toList();


      HourReportModel? result = data.firstWhere((element) => element.hour == hourToFind);



      print("No data found for hour "+result.count);

      String countValue='0.0';
      if (result != null) {
         countValue = result.count;
        print("Count for hour $hourToFind: $countValue");
      } else {
        print("No data found for hour $hourToFind.");
      }



   var currentsale=await GetSumDaySale(context);

      state='غير متوفر حاليا';


if(double.parse(currentsale.toString())>double.parse(countValue.toString()))
  {
    state= ("أعلى من المعتاد");
    return state;

  }
else {
  state = ("اقل من المعتاد");
  return state;
}
    } catch (e) {

      print("errrrrror");

      state= ("غير متوفر حاليا");


    }
    state = ("اقل من المعتاد");

 }

*/

  Future<List<SumSaleModel>> GetSumDaySale(
      BuildContext c) async {
    Uri postsURL = Uri.parse('https://poscoffeesystem.000webhostapp.com/itemssalesreport.php');
    try {
      var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
      DateTime now = DateTime.now();

     var map = new Map<String, dynamic>();
      map['coffeid'] = Loginprovider.getcoffeeId();
      map['type'] = 'sumsaledayR';
      map['date'] = now.toString().substring(0,10);
     // map['date'] = '2023-09-17';
      map['hour'] = now.hour.toString();

      print("ddddatttte : "+map.toString());


      http.Response res = await http.post(
        postsURL,
        body: map,
      );
//

      if (res.statusCode == 200) {

        print("ddddatttte : "+res.body.toString());


        List<dynamic> body = jsonDecode(res.body);
        print("ddddatttte : "+res.body.toString());

        List<SumSaleModel> Doctors = body
            .map((dynamic item) => SumSaleModel.fromJson(item),
        )
            .toList();

        print("ProfileDAY" + Doctors.first.totalSales.toString());
        print("ProfileHOUR" + Doctors.first.totalSales_thidhour.toString());


        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";

      }
    } catch (e) {

      print("ERROR : "+e.toString());
      throw "Unable to retrieve Profile.";

    }

  }

  ShowMessage() async {
   var prefs = await SharedPreferences.getInstance();


 message= (await prefs.getString('message'))??'noooo';
print("mmessage : "+message.toString());

  }

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