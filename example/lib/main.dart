import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_package/flutter_package.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Package Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Parent(),
    );
  }
}

class Parent extends StatefulWidget {
  const Parent({Key? key}) : super(key: key);

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  String? name;

  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    //This timer will run setState every 5 seconds to act as if updating the value of name in this parent class.
    timer = Timer.periodic(
        const Duration(seconds: 5),
        (Timer t) => setState(() {
              name = "New Name ${t.tick}";
              log("Updated name to: $name");
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterPackage(
      name: name,
    );
  }
}
