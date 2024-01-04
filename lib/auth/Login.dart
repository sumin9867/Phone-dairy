import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phonebook/Screen/Home.dart';
import 'package:phonebook/controller/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'SignUp',
            style: GoogleFonts.sora(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: TextFormField(
                validator: (value) =>
                    value!.isEmpty ? "Email shouldn't be Empty" : null,
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text("Email"))),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: TextFormField(
                validator: (value) => value!.length < 8
                    ? "Password should be more than 8 character"
                    : null,
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text("Password"))),
          ),
          SizedBox(
              child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      AuthService()
                          .loginWithEmail(
                              _emailController.text, _passwordController.text)
                          .then((value) {
                        if (value == "Login Successful") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Login Sucessfully')));
                          Navigator.pushReplacementNamed(context, "/home");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            value,
                            style: TextStyle(backgroundColor: Colors.red),
                          )));
                        }
                      });
                    }
                    ;
                  },
                  child: Text("lOGIN"))),
          SizedBox(
            child: Text('OR'),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            child: OutlinedButton(
                onPressed: () {
                  AuthService().continueWithGoogle().then((value) {
                    if (value == "Google Login Successful") {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('GoogleLogin Sucessfully')));
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => Homepage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        value,
                        style: TextStyle(backgroundColor: Colors.red),
                      )));
                    }
                  });
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset("images/google.png"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.09,
                  ),
                  Text('Continue with Google')
                ])),
          ),
          Row(
            children: [
              Text("Dont have an acount"),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text("Sign Up"))
            ],
          )
        ]),
      ),
    );
  }
}
