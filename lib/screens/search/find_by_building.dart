import 'package:flutter/material.dart';

class FindByBuilding extends StatefulWidget {
  const FindByBuilding({Key? key}) : super(key: key);

  @override
  State<FindByBuilding> createState() => _FindByBuildingState();
}

class _FindByBuildingState extends State<FindByBuilding> {
  late final TextEditingController _search;

  @override
  void initState() {
    _search = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
