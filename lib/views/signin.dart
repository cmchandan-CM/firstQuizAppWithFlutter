import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signup.dart';
import 'package:quiz_app/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  String errors = "";
  bool isLoading = false;
  AuthService auth = new AuthService();

  Future<void> _showMyDialog(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fill Correct Email Id and Password !',
              style: TextStyle(color: Colors.red)),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text('This is a demo alert dialog.'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await auth.signInEmailAndPass(email, password).then((value) => {
            if (value is Users)
              {
                print("kkkkkkkkkkk $value"),
                setState(() {
                  isLoading = false;
                }),
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()))
              }
            else
              {
                setState(() {
                  isLoading = false;
                }),
                _showMyDialog(value.toString())
              }
          });
      print("$isLoading  " + FirebaseAuth.instance.currentUser!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  // color: Colors.blue,
                  child: Column(
                    children: [
                      Spacer(),
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Enter Correct Email id" : null;
                        },
                        decoration: InputDecoration(hintText: "Email"),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Enter Correct Password" : null;
                        },
                        decoration: InputDecoration(hintText: "Password"),
                        onChanged: (val) {
                          password = val;
                        },
                      ),
                      SizedBox(height: 24),
                      GestureDetector(
                          onTap: () {
                            print("chandan");
                            signIn();
                          },
                          child:
                              blueButton(context: context, label: "Sign in")),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account ? ",
                              style: TextStyle(fontSize: 15.5)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text("Sign Up",
                                style: TextStyle(
                                    fontSize: 15.5,
                                    decoration: TextDecoration.underline)),
                          )
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
