/*

Ideally, we want to be routed to this page immediately 
after a user presses the button labeled "CLNR Your Gallery".
This can be saved until we have finished the more important
parts.

*/

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:datapull/computation.dart';
import 'package:datapull/grouping-page.dart';

class LoadingPage extends StatefulWidget {
  final List<File> imageList;

  const LoadingPage(this.imageList, {super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState(imageList);
}

class _LoadingPageState extends State<LoadingPage> {
  List<File> imageList;
  bool _isLoading = true;

  _LoadingPageState(this.imageList);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final result = await compute(groupImagesByDifference, imageList);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SecondPage(result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Loading Your Results',
          style: (TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          )),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // Show loading indicator
            : Container(),
      ),
    );
  }
}
