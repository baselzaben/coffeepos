import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import '../Model/AppModel.dart';
import '../Model/LoginModel.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import  'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:arabic_font/arabic_font.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import 'Home.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _ipControler = TextEditingController();


  var isMackOs=false;

  var check = false;

  @override
  void initState() {

    Getrememper();
    super.initState();
  }
var Terms;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }
var prefs;
  bool _obscured = true;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  var Loginprovider;
  @override
  Widget build(BuildContext context) {
_ipControler.text='10.0.1.65:9999';
double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
 isMackOs = Theme.of(context).platform == TargetPlatform.macOS;


var ThemP = Provider.of<Them>(context, listen: false);
var LanguageProvider = Provider.of<Language>(context, listen: false);




     Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    return Stack(children: <Widget>[
      Image.asset(
        "assets/background2.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: LanguageProvider.getDirection(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              margin: EdgeInsets.only(top: isMackOs?10: 20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: isMackOs?10:30),
                          width: MediaQuery.of(context).size.width / 1,
                          child: Column(
                            children: [
                             Container(

                                    width: MediaQuery.of(context).size.width / 1,
                                    height:
                                    Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.width/12
                                        :MediaQuery.of(context).size.width/2,


                                    child: Image(
                                        image: new AssetImage(
                                         "assets/logo.png"))),

        /*  Container(
              alignment:Alignment.center,
margin: EdgeInsets.only(top:Globalvireables.getDeviceType()=='tablet'? 44:0),
              child: Text(
    textAlign: TextAlign.center,
                  LanguageProvider.Llanguage("AlEsraaHospital"),
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.tajawal,
                      color: HexColor(Globalvireables.black2),
                      fontSize: 25 * unitHeightValue,
                      fontWeight: FontWeight.w700)
              )),*/
                              SizedBox(
                                height: isMackOs?10:17,

                              ),
                              Container(
                                 width: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width/1.3,
                                  margin: EdgeInsets.only(
                                      left: 25, right: 25, top: isMackOs?MediaQuery.of(context).size.width/10:10),
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email,color: HexColor(ThemP.getcolor())),
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
                                      hintText: LanguageProvider.Llanguage(
                                          "username"),
                                    ),
                                  )),
                              Container(
                                  width: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width/1.3,

                                  margin: EdgeInsets.only(
                                      left:  25, right: 25, top: 44),
                                  child: TextField(
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: _obscured,
                                    controller: _passController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.admin_panel_settings_sharp,color: HexColor(ThemP.getcolor()),),
                                      suffixIcon: GestureDetector(
                                          onTap: _toggleObscured,
                                          child: Icon(_obscured
                                              ? Icons.remove_red_eye_rounded
                                              : Icons.lens_blur_outlined)),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: HexColor(
                                                  ThemP.getcolor()),
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
                                      hintText: LanguageProvider.Llanguage(
                                          'password'),
                                    ),
                                  )),

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 50,
                                  width: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.width/5:


                                  MediaQuery.of(context).size.width / 1.2,
                                  margin: EdgeInsets.only(top: 40, bottom: 5),
                                  color: HexColor(Globalvireables.white),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          HexColor(ThemP.getcolor()),
                                    ),
                                    child: Text(
                                      LanguageProvider.Llanguage('login'),
                                      style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                          color:
                                              HexColor(Globalvireables.white),
                                          fontSize: 13 * unitHeightValue),
                                    ),
                                    onPressed: () async {


                                      /*Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => Home(),
                                          ),
                                              (Route<dynamic> route) => false);*/

                                   Login(_emailController.text.toString(),_passController.text.toString(),context);

                                              },
                                  ),
                                ),
                              ),
                              if (LanguageProvider.langg == "AR")
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 25, right: 25, top: 0),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: check,
                                            //set variable for value
                                            onChanged: (bool? value) async {
                                              setState(()  {
                                                check = !check;

                                                if(!check){
                                                  prefs.setString('username','');
                                                  prefs.setString('password','');
                                                }

                                                //Provider.of<LoginProvider>(context, listen: false).setRemember(check);
                                                //   saveREstate(check.toString());
                                              });
                                            }),
                                        Text(
                                            LanguageProvider.Llanguage(
                                                "RememberMe"),
                                            style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    12 * unitHeightValue)),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left:Globalvireables.getDeviceType()=='tablet'? 300: 10,
                                        right: Globalvireables.getDeviceType()=='tablet'? 300: 10,),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: check,
                                            //set variable for value
                                            onChanged: (bool? value) async {
                                              setState(() {
                                                check = !check;
                                                cleanRemember(check);
                                                //Provider.of<LoginProvider>(context, listen: false).setRemember(check);
                                                //   saveREstate(check.toString());
                                              });
                                            }),
                                        Text(
                                            LanguageProvider.Llanguage(
                                                "RememberMe"),
                                            style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    12 * unitHeightValue)),
                                      ],
                                    ),
                                  ),
                                ),




                              SizedBox(

                               child:   isMackOs?null:Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 50,
                                    width: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.width/5:


                                    MediaQuery.of(context).size.width / 1.2,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              HexColor(ThemP.getcolor()),
                                        ),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              LanguageProvider.Llanguage(
                                                  'finger'),
                                              style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                                  color: Colors.white,
                                                  fontSize: 12 * unitHeightValue),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.fingerprint,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                        onPressed: () async {


                                          try {
                                            final bool didAuthenticate = await auth.authenticate(

                                              localizedReason: 'Please authenticate to show account balance',
                                              options: const AuthenticationOptions(useErrorDialogs: true,
                                                  stickyAuth: false,
                                                  sensitiveTransaction: true
                                              ),
                                            );
                                           if(didAuthenticate && check){
                                             prefs = await SharedPreferences.getInstance();
                                           /*  Login(
                                             prefs.getString('username'),
                                             prefs.getString('password'),context
                                             );*/
                                          }else{
                                             showDialog(
                                                 context: context,
                                                 builder: (_) => AlertDialog(
                                                   title: Text(LanguageProvider.Llanguage('login')),
                                                   content: Text(LanguageProvider.Llanguage('loginerrorfinget')),
                                                 ));
                                           }
                                          } on PlatformException catch (e) {
                                            print("errorlogiin "+ e.message.toString());
                                           /* if (e.code == auth_error.notEnrolled) {
                                              // Add handling of no hardware here.
                                            } else if (e.code == auth_error.lockedOut ||
                                                e.code == auth_error.permanentlyLockedOut) {
                                            } else {
                                             print("errorlogiin "+ e.message.toString());
                                            }*/
                                          }

                                        }),
                                  ),
                                ),
                             ),

                              SizedBox(height:Globalvireables.getDeviceType()=='tablet'?100: 14),
                              LanguageProvider.getLanguage()!='AR'?
                              Center(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      textAlign:TextAlign.center,

                                      "Powered By NOBUGS",
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(Globalvireables.black)),
                                    ),
                                    Spacer()
                                  ],
                                ),
                              ):
                              Center(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      textAlign:TextAlign.center,

                                      "Powered By NOBUGS",
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(Globalvireables.black)),
                                    ),
                                    Spacer()
                                  ],
                                ),
                              )


                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }


  cleanRemember(bool r) async {
    prefs = await SharedPreferences.getInstance();

    if(!r){
      prefs.setString('username','');
      prefs.setString('password','');
    }

  }
  final LocalAuthentication auth = LocalAuthentication();
  Getrememper() async {
    prefs = await SharedPreferences.getInstance();
   try{
    if(prefs.getString('them')!=null && prefs.getString('them').toString().length>4){
      Provider.of<Them>(context, listen: false).setcolor(prefs.getString('them').toString());
    }}catch(_){

   }

    setState(() {

      Future<void> authinticate() async {

      }

      if(prefs.getString('password').toString().length>1 && prefs.getString('password').toString()!='null'
      && prefs.getString('password').toString()!=null){
        _passController.text= prefs.getString('password').toString();
        _emailController.text= prefs.getString('username').toString();

        check=true;
      }else{
        _passController.text='';
        _emailController.text='';
      }
    });



  }


  Login(String username, String password, BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var l = Provider.of<Language>(context, listen: false);

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title:  Text(l.Llanguage('login')),
          content: Text(l.getLanguage()=="AR"?'جار تسجيل الدخول ...':'Logging in...'),
        ));



    print("UUSER" + username.toString());
    print("PPass" + password.toString());


    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;


  //  try {

      Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/login.php');

      http.Response response = await http
          .post(apiUrl, body:map,)
          .whenComplete(() => Navigator.pop(context));

      if (response.statusCode == 200) {

      List<dynamic> body = jsonDecode(response.body);
      print(body.toString() +"  ghghghghg");

      List<LoginModel> Appoiments = body
          .map(
            (dynamic item) => LoginModel.fromJson(item),
      ).toList();


      print(body.toString() +"  ghghghghg");


try {
  Loginprovider.setusername(Appoiments[0].username.toString());
  Loginprovider.setid(Appoiments[0].id.toString());
  Loginprovider.setname(Appoiments[0].name.toString());
  Loginprovider.setcoffeeId(Appoiments[0].coffeeId.toString());
  Loginprovider.setimage(Appoiments[0].image.toString());
  Loginprovider.setpasswordd(Appoiments[0].passwordd.toString());
  Loginprovider.setphone(Appoiments[0].phone.toString());
  Loginprovider.setusertype(Appoiments[0].usertype.toString());

  Loginprovider.setcoffename(Appoiments[0].coffename.toString());
  Loginprovider.setlocationn(Appoiments[0].locationn.toString());

  Loginprovider.setmessage(Appoiments[0].message.toString());

  ////
  Loginprovider.setinititem(Appoiments[0].inititem.toString());
  Loginprovider.setdebitpersion(Appoiments[0].debitpersion.toString());
  Loginprovider.setdebtbook(Appoiments[0].debtbook.toString());
  Loginprovider.setaddqt(Appoiments[0].addqt.toString());
  Loginprovider.setreport(Appoiments[0].report.toString());

  ///





  prefs = await SharedPreferences.getInstance();
      await prefs.setString('userid', Appoiments[0].username.toString());
  await prefs.setString('message', Appoiments[0].message.toString());

  print(Appoiments[0].message.toString() + "MMMMMMMMMM");




      }catch(_){}
        if (Appoiments[0].username.toString().trim() == username
        && Appoiments[0].passwordd.toString().trim() == password) {

          prefs = await SharedPreferences.getInstance();

          if(check){
            prefs.setString('username',username.toString());
            prefs.setString('password',password.toString());
          }


          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
                  (Route<dynamic> route) => false);


        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(l.Llanguage('login')),
                content: Text(l.Llanguage('loginerror')),
              ));
        }

  } else{
    showDialog(
    context: context,
    builder: (_) => AlertDialog(
    title: Text(l.Llanguage('login')),
    content: Text(l.Llanguage('loginerror')),
    ));

    }

  }



  Future<List<AppModel>> GetAppInfo(
      BuildContext c) async {
    Uri postsURL = Uri.parse('https://poscoffeesystem.000webhostapp.com/itemssalesreport.php');
    try {
      var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
      http.Response res = await http.post(
        postsURL,
      );
      if (res.statusCode == 200) {


        List<dynamic> body = jsonDecode(res.body);

        List<AppModel> Doctors = body
            .map((dynamic item) => AppModel.fromJson(item),
        )
            .toList();


        Loginprovider.setterms(Doctors[0].terms.toString());
        Loginprovider.setAppmessage(Doctors[0].terms.toString());
        Loginprovider.setversion(Doctors[0].terms.toString());



        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";

      }
    } catch (e) {

      print("ERROR : "+e.toString());
      throw "Unable to retrieve Profile.";

    }

  }





}
