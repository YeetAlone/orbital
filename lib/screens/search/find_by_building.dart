import 'package:flutter/material.dart';
import 'package:building/components/app_bar.dart';

class FindByBuilding extends StatefulWidget {
  const FindByBuilding({Key? key}) : super(key: key);

  @override
  State<FindByBuilding> createState() => _FindByBuildingState();
}

class _FindByBuildingState extends State<FindByBuilding> {
  List buildings = [
    "School of Medicine",
    "University Hall",
    "COM",
    "Engineering",
    "Science",
    "FASS",
    "Biz",
    "YIH",
    "SDE",
    "UTown",
    "PGPR",
    "I4",
    "I3",
    "CLB",
    "USC",
    "UHC",
    "Museum",
    "NUH"
  ];
  // late final TextEditingController _search;
  //
  // @override
  // void initState() {
  //   _search = TextEditingController();
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _search.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      screenAppBar("SEARCH BY BUILDING"),
    ]));
  }
}
