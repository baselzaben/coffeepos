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

class DeptBook extends StatefulWidget {
  @override
  State<DeptBook> createState() => _NotificationsState();
}

class _NotificationsState extends State<DeptBook> {
  @override
  void initState() {
    super.initState();
  }


  var check = true;
  var check2 = false;
  TextEditingController dateinputC = TextEditingController();
  bool isSwitchedFT = false;


  @override
  void dispose() {
    super.dispose();
  }
var Dtype='0';
  var name='';
  var initdept='';
  var maxdept='';
  var id='';

  //TextEditingController name = TextEditingController();
  TextEditingController max = TextEditingController();
  TextEditingController SELECTContr = TextEditingController();
  var selectedpersionid='';


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
                  UpdateCreditorsDialog(context);
                },
              ),
            ),
          ),

          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(context,'دفتر الديون'
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
      child: SingleChildScrollView(
        child: Column(
          children: [
        
            Padding(
              padding: const EdgeInsets.all(8.0),
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
        

        
        
                SizedBox(
                  height:
                  MediaQuery.of(context)
                      .size
                      .height /
                      1.2,
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
                              v) =>
                                 double.parse(v.dept.toString())>0 ||double.parse(v.dept.toString())<0 ? Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {

                                          /*    showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Expanded(
                                                    child: AlertDialog(
                                                      title: Text(
                                                          LanguageProvider.Llanguage('تسديد'),
                                                          style: ArabicTextStyle(
                                                              arabicFont: ArabicFont.tajawal,
                                                              fontSize: 22 *
                                                                  unitHeightValue)),
                                                      content: Text(
                                                        LanguageProvider.Llanguage("txxt"),
                                                        style: ArabicTextStyle(
                                                            arabicFont: ArabicFont.tajawal,
                                                            fontSize:
                                                            14 * unitHeightValue),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          //  textColor: Colors.black,
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pushAndRemoveUntil(
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      LoginScreen(),
                                                                ),
                                                                    (Route<dynamic>
                                                                route) =>
                                                                false);
                                                          },
                                                          child: Text(
                                                            LanguageProvider.Llanguage('Logout'),
                                                            style: ArabicTextStyle(
                                                                arabicFont: ArabicFont.tajawal,
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
                                                            LanguageProvider.Llanguage('cancel'),
                                                            style: ArabicTextStyle(
                                                                arabicFont: ArabicFont.tajawal,
                                                                color: Colors.black87,
                                                                fontSize: 15 *
                                                                    unitHeightValue),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );*/



                                              //dateinputC.text = v.namea.toString();
                                             // userselected=v.id.toString();
                                            //  Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(0.0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width/1,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [

                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              child: Text(
                                                                textAlign: TextAlign.center,
                                                                v.dept.toString() + " JD ",
                                                                style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 20 * unitHeightValue, fontWeight: FontWeight.w600),
                                                              ),
                                                            ),
                                                          ),

                                                      Spacer(),

                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Column(children: [
                                                              Text(
                                                                textAlign: TextAlign.left,
                                                                v.name.toString(),
                                                                style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 18 * unitHeightValue, fontWeight: FontWeight.w400),
                                                              ),Text(
                                                                textAlign: TextAlign.left,
                                                                v.phone.toString(),
                                                                style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 18 * unitHeightValue, fontWeight: FontWeight.w400),
                                                              ),
                                                            ],),
                                                          ),



Container(
  width: MediaQuery.of(context).size.width/5,
  height: MediaQuery.of(context).size.width/5,
color: double.parse(v.dept.toString())>0 ?Colors.green:Colors.redAccent,
child: Center(child:
Text(
  textAlign: TextAlign.left,
  double.parse(v.dept.toString())>0 ?'لك':'عليك',
  style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.white, fontSize: 18 * unitHeightValue, fontWeight: FontWeight.w400),
),
  ),

)


                                                        ],
                                                      ),


                                                  /*    v.deptstate!='1'?Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: Container(
                                                          height: 35,
                                                          width:
                                                          MediaQuery.of(context).size.width / 4,
                                                          color: HexColor(Globalvireables.white),
                                                          child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                              primary:Colors.black45,
                                                            ),
                                                            child: Text(
                                                              'تسديد',
                                                              style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,
                                                                  color:
                                                                  HexColor(Globalvireables.white),
                                                                  fontSize: 14 * unitHeightValue),
                                                            ),
                                                            onPressed: () async {

                                                              doneDept(context,v.id.toString());
                                                            },
                                                          ),
                                                        ),
                                                      ):Container(
                                                        child: Text(
                                                          'تم السداد في تاريخ '+v.donedate.toString(),
                                                          style: ArabicTextStyle(
                                                              arabicFont: ArabicFont.tajawal,
                                                              color:
                                                              HexColor(Globalvireables.black),
                                                              fontSize: 14 * unitHeightValue),
                                                        ),
                                                      ),*/




                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ):Container())
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
            ),
          )),
    ]);
  }
  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nav[index]),);
    });
  }
  int selectedIndex = 1;

  final List<Widget> nav = [
    Home(),
    Home(),
    Home(),
  ];


  Future<String?> UpdateCreditorsDialog(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    TextEditingController searchusercontroller = TextEditingController();
    double unitHeightValue = MediaQuery
        .of(context)
        .size
        .height * 0.00122;
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);


    var itemVar = '';



    var l = Provider.of<Language>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);


    int? selectedOption;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title:
                  Center(child: Text('دفتر الديون')),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('اسم الدائن'),


                        SizedBox(
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: SELECTContr,
                            //editing controller of this TextField
                            decoration: InputDecoration(



                              contentPadding: EdgeInsets.only(
                                  top: 18, bottom: 18, right: 20, left: 20),
                              fillColor: Colors.transparent,
                              filled: true,
                              hintText:
                              '',
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
                                              2,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              1.3,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  child: Text(
                                                      LanguageProvider.Llanguage(
                                                          'الدائنين المعرفين'),
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
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    3.1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    1,
                                                child: FutureBuilder(
                                                  future: getcreditors(context),
                                                  builder: (BuildContext
                                                  context,
                                                      AsyncSnapshot<
                                                          List<
                                                              CreditorsModel>>
                                                      snapshot) {
                                                    if (snapshot.hasData) {
                                                      List<CreditorsModel>?
                                                      Visits =
                                                          snapshot.data;
                                                      return ListView(
                                                        physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                        //
                                                        children: Visits!
                                                            .map(
                                                                (CreditorsModel
                                                            v) =>
                                                                Card(
                                                                  child: Column(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          SELECTContr.text = v.name.toString();
                                                                          selectedpersionid=v.id.toString();
                                                                          initdept=v.dept.toString();
                                                                          maxdept=v.max.toString();
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child:
                                                                        Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: SizedBox(
                                                                              child: Row(
                                                                                children: [
                                                                                  Spacer(),
                                                                                  Container(
                                                                                    child: Text(
                                                                                      textAlign: TextAlign.right,
                                                                                      v.name.toString(),
                                                                                      style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 14 * unitHeightValue, fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                  ),
                                                                                  Spacer(),
                                                                                  Text(
                                                                                    v.phone.toString(),
                                                                                    style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 14 * unitHeightValue, fontWeight: FontWeight.w400),
                                                                                  ),
                                                                                  Spacer(),
                                                                                ],
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ],
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

                 
                  
                  SizedBox(height: 14,),

                  Text('المبلغ'),
                  TextField(
                  textAlign: TextAlign.center,
                  controller: max,
                  decoration: InputDecoration(
                  hintText: ""),
                          onTap: (){



                          },
                        ),
                        SizedBox(height: 14,),


                        Row(
                          children: [
                            Spacer(),
                            Container(
                              width: 50,
                              child: Checkbox(
                                  value: check,
                                  //set variable for value
                                  onChanged: (bool? value) async {
                                    setState(() {
                                      check2=check;
                                      check = !check;
                                    });
                                  }),
                            ),
                            Container(
                              width: 50,
                              child: Text(
                                  (
                                      "لك"),
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      12 * unitHeightValue)),
                            ),
                            Spacer(),
                            Container(
                              width: 50,
                              child: Checkbox(
                                  value: check2,
                                  //set variable for value
                                  onChanged: (bool? value) async {
                                    setState(() {
                                      check=check2;
                                      check2 = !check2;
                                    });
                                  }),
                            ),
                            Container(
                              width: 50,
                              child: Text(
                                  (
                                      "عليك"),
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      12 * unitHeightValue)),
                            ),
                            Spacer(),

                          ],
                        ),


                      ],
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text(LanguageProvider.Llanguage('cancel'),
                        style: TextStyle(color: Colors.black),),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      child: Text(LanguageProvider.Llanguage('save'),
                          style: TextStyle(color: Colors.black)),
                      onPressed: () =>
                          UpdateCreditors(context)
                      ,
                    ),
                  ],
                );
              });
        });
  }


  UpdateCreditors(BuildContext context) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    var total = '0.0';

    if (check)
      total = (double.parse(initdept ?? '0.0') + (double.parse(max.text)))
          .toString();
    else
      total =
          (double.parse(initdept ?? '0.0') - double.parse(max.text)).toString();

    if (double.parse(maxdept.toString()) < double.parse(total) && check) {

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text('دفتر الدين'),
                content: Text(l.getLanguage() == "AR"
                    ? 'لقد تجاوزت الحد الأقصى المسموح به لهذا الشخص وهو $maxdept دينار '
                    : 'You have exceeded the maximum limit allowed for this person'),
              ));

    }else{


    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text('تعريف الدائنين'),
              content: Text(l.getLanguage() == "AR"
                  ? 'اضافه الدائنين ...'
                  : 'Add Creditors..'),
            ));


    print("initdept : " + initdept.toString());


    var map = new Map<String, dynamic>();
    map['dept'] = total;
    map['coffeid'] = Loginprovider.getcoffeeId().toString();
    map['action'] = 'edit';
    map['id'] = selectedpersionid.toString();


    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/addcreditor.php');

      http.Response response = await http
          .post(apiUrl, body: map,).whenComplete(() => Navigator.pop(context));

      print("OUT   : " + response.body.toString());

      if (response.body.toString().contains('1S')) {
        Navigator.pop(context);


        setState(() {});


        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  content: Icon(
                    Icons.cloud_done_rounded, color: Colors.green, size: 55,),
                ));
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(l.Llanguage('addclasses')),
                  content: Text(l.Llanguage('anerror')),
                ));
      }
    } catch (e) {
      Navigator.pop(context);
      await showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
          title: new Text(l.Llanguage('addclasses')),
          content: Text(l.Llanguage('anerror') + e.toString()),
          actions: <Widget>[],
        ),
      );
    }
  }
  }


  Tasded(BuildContext context) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    var total = '0.0';




      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text('تعريف الدائنين'),
                content: Text(l.getLanguage() == "AR"
                    ? 'اضافه الدائنين ...'
                    : 'Add Creditors..'),
              ));


      print("initdept : " + initdept.toString());


      var map = new Map<String, dynamic>();
      map['dept'] = total;
      map['coffeid'] = Loginprovider.getcoffeeId().toString();
      map['action'] = 'edit';
      map['id'] = selectedpersionid.toString();


      print(map.toString() + " inputt");
      try {
        Uri apiUrl = Uri.parse('https://poscoffeesystem.000webhostapp.com/addcreditor.php');

        http.Response response = await http
            .post(apiUrl, body: map,).whenComplete(() => Navigator.pop(context));

        print("OUT   : " + response.body.toString());

        if (response.body.toString().contains('1S')) {
          Navigator.pop(context);


          setState(() {});


          showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    content: Icon(
                      Icons.cloud_done_rounded, color: Colors.green, size: 55,),
                  ));
        } else {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: Text(l.Llanguage('addclasses')),
                    content: Text(l.Llanguage('anerror')),
                  ));
        }
      } catch (e) {
        Navigator.pop(context);
        await showDialog(
          context: context,
          builder: (context) =>
          new AlertDialog(
            title: new Text(l.Llanguage('addclasses')),
            content: Text(l.Llanguage('anerror') + e.toString()),
            actions: <Widget>[],
          ),
        );
      }
  }



////////////////////////
  Future<List<CreditorsModel>> getcreditors(
      BuildContext c) async {
    Uri postsURL = Uri.parse('https://poscoffeesystem.000webhostapp.com/getcreditors.php');
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

  showallpersion(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    TextEditingController searchusercontroller = TextEditingController();
    double unitHeightValue = MediaQuery
        .of(context)
        .size
        .height * 0.00122;
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);


    var itemVar = '';



   // TextEditingController name = TextEditingController();
    TextEditingController max = TextEditingController();

    var l = Provider.of<Language>(context, listen: false);


    int? selectedOption;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title:
                  Center(child: Text('دفتر الديون')),
                  content: Container(
                    height: MediaQuery.of(context).size.height/2,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child:    SizedBox(

                        height: MediaQuery.of(context).size.height/2,
                        width: MediaQuery.of(context).size.width,

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
                                    v) =>
                               Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {

                                                initdept=v.dept.toString();

                                                name=v.name.toString();

                                              id=v.id.toString();
                                              setState(() {

                                              });
                                              updatescreen();
                                              Navigator.pop(context);
                                              updatescreen();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(0.0),
                                                child: SizedBox(
                                                    width: MediaQuery.of(context).size.width/1,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [

                                                            Text(
                                                              textAlign: TextAlign.left,
                                                              v.name.toString(),
                                                              style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 18 * unitHeightValue, fontWeight: FontWeight.w400),
                                                            )

                                                          ],
                                                        ),


                                                      ],
                                                    )),
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
                                  child:
                                  CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[

                  ],
                );
              });
        });
  }
  updatescreen(){
    setState(() {
  });}
}
