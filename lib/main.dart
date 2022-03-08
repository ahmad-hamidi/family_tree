import 'package:family_tree/config/routes.gr.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:family_tree/helpers/url_strategy_helper.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  setUrlWithoutHashTag();
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "XXzaSyABjs8K1km5bUyUYypDtOGaD_0wH-OFtTx",
          authDomain: "familytree-21bgX.firebaseapp.com",
          projectId: "familytree-21bgX",
          storageBucket: "familytree-21bgX.appspot.com",
          messagingSenderId: "124135894000",
          appId: "9:524112292031:web:9509585b62f0bda4c67xf9"
        ));
  } else {
    await Firebase.initializeApp();
  }

  initializeDateFormatting().then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Routes _route = Routes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Family Tree",
      routeInformationParser: _route.defaultRouteParser(),
      routerDelegate: _route.delegate(),
    );
  }
}
