import 'package:crew_brew_pref/services/auth.dart';
import 'package:crew_brew_pref/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew_pref/shared/constants.dart';

class SignIn extends StatefulWidget {


  final Function toggleView;
  SignIn({ required this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Crew Brew Pref'),
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              style: TextButton.styleFrom(
                  primary: Colors.black
              ),
              label: Text('Register')
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val!.isEmpty ? 'Enter an email.' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val!.length < 6 ? 'Enter a password of length more than 6.' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink, // background
                    onPrimary: Colors.white, // foreground
                  ),
                    child: Text(
                      'Sign In',
                    style: TextStyle(color: Colors.white),
                    ),
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'Could not sign in with those credentials.';
                        loading = false;
                        });
                        }
                      }
                    }
                ),
                SizedBox(height: 15.0),
                Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 15.0)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
