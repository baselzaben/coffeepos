
import 'dart:io';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';


class Globalvireables {

  static String base1="#138B79";
  static String base2="#EF996C";
  static String base3="#FFFFFF";



  static String basecolor="#3268BA";
  static String secondcolor="#B6D0E2";
  static String white="#F5F5F5";
  static String black="#191919";
  static String black2="#333334";
  static String grey="#707070";
  static String secondcolor2="#d0e8ee";



 static String connectIP="10.0.1.109:7075";
 // static String connectIP="poscoffeesystem.000webhostapp.com";


  static String loginAPI="http://"+Globalvireables.connectIP+"/api/loginController/login";
  static String NumofticketsURL="http://"+Globalvireables.connectIP+"/api/NumOfTicketsController/NumOfTickets";
  static String chartticketsURL="http://"+Globalvireables.connectIP+"/api/chartController/chart";
  static String ticketURL="http://"+Globalvireables.connectIP+"/api/TicketsDtlControler/TicketsDtl";
  static String DailyWorkURL="http://"+Globalvireables.connectIP+"/api/DailyworkDtlControler/DailyworkDtl";
  static String CloseTicketURL="http://"+Globalvireables.connectIP+"/api/CloseTicketController/CloseTicket";
  static String AddDailyWork="http://"+Globalvireables.connectIP+"/api/AddDailyWorkController/AddDailyWork";
  static String allusersURL="http://"+Globalvireables.connectIP+"/api/getallusersControler/getallusers";
  static String TransTicket="http://"+Globalvireables.connectIP+"/api/SendTicketController/SendTicket";
  static String customers="http://"+Globalvireables.connectIP+"/api/getallcustomersControler/getcustomers";
  static String getsystems="http://"+Globalvireables.connectIP+"/api/sycustController/sycust";



  //ticket information
  static String department="http://"+Globalvireables.connectIP+"/api/infoTDepartment/Department";
  static String classification="http://"+Globalvireables.connectIP+"/api/infoTclassification/tickeclassification";
  static String infoTtype="http://"+Globalvireables.connectIP+"/api/infoTtype/tickettype";
  static String infoTmax="http://"+Globalvireables.connectIP+"/api/infoTmax/maxticketid";
  static String infoTpriority="http://"+Globalvireables.connectIP+"/api/infoTpriority/priority";
  static String infoTsource="http://"+Globalvireables.connectIP+"/api/infoTsource/ticketsource";
  static String OpenTicketURL="http://"+Globalvireables.connectIP+"/api/OpenTicketController/OpenTicket";




  static String permTicket="http://"+Globalvireables.connectIP+"/api/ticketPermisionController/ticketPermision";
  static String permDaily="http://"+Globalvireables.connectIP+"/api/dailyworkPermisionController/dailyworkPermision";

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' :'tablet';
  }

  static String them1="#229954";
  static String them2="#2E86C1";
  static String them3="#8E44AD";
  static String them4="#2E4053";
  static String them5="#D35400";




}