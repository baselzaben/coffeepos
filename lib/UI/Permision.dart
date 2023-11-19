import 'dart:convert';
import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import '../Model/PermisionModel.dart';
import '../Model/PermisionModel.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

class Permision extends StatefulWidget {
  @override
  State<Permision> createState() => _NotificationsState();
}

class _NotificationsState extends State<Permision> {
  @override
  void initState() {
    GetEmployeeId();
    GetEmployeeId();
    super.initState();
  }


  var setpermision=false;

  var EmpId='';
  var employeename='';
  var pass='';
  var user='';

  GetEmployeeId() async {
    var prefs = await SharedPreferences.getInstance();
    EmpId=await prefs.getString('employeeid')??'';
    employeename=await prefs.getString('employeename')??'';

    pass=await prefs.getString('pass')??'';
    user=await prefs.getString('user')??'';

  }


  var check = false;
  TextEditingController dateinputC = TextEditingController();
  bool isSwitchedFT = false;


  @override
  void dispose() {
    super.dispose();
  }
var Dtype='0';

 bool switchinititem = false;
 bool switchdebitpersion= false;
 bool switchdebtbook = false;
 bool switchaddqt = false;
 bool switchreport= false;




  @override
  Widget build(BuildContext context) {
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


          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(context,'صلاحيات الموظفين'
           ,unitHeightValue,LanguageProvider.langg,LanguageProvider.getDirection()),
         ),
          backgroundColor: HexColor(ThemP.getcolor()),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/1,
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
                  child:

    Center(
      child: Column(
        children: [
SizedBox(height: 30,),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 4),
                  child: SizedBox(
                    child: Text(
                      textAlign: TextAlign.right,
                      employeename,
                      style: ArabicTextStyle(arabicFont: ArabicFont.tajawal,
                          color: Colors.black, fontSize: 22 * unitHeightValue, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),

                Container(
                  width: 50 * unitHeightValue,
                  height: 50 * unitHeightValue,
                  child: Image.asset(
                    "assets/persion.png",
                    height: 50,
                    width: 50,
                    color: HexColor(ThemP.getcolor()),
                  ),

                ),
              ],
            ),
          ),

         /* Container(width: MediaQuery.of(context).size.width/1.2,
          height: 2,color:Colors.black),*/




          SizedBox(
            width: MediaQuery.of(context).size.width/1.3,
            child: Card(child: Text(
              textAlign: TextAlign.right,
              user+ ' : اسم المستخدم',

              style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 16 * unitHeightValue, fontWeight: FontWeight.w400),
            ),),
          ),
          SizedBox(width: MediaQuery.of(context).size.width/1.3,

            child: Card(child: Text(
              textAlign: TextAlign.right,
              pass+ ' : كلمه المرور ',
              style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 16 * unitHeightValue, fontWeight: FontWeight.w400),
            ),),
          ),

          SizedBox(height: 20,),



          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
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
                future: getPermision(context),
                builder: (BuildContext
                context, AsyncSnapshot<
                    List<PermisionModel>>
                snapshot) {
                  if (snapshot.hasData) {
                    List<PermisionModel>?
                    Visits = snapshot.data;

                    List<PermisionModel>? search = Visits!
                        .where((element) => element
                        .report
                        .toString()
                        .contains(
                        dateinputC
                            .text
                            .toString() ) )
                        .toList();

                    return ListView(
                      children: Visits
                          .map(
                              (PermisionModel
                          v) =>





                              GestureDetector(
                                onTap: () {

                               /*   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Permision()),
                                  );
            */

                                },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [

                                        SizedBox(
                                            child: Row(
                                              children: [
            Spacer(),
                                                SizedBox(
                                                  child: Switch(
                                                    value: switchinititem,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        switchinititem = value;
                                                      });
                                                    },
                                                  ),
                                                ),


                                                Spacer(),


                                                 SizedBox(
                                                   width: MediaQuery.of(context).size.width/2,
                                                   child: Text(
                                                      textAlign: TextAlign.right,
                                                      'تعريف المواد و الاصناف',
                                                      style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 16 * unitHeightValue, fontWeight: FontWeight.w400),
                                                    ),
                                                 ),

                                              ],
                                            )),

                                        SizedBox(
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                SizedBox(
                                                  child: Switch(
                                                    value: switchdebitpersion,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        switchdebitpersion = value;
                                                      });
                                                    },
                                                  ),
                                                ),


                                                Spacer(),


                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width/2,

                                                  child: Text(
                                                    textAlign: TextAlign.right,
                                                    'تعريف الدائنين',
                                                    style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 16 * unitHeightValue, fontWeight: FontWeight.w400),
                                                  ),
                                                ),

                                              ],
                                            )),

                                        SizedBox(
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                SizedBox(
                                                  child: Switch(
                                                    value: switchdebtbook,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        switchdebtbook = value;
                                                      });
                                                    },
                                                  ),
                                                ),


                                                Spacer(),


                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width/2,

                                                  child: Text(
                                                    textAlign: TextAlign.right,
                                                    'أضافة الديون',
                                                    style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 16 * unitHeightValue, fontWeight: FontWeight.w400),
                                                  ),
                                                ),

                                              ],
                                            )),

                                        SizedBox(
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                SizedBox(
                                                  child: Switch(
                                                    value: switchaddqt,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        switchaddqt = value;
                                                      });
                                                    },
                                                  ),
                                                ),


                                                Spacer(),


                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width/2,

                                                  child: Text(
                                                    textAlign: TextAlign.right,
                                                    'أضافة الكميات',
                                                    style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 16 * unitHeightValue, fontWeight: FontWeight.w400),
                                                  ),
                                                ),

                                              ],
                                            )),

                                        SizedBox(
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                SizedBox(
                                                  child: Switch(
                                                    value: switchreport,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        switchreport = value;
                                                      });
                                                    },
                                                  ),
                                                ),


                                                Spacer(),


                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width/2,

                                                  child: Text(
                                                    textAlign: TextAlign.right,
                                                    'الاطلاع على تقارير البيع',
                                                    style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 16 * unitHeightValue, fontWeight: FontWeight.w400),
                                                  ),
                                                ),

                                              ],
                                            )),


                                      ],
                                    ),
                                  ),
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
          ),
          Spacer(),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width/2,
              color: HexColor(Globalvireables.white),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:Colors.green,
                ),
                child: Text(
                 'حفظ',
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.tajawal,
                      color:
                      HexColor(Globalvireables.white),
                      fontSize: 16 * unitHeightValue),
                ),
                onPressed: () async {

                  UploadPermision(context);

                },
              ),
            ),
          ),
          Spacer(),



        ],
      ),
    ),



                ),
              ),
            ),
          )),
    ]);
  }



  Future<List<PermisionModel>> getPermision(
      BuildContext c) async {
    Uri postsURL = Uri.parse('https://coffepoint.net/Api/getPermision.php');
    try {

      var Loginprovider = Provider.of<LoginProvider>(context, listen: false);



      var prefs = await SharedPreferences.getInstance();
     var EmpId=await prefs.getString('employeeid')??'';
      print("EmpId : "+EmpId);



      var map = new Map<String, dynamic>();
      map['coffeid'] = Loginprovider.getcoffeeId();
      map['employeeid'] = EmpId;

      http.Response res = await http.post(
        postsURL,
        body: map,
      );


      print("inputt " + map.toString());


      if (res.statusCode == 200) {
        print("Profile" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<PermisionModel> Doctors = body
            .map(
              (dynamic item) => PermisionModel.fromJson(item),
        )
            .toList();




if(!setpermision) {
  setState(() {
    switchinititem =
        convertIntToBool(int.parse(Doctors[0].inititem.toString()));
    switchdebitpersion =
        convertIntToBool(int.parse(Doctors[0].debitpersion.toString()));
    switchdebtbook =
        convertIntToBool(int.parse(Doctors[0].debtbook.toString()));
    switchaddqt = convertIntToBool(int.parse(Doctors[0].addqt.toString()));
    switchreport = convertIntToBool(int.parse(Doctors[0].report.toString()));
  });
  setpermision=true;
}







        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";
      }
    } catch (e) {
    }

    throw "Unable to retrieve Profile.";
  }


 UploadPermision(
      BuildContext c) async {
    Uri postsURL = Uri.parse('https://coffepoint.net/Api/UpdatePermision.php');
      var l = Provider.of<Language>(context, listen: false);

      var Loginprovider = Provider.of<LoginProvider>(context, listen: false);


      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('تحديث الصلاحيات'),
            content: Text(l.getLanguage() == "AR"
                ? 'جار تحديث الصلاحيات ...'
                : 'updating permision ..'),
          ));



      var prefs = await SharedPreferences.getInstance();
      var EmpId=await prefs.getString('employeeid')??'';
      print("EmpId : "+EmpId);



      var map = new Map<String, dynamic>();
      map['coffeid'] = Loginprovider.getcoffeeId();
      map['employeeid'] = EmpId;

      map['inititem'] = switchinititem?'1':'0';
      map['debitpersion'] = switchdebitpersion?'1':'0';
      map['debtbook'] = switchdebtbook?'1':'0';
      map['addqt'] = switchaddqt?'1':'0';
      map['report'] = switchreport?'1':'0';


      http.Response res = await http.post(
        postsURL,
        body: map,
      );


      print("inputt " + map.toString());


      if (res.statusCode == 200) {
        print("Profile" + res.body.toString());




        if (res.body.toString().contains('1S')) {
          Navigator.pop(context);
          setState(() {

          });
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('تحديث الصلاحيات'),
                content: Text(l.getLanguage() == "AR"
                    ? 'تم تحديث الصلاحيات بنجاح'
                    : 'updating permision is done..'),
              ));
        } else {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('تحديث الصلاحيات'),
                content: Text(l.Llanguage('anerror')),
              ));
        }
      } else {
        throw "Unable to retrieve Profile.";
      }
  }


  bool convertIntToBool(int value) {
    return value != 0;
  }

}
