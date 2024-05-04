

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class noticebaord extends StatefulWidget {
  const noticebaord({super.key});

  @override
  State<noticebaord> createState() => _noticebaordState();
}

class _noticebaordState extends State<noticebaord> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(child: Image.asset("assets/cooming soon.png",)),
    );
  }
}
