import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final String payload;
  const SecondScreen({Key? key, required this.payload}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(widget.payload),
      ),
    );
  }
}
