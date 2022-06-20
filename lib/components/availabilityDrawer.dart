import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => new _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 350,
      child: Drawer(
        child: Container(
          color: const Color.fromRGBO(213, 233, 214, 1),
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: [
              const SizedBox(height: 50),
              Material(
                child: ListTile(
                  onTap: () {},
                  hoverColor: const Color.fromRGBO(213, 250, 214, 1),
                  enabled: true,
                  title: const Text(
                    'Available',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(0, 77, 64, 1)),
                  ),
                  leading: const Icon(Icons.circle, color: Colors.green),
                ),
              ),
              const SizedBox(height: 30),
              Material(
                child: ListTile(
                  onTap: () {},
                  hoverColor: const Color.fromRGBO(213, 250, 214, 1),
                  enabled: true,
                  leading: const Icon(
                    Icons.circle,
                    color: Colors.red,
                  ),
                  title: const Text(
                    'Busy',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 77, 64, 1), fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Material(
                child: ListTile(
                  hoverColor: const Color.fromRGBO(213, 250, 214, 1),
                  enabled: true,
                  onTap: () {},
                  leading: const Icon(
                    Icons.circle,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Invisible',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 77, 64, 1), fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
