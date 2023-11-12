import 'dart:convert';
import 'dart:ui';
import 'package:coffeepos/provider/BillProvider.dart';
import 'package:coffeepos/provider/LoginProvider.dart';
import 'package:coffeepos/provider/Them.dart';
import 'package:coffeepos/provider/languageProvider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arabic_font/arabic_font.dart';
import 'package:http/http.dart' as http;

import 'GlobalVar.dart';
import 'HexaColor.dart';
import 'UI/LoginScreen.dart';

String language = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<Language>(create: (_) => Language()),
        ChangeNotifierProvider<Them>(create: (_) => Them()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<BillProvider>(create: (_) => BillProvider()),
        ChangeNotifierProvider<BillProvider>(create: (_) => BillProvider()),

      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(),
      )));
}

const notificationChannelId = 'background_test';
const notificationId = 424;
var ticketId = '';


final globalNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: globalNavigatorKey,
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'F'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var isMackOs;

class _MyHomePageState extends State<MyHomePage> {
  SetLanguage(BuildContext context) async {
    var language;
    SharedPreferences pref = await SharedPreferences.getInstance();
    language = pref.get('language') ?? 'AR';
    if (language == null || language.isEmpty) {
      language = 'AR';
    } else {
      language = 'AR';
    }
    pref.setString('language', language);
    Provider.of<Language>(context, listen: false).setLanguage(language);
    print(language + " laaan");
  }

  @override
  Widget build(BuildContext context) {
    isMackOs = Theme.of(context).platform == TargetPlatform.macOS;

    SetLanguage(context);
    return EasySplashScreen(
      backgroundImage: Image.asset(
        "assets/background2.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ).image,
      logoWidth: isMackOs
          ? MediaQuery.of(context).size.width / 10
          : MediaQuery.of(context).size.width / 2.5,
      loaderColor: HexColor(Globalvireables.basecolor),
      logo: Image.asset(
        "assets/logo.png",
      ),
      showLoader: true,
      title: Text(
        textAlign: TextAlign.center,
        'شريكك الاستراتيجي للنجاح\n' + 'Your Strategic partner to success',
        style: ArabicTextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 22,
          arabicFont: ArabicFont.tajawal,
        ),
      ),
      loadingText: Text(
        '',
        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
            color: HexColor(Globalvireables.basecolor)),
      ),
      navigator: LoginScreen(),
      durationInSeconds: 5,
    );
  }
}
