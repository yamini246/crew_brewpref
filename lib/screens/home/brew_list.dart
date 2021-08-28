import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew_pref/models/brew.dart';
import 'package:crew_brew_pref/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>?>(context) ?? [];

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
