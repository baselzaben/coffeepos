import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:arabic_font/arabic_font.dart';
import 'package:provider/provider.dart';

import '../HexaColor.dart';
import '../provider/Them.dart';
class Widgets {

  static Widget Appbar(BuildContext context,
  String title, double unitHeightValue,String lan, TextDirection direction) {
    var ThemP = Provider.of<Them>(context, listen: false);

    if(lan=="EN"){
    return Directionality(
      textDirection: direction,
      child: Container(

        color:Colors.transparent,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: [
            SizedBox(
              width: 4,
            ),
            Text(
              title,
              style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 21.5 * unitHeightValue),
            ),
            Spacer(),
            Icon(
              Icons.notifications,
              color: HexColor(ThemP.getcolor()),
              size: 33 * unitHeightValue,
            )
          ],
        ),
      ),
    );}else{
      return Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: [

            Spacer(),
            Text(
              title,
              style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 21.5 * unitHeightValue),
            ),
            SizedBox(
              width: 0,
            ),

           /* Transform.rotate(
              angle: 180 * math.pi / 180,
              child: IconButton(
                icon:  Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: HexColor(ThemP.getcolor()),
                  size: 30 * unitHeightValue,
                ),

                onPressed:(){  Navigator.pop(context);},
              ),
            ),
*/

          ],
        ),
      );
    }
  }
  static ShowLoaderDialog(BuildContext context, String title,String txt) {
    AlertDialog alert = AlertDialog(
      content: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width/1.3,
        height: MediaQuery.of(context).size.width/1.3,
        child: Column(
          children: [
            Center(
              child: Text(title,style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,color: Colors.black,fontWeight: FontWeight.w500,fontSize: 22),),
            ),
            Center(
              child: Text(txt,style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,color: Colors.black,fontWeight: FontWeight.w100,fontSize: 17),),
            ),


            Row(children: [


            ],)

          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


















}
