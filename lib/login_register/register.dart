import 'package:durga_pooja/shared_resources/authenticate.dart';
import 'package:durga_pooja/shared_resources/loading.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function changeScreen;
  RegisterPage({this.changeScreen});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email;
  String _password;
  final Authenticate authenticate = Authenticate();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightBlue[200],
              elevation: 0.0,
            ),
            body: Container(
              color: Colors.lightBlue[200],
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        "Pooja",
                        style: TextStyle(
                          fontSize: 55.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "app",
                        style: TextStyle(
                          fontSize: 55.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                      ),
                      validator: (val) {
                        String ans;
                        if (val.isEmpty) {
                          ans = "Please type in your email";
                        }
                        return ans;
                      },
                      onSaved: (val) => _email = val,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                      ),
                      validator: (val) {
                        String ans;
                        if (val.length < 5) {
                          ans = "Your password is less than 5 characters long";
                        }
                        return ans;
                      },
                      onSaved: (val) => _password = val,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: Colors.white,
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        final formState = _formKey.currentState;
                        if (formState.validate()) {
                          formState.save();
                          dynamic res =
                              authenticate.register(_password, _email);
                          if (res == null) {
                            setState(() {
                              error = "Please supply a valid email or password";
                              loading = false;
                            });
                          } else {
                            setState(() {
                              error = res;
                            });
                          }
                        }
                      },
                      child: Text("Sign up"),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red[800]),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      onPressed: () {
                        widget.changeScreen();
                      },
                      child: Text("Already have an account?"),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
