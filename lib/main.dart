import 'package:chat_app/views/home_screen/home.dart';
import 'package:chat_app/views/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'consts/conste.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
  );
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isUser = false;
  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        setState(() {
          isUser = false;
        });
      } else {
        setState(() {
          isUser = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  // Mosab Shabat.
  // Mosab Shabat.
  //Mosab

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: "mont"),
      debugShowCheckedModeBanner: false,
      home: isUser ? const HomeScreen() : ChatApp(),
      title: appname,
    );
  }
}
