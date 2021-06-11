import 'package:flutter/material.dart';
import 'package:quiz_app/models/user.dart';

import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:quiz_app/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
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

  signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await auth.signUpEmailAndPass(email, password).then((value) => {
            print("kkkkkkkkkkk777 $value"),
            if (value is Users)
              {
                print("kkkkkkkkkkk777 $value"),
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
              },
            setState(() {
              isLoading = false;
            })
          });
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
                          return val!.isEmpty ? "Enter Correct Emailid" : null;
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
                          signUp();
                        },
                        child: Container(
                            // padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            height: 50,
                            width: MediaQuery.of(context).size.width - 48,
                            child: Text("Sign up",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))),
                      ),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account ? ",
                              style: TextStyle(fontSize: 15.5)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                            child: Text("Sign In",
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
