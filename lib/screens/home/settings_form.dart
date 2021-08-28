import 'package:crew_brew_pref/models/user_data.dart';
import 'package:crew_brew_pref/services/database.dart';
import 'package:crew_brew_pref/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew_pref/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  // form values
  String? _currentName;
  String? _currentSugars;
  int?  _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserData?>(context);

    return StreamBuilder<UserDaeta>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserDaeta? userData = snapshot.data;

          return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) => val!.isEmpty ? 'Please enter a name.' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  // dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData!.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val.toString()),
                  ),
                  // slider
                  Slider(
                      min: 100,
                      max: 900,
                      divisions: 8,
                      value: (_currentStrength ?? userData!.strength).toDouble(),
                      activeColor: Colors.brown[_currentStrength ?? userData!.strength],
                      inactiveColor: Colors.brown[_currentStrength ?? userData!.strength],
                      onChanged: (val) => setState(() => _currentStrength = val.round())
                  ),
                  ElevatedButton(
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink[400], // background
                        onPrimary: Colors.white, // foreground
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                  )
                ],
              ),
            );
        } else {
          return  Loading();
        }

      }
    );
  }
}
