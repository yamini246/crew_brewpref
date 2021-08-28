import 'package:crew_brew_pref/screens/authenticate/authenticate.dart';
import 'package:crew_brew_pref/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew_pref/models/user_data.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserData?>(context);

    // return either Home or Authenticate widget
    if (user != null) {
      return Home();
    } else {
      return Authenticate();
    }
  }
}
