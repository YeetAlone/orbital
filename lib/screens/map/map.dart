import 'package:flutter/material.dart';
import 'package:building/components/app_bar.dart';
import 'dart:developer' as devtools show log;

class MapPage extends StatefulWidget {
  final String userAuthId;
  const MapPage({Key? key, required this.userAuthId}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  showMessage(String message, BuildContext context) {
    showMenu(
        context: context,
        position: const RelativeRect.fromLTRB(300, 300, 300, 300),
        items: <PopupMenuEntry>[PopupMenuItem(child: Text(message))]);
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
        body: Stack(
          children: [
            Positioned(
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
          ],
        ));
    ;
  }
}
