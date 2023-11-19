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
import '../Model/EmplyeeModel.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

import 'Permision.dart';

class Employee extends StatefulWidget {
  @override
  State<Employee> createState() => _NotificationsState();
}

class _NotificationsState extends State<Employee> {
  @override
  void initState() {
    super.initState();
  }


  var check = false;
  TextEditingController dateinputC = TextEditingController();
  bool isSwitchedFT = false;


  @override
  void dispose() {
    super.dispose();
  }
var Dtype='0';

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
        addEmployee
          (context);
      },
      ),
      ),
      ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(context,'تعريف الموظفين'
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

          Padding(
            padding: const EdgeInsets.only(top:10.0),
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
SizedBox(height: 40,),


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
                  future: getAllEmployee(context,''),
                  builder: (BuildContext
                  context, AsyncSnapshot<
                          List<EmplyeeModel>>
                      snapshot) {
                    if (snapshot.hasData) {
                      List<EmplyeeModel>?
                      Visits = snapshot.data;

                      List<EmplyeeModel>? search = Visits!
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
                            .map(
                                (EmplyeeModel
                            v) =>





                                    GestureDetector(
                                      onTap: () {

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Permision()),
                                        );


                                      },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {


   var prefs = await SharedPreferences.getInstance();
   prefs.setString('employeeid',v.id.toString());
   prefs.setString('employeename',v.name.toString());

   prefs.setString('pass',v.passwordd.toString());
   prefs.setString('user',v.username.toString());


   Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Permision()),
                                              );


                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                  child: Row(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: Container(
                                                          height: 40,
                                                          width: MediaQuery.of(context).size.width/4,
                                                          color: HexColor(Globalvireables.white),
                                                          child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                              primary:v.active=='1'?
                                                              Colors.redAccent:Colors.green,
                                                            ),
                                                            child: Text(
                                                              v.active=='1'?'ايقاف':'تفعيل',
                                                              style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,
                                                                  color:
                                                                  HexColor(Globalvireables.white),
                                                                  fontSize: 12 * unitHeightValue),
                                                            ),
                                                            onPressed: () async {
                                                              updateemployee(context,  v.active=='1'?'0':'1',v.id.toString());
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                     /* Container(
                                                        child: Text(
                                                          textAlign: TextAlign.center,
                                                          v.total.toString()=='null'?'0.0'+ " JD ":v.total.toString() + " JD ",
                                                          style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 14 * unitHeightValue, fontWeight: FontWeight.w400),
                                                        ),
                                                      ),*/

                                                      Spacer(),
                                                      Column(
                                                        children: [
                                                          Container(
                                                            width: 120,
                                                            child: Text(
                                                              textAlign: TextAlign.right,
                                                              v.name.toString(),
                                                              style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 16 * unitHeightValue, fontWeight: FontWeight.w400),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 110,
                                                            child: Text(
                                                              textAlign: TextAlign.right,
                                                              v.phone.toString(),
                                                              style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black,
                                                                  fontSize: 14 * unitHeightValue, fontWeight: FontWeight.w300),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
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
                          child:
                          CircularProgressIndicator());
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
          )),
    ]);
  }
  Future<String?> addEmployee(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    TextEditingController searchusercontroller = TextEditingController();
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);


    var itemVar='';

    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController confirmpassword = TextEditingController();

    var l = Provider.of<Language>(context, listen: false);


    int? selectedOption;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title:
                  Center(child: Text('تعريف الموظفين')),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('اسم الموظف'),
                        TextField(
                          textAlign: TextAlign.center,
                          controller: name,
                          decoration: InputDecoration(hintText: ""),
                        ),
                        SizedBox(height: 14,),
                        Text('رقم الهاتف'),

                        TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: phone,
                          decoration: InputDecoration(hintText: ""),
                        ),

                        SizedBox(height: 14,),
                        Text('اسم المستخدم (اللغه الانجليزيه)'),

                        TextField(
                          textAlign: TextAlign.center,
                          controller: username,
                          decoration: InputDecoration(hintText: ""),
                        ),

                        SizedBox(height: 14,),
                        Text('كلمه المرور'),
                        TextField(
                          textAlign: TextAlign.center,
                          controller: password,
                          decoration: InputDecoration(hintText: ""),
                        ),
                        SizedBox(height: 14,),
                        Text('تاكيد كلمه المرور'),
                        TextField(
                          textAlign: TextAlign.center,
                          controller: confirmpassword,
                          decoration: InputDecoration(hintText: ""),
                        ),


                      ],
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text(LanguageProvider.Llanguage('cancel'),style: TextStyle(color: Colors.black),),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      child: Text(LanguageProvider.Llanguage('save'),style: TextStyle(color: Colors.black)),
                      onPressed: () =>  SaveEmployee(context, name.text.toString()
                          , phone.text.toString(), password.text.toString()
                          , username.text.toString() , confirmpassword.text.toString())
                      ,
                    ),
                  ],
                );
              });
        });
  }

  SaveEmployee(BuildContext context,String name,String phone,
      String password
      ,String username,String confirmpassword) async {
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
    map['name'] = name;
    map['phone'] = phone;
    map['password'] = password;
    map['username'] = username;
    map['confirmpassword'] = confirmpassword;
    map['coffeeid'] = Loginprovider.getcoffeeId().toString();
    map['usertype'] ='0';


    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://coffepoint.net/Api/addemployee.php');

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
  updateemployee(BuildContext context,String state,String empid ) async {
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
    map['empid'] = empid;
    map['state'] = state;
    map['coffeid'] = Loginprovider.coffeeId.toString();


    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://coffepoint.net/Api/updateemployee.php');

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



  Future<List<EmplyeeModel>> getAllEmployee(
      BuildContext c, String coffeeid) async {
    Uri postsURL = Uri.parse('https://coffepoint.net/Api/getemployee.php');
    try {
      var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

      var map = new Map<String, dynamic>();
      map['coffeid'] = Loginprovider.getcoffeeId().toString();

      http.Response res = await http.post(
        postsURL,
        body: map,
      );
//

      if (res.statusCode == 200) {
        print("Profile" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<EmplyeeModel> Doctors = body
            .map((dynamic item) => EmplyeeModel.fromJson(item),
        )
            .toList();

        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";
      }
    } catch (e) {

      print("ERROR : "+e.toString());

    }

    throw "Unable to retrieve Profile.";
  }



}
