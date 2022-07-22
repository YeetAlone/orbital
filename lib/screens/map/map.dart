import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:geolocator_android/geolocator_android.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  void getLocationPermission() async {
    await Geolocator.requestPermission();
  }

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Position? _position;
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

  void _getCurrentLocation() async {
    GeolocatorAndroid.registerWith();
    await Geolocator.requestPermission();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    devtools.log(serviceEnabled.toString());
    if (!serviceEnabled) {}
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    devtools.log(position.toString());
    int locationPos = -1;
    for (int i = 0; i < buildings.length; i++) {
      double distanceInMeters = Geolocator.distanceBetween(position.latitude,
          position.longitude, buildings[i][1], buildings[i][2]);
      //devtools.log(buildings[i][0] + " " + distanceInMeters.toString());
      if (distanceInMeters < buildings[i][3]) {
        locationPos = i;
        //devtools.log("min is " + buildings[i][0]);
      }
    }

    setState(() {
      _position = position;
      //devtools.log(locationPos.toString());
      if (locationPos > -1) {
        location = buildings[locationPos][0];
      } else {
        location = "Not in any building currently";
      }
    });
  }

  showMessage(String message, BuildContext context) {
    showMenu(
        context: context,
        position: const RelativeRect.fromLTRB(300, 300, 300, 300),
        items: <PopupMenuEntry>[
          PopupMenuItem(
              child: _position != null
                  ? Text(_position.toString())
                  : const Text(
                      "No data regarding your location. Please allow location"))
        ]);
  }

  Offset offset = Offset.zero;
  final transController = TransformationController();
  late TapDownDetails doubleTapDetails;

  handleDoubleTapDown(TapDownDetails details) {
    doubleTapDetails = details;
  }

  handleDoubleTap() {
    if (transController.value != Matrix4.identity()) {
      transController.value = Matrix4.identity();
    } else {
      final position = doubleTapDetails.localPosition;
      transController.value = Matrix4.identity()
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(0, 77, 64, 1),
          elevation: 0.0,
          title: const Text("MAP"),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  GeolocatorAndroid.registerWith();
                  _getCurrentLocation();
                  showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(300, 150, 300, 300),
                      items: <PopupMenuEntry>[
                        PopupMenuItem(
                            child: _position != null
                                ? Text(location)
                                : const Text(
                                    "No data regarding your location. Please allow location on your device or wait and retry"))
                      ]);
                },
                child: const Text("Click to see current location")),
            const Text(
              "Double tap on map to zoom in and see the buildings in detail. To find a colleague by building, go to search page",
              style: TextStyle(fontSize: 8),
            ),
            SizedBox(
              height: 590,
              child: Positioned(
                left: offset.dx,
                top: offset.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      offset = Offset(offset.dx + details.delta.dx,
                          offset.dy + details.delta.dy);
                    });
                  },
                  onDoubleTapDown: handleDoubleTapDown,
                  onDoubleTap: handleDoubleTap,
                  child: InteractiveViewer(
                    transformationController: transController,
                    child: Image.asset("assets/map.jpg",
                        width: 400, height: 690, fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
