import 'dart:convert';
import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import '../Model/CreditorsModel.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

class Creditors extends StatefulWidget {
  @override
  State<Creditors> createState() => _NotificationsState();
}

class _NotificationsState extends State<Creditors> {
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
              width: MediaQuery.of(context).size.width / 5,
              child: FloatingActionButton(
                backgroundColor: HexColor(ThemP.getcolor()),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  addCreditors(context);
                },
              ),
            ),
          ),

          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(context,'تعريف الدائنين'
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
                  future: getcreditors(context),
                  builder: (BuildContext
                  context, AsyncSnapshot<
                          List<CreditorsModel>>
                      snapshot) {
                    if (snapshot.hasData) {
                      List<CreditorsModel>?
                      Visits = snapshot.data;

                      List<CreditorsModel>? search = Visits!
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
                                (CreditorsModel
                            v) =>Dismissible(
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


                                                    DeleteCreditors(context,v.id.toString());


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
                                  child:      Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
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
                                                            primary:HexColor(ThemP.getcolor()),
                                                          ),
                                                          child: Text(
                                                            'تعديل',
                                                            style: ArabicTextStyle(
                                                                arabicFont: ArabicFont.tajawal,
                                                                color:
                                                                HexColor(Globalvireables.white),
                                                                fontSize: 12 * unitHeightValue),
                                                          ),
                                                          onPressed: () async {

                                                            updatedialogCreditors(context,v.name.toString(),v.phone.toString(),v.max.toString(),v.address.toString(),v.id.toString());
                                                            //updateCreditors(context,  v.active=='1'?'0':'1',v.id.toString());
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      child: Text(
                                                        textAlign: TextAlign.center,
                                                        v.max.toString()=='null'?'0.0'+ " JD ":v.max.toString() + " JD ",
                                                        style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 14 * unitHeightValue, fontWeight: FontWeight.w400),
                                                      ),
                                                    ),

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

                                )
                           )
                            .toList(),
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/1.5,
                            height: MediaQuery.of(context).size.width/1.5,
                            child: SvgPicture.asset(
                              "assets/nodata.svg",
                            ),
                          ),

                          Text(
                            textAlign: TextAlign.center,

                            "عرف الدائنين الان"   ,
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
          )),
    ]);
  }
  Future<String?> addCreditors(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    TextEditingController searchusercontroller = TextEditingController();
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);


    var itemVar='';

    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController max = TextEditingController();
    TextEditingController address = TextEditingController();

    var l = Provider.of<Language>(context, listen: false);


    int? selectedOption;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title:
                  Center(child: Text('تعريف الدائنين')),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('اسم الدائن'),
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
                        Text('العنوان'),
                        TextField(
                          textAlign: TextAlign.center,
                          controller: address,
                          decoration: InputDecoration(hintText: ""),
                        ),

                        SizedBox(height: 14,),
                        Text('الحد الأقصى المسموح به'),

                        TextField(
                          textAlign: TextAlign.center,
                          controller: max,
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
                      onPressed: () =>  SaveCreditors(context, name.text.toString()
                          , phone.text.toString(), max.text.toString()
                          , address.text.toString() )
                      ,
                    ),
                  ],
                );
              });
        });
  }

  SaveCreditors(BuildContext context,String name,String phone,
      String max
      ,String address) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();



    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('تعريف الدائنين'),
          content: Text(l.getLanguage() == "AR"
              ? 'اضافه الدائنين ...'
              : 'Add Creditors..'),
        ));





    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['phone'] = phone;
    map['max'] = max;
    map['dept'] = '0';
    map['coffeid'] =  Loginprovider.getcoffeeId().toString();
    map['address'] = address??'';
    map['action'] = 'insert';


    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://coffepoint.net/Api/addcreditor.php');

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

  UpdateCreditors(BuildContext context,String name,String phone,
      String max
      ,String address,String id) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();



    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('تعريف الدائنين'),
          content: Text(l.getLanguage() == "AR"
              ? 'اضافه الدائنين ...'
              : 'Add Creditors..'),
        ));





    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['phone'] = phone;
    map['max'] = max;
    map['dept'] = '0';
    map['coffeid'] =  Loginprovider.getcoffeeId().toString();
    map['address'] = address??'';
    map['action'] = 'update';
    map['id'] = id;


    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://coffepoint.net/Api/addcreditor.php');

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


  Future<List<CreditorsModel>> getcreditors(
      BuildContext c) async {
    Uri postsURL = Uri.parse('https://coffepoint.net/Api/getcreditors.php');
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

        List<CreditorsModel> Doctors = body
            .map((dynamic item) => CreditorsModel.fromJson(item),
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


  Future<String?> updatedialogCreditors(BuildContext context,String nametxt,String phonetxt,
      String maxtxt ,String addresstxt,String id) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    TextEditingController searchusercontroller = TextEditingController();
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);


    var itemVar='';

    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController max = TextEditingController();
    TextEditingController address = TextEditingController();

    name.text=nametxt;
    phone.text=phonetxt;
    max.text=maxtxt;
    address.text=addresstxt;

    var l = Provider.of<Language>(context, listen: false);


    int? selectedOption;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title:
                  Center(child: Text('تعريف الدائنين')),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('اسم الدائن'),
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
                        Text('العنوان'),
                        TextField(
                          textAlign: TextAlign.center,
                          controller: address,
                          decoration: InputDecoration(hintText: ""),
                        ),

                        SizedBox(height: 14,),
                        Text('الحد الأقصى المسموح به'),

                        TextField(
                          textAlign: TextAlign.center,
                          controller: max,
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
                      onPressed: () =>  UpdateCreditors(context, name.text.toString()
                          , phone.text.toString(), max.text.toString()
                          , address.text.toString() ,id)
                      ,
                    ),
                  ],
                );
              });
        });
  }



  DeleteCreditors(BuildContext context,String id) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();



    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('حذف الدائنين'),
          content: Text(l.getLanguage() == "AR"
              ? 'حذف الدائنين ...'
              : 'Add Creditors..'),
        ));





    var map = new Map<String, dynamic>();
    map['coffeid'] =  Loginprovider.getcoffeeId().toString();
    map['action'] = 'delete';
    map['id'] = id;


    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://coffepoint.net/Api/addcreditor.php');

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



}
