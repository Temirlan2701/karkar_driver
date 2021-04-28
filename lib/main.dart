
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/globalvariable.dart';
import 'package:rider_app/screens/loginpage.dart';
import 'dart:io';

import 'package:rider_app/screens/mainpage.dart';
import 'package:rider_app/screens/registrationpage.dart';
import 'package:rider_app/screens/vehicleinfo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
      googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
      gcmSenderID: '297855924061',
      databaseURL: 'https://geetaxi-41ac9-default-rtdb.firebaseio.com',
    )
        : const FirebaseOptions(
      googleAppID: '1:146240457350:android:9c0b4e264cde6243649f07',
      apiKey: 'AIzaSyDOXL_Kq6QrDQJiqJdZDpmlMCFu1O6AZRQ',
      databaseURL: 'https://karkartaxi-default-rtdb.firebaseio.com',
    ),
  );

  currentFirebaseUser = await FirebaseAuth.instance.currentUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        fontFamily: 'Brand-Regular',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: MainPage.id,
      routes: {
        MainPage.id: (context) => MainPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        VehicleInfoPage.id: (context) => VehicleInfoPage(),
        LoginPage.id: (context) =>LoginPage(),
      },
    );
  }
}
