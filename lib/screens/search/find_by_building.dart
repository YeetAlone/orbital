import 'package:flutter/material.dart';
import 'package:building/components/app_bar.dart';

class FindByBuilding extends StatefulWidget {
  const FindByBuilding({Key? key}) : super(key: key);

  @override
  State<FindByBuilding> createState() => _FindByBuildingState();
}

class _FindByBuildingState extends State<FindByBuilding> {
  late String location;
  List buildings = [
    ["School of Medicine", 1.29591, 103.78233, 100.65],
    ["University Hall", 1.29713, 103.77765, 51.75],
    ["COM", 1.29518, 103.77417, 66.85],
    ["Engineering", 1.29892, 103.77158, 166.96],
    ["Science", 1.29623, 103.77988, 151.06],
    ["FASS", 1.29504, 103.77161, 187.3],
    ["Biz", 1.29359, 103.77460, 87.81],
    ["YIH", 1.29846, 103.77486, 90.48],
    ["SDE", 1.29717, 103.77064, 65.32],
    ["UTown", 1.30559, 103.77305, 168.83],
    ["PGPR", 1.29088, 103.78043, 108.86],
    ["I4", 1.29462, 103.77583, 48.20],
    ["I3", 1.29245, 103.77566, 64.94],
    ["CLB", 1.29672, 103.77353, 76.16],
    ["USC", 1.29976, 103.77536, 84.98],
    ["Museum", 1.30188, 103.77269, 75.20],
    ["NUH", 1.29387, 103.78342, 193.17]
  ];
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
    return Scaffold(
        body: ListView(children: [
      screenAppBar("SEARCH BY BUILDING"),
    ]));
  }
}
