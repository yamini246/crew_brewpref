import 'package:crew_brew_pref/models/user_data.dart';
import 'package:crew_brew_pref/screens/home/settings_form.dart';
import 'package:crew_brew_pref/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew_pref/services/database.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew_pref/screens/home/brew_list.dart';
import 'package:crew_brew_pref/models/brew.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('Crew Brew Pref'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
              icon: Icon(Icons.person),
              style: TextButton.styleFrom(
                  primary: Colors.black
              ),
              label: Text('Logout'),
              onPressed: () async{
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.settings),
              style: TextButton.styleFrom(
                primary: Colors.black
              ),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover
              )
            ),
            child: BrewList()
        ),
      ),
    );
  }
}
