import 'package:flutter/material.dart';

class FindByAvailability extends StatefulWidget {
  const FindByAvailability({Key? key}) : super(key: key);

  @override
  State<FindByAvailability> createState() => _FindByAvailabilityState();
}

class _FindByAvailabilityState extends State<FindByAvailability> {
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
