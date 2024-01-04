import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phonebook/Screen/Home.dart';
import 'package:phonebook/Screen/addContactPage.dart';
import 'package:phonebook/auth/Login.dart';
import 'package:phonebook/auth/Signup.dart';
import 'package:phonebook/controller/auth.dart';
import 'package:phonebook/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.soraTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => CheckUserState(),
        '/home': (context) => Homepage(),
        '/signup': (context) => SignUp(),
        '/login': (context) => LoginPage(),
        '/add': (context) => AddContact()
      },
    );
  }
}

class CheckUserState extends StatefulWidget {
  const CheckUserState({super.key});

  @override
  State<CheckUserState> createState() => _CheckUserStateState();
}

class _CheckUserStateState extends State<CheckUserState> {
  @override
  void initState() {
    AuthService().isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
