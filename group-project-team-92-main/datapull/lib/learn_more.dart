import 'package:flutter/material.dart';

class LearnMorePage extends StatefulWidget {
  const LearnMorePage({super.key});

  @override
  _LearnMorePageState createState() => _LearnMorePageState();
}

class _LearnMorePageState extends State<LearnMorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learn More',
          style: (TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          )),
        ),
        backgroundColor: Colors.purple,
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 20.0, top: 20.0),
        child: Text(
            'Our app will help you reclaim your precious storage by finding and grouping similar images that you can then browse through and delete, all in one place. \n \n With our app, the days of hunting through your gallery to make room for new memories will be over. \n \n Simply select your desired photos to group and press the button. Be patient as your images are being grouped and finally delete all unnecessary photos from your gallery!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
      ),
    );
  }
}
