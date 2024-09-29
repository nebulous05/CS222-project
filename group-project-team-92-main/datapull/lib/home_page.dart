import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:datapull/loading_page.dart';
import 'package:datapull/learn_more.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: const GalleryAccess(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GalleryAccess extends StatefulWidget {
  const GalleryAccess({Key? key}) : super(key: key);

  @override
  State<GalleryAccess> createState() => _GalleryAccessState();
}

class _GalleryAccessState extends State<GalleryAccess> {
  List<AssetEntity> assets = [];
  List<File> galleryImages = [];
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gallery CLNR',
          style: (TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          )),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () async {
                // List<List<File>> res =
                //    await groupImagesByDifference(galleryImages, 0.60);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoadingPage(galleryImages),
                  ),
                );
                // final result = await Navigator.push(
                //  context,
                //  MaterialPageRoute(builder: (context) => SecondPage(res)),
                //);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black26, width: 2),
                  ),
                ),
              ),
              child: const Text('CLNR Your Gallery',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
            ),
            const SizedBox(width: 30),
            ElevatedButton(
              onPressed: () {
                PhotoManager.requestPermissionExtend().then(
                  (PermissionState state) {
                    if (state.isAuth) {
                      _selectDate(context);
                    }
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black26, width: 2),
                  ),
                ),
              ),
              child: const Text('Select Date',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
            ),
          ]),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: galleryImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.file(
                  galleryImages[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              galleryImages.clear();
            });
          },
          child: const Icon(Icons.remove)),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            if (value == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LearnMorePage(),
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Learn More',
            ),
          ]),
    );
  }

  // Future<void> fetchGalleryImages(DateTime selectedDate) async {
  //   final picker = ImagePicker();
  //   final directory = await getApplicationDocumentsDirectory();
  //   final List<XFile> images = await picker.pickMultiImage();

  //   setState(() {
  //     galleryImages = images
  //         .map((img) => File(img.path))
  //         .where((img) => DateTime.fromMillisecondsSinceEpoch(
  //                 img.lastModifiedSync().millisecondsSinceEpoch)
  //             .isSameDate(selectedDate))
  //         .toList();
  //   });
  // }

  Future<void> fetchGalleryImages(DateTime selectedDate) async {
    if (assets.isEmpty) {
      assets = await PhotoManager.getAssetListRange(
        start: 0,
        end: 100000,
      );
    }

    galleryImages.clear();
    for (var i = 0; i < assets.length; i++) {
      File? file = await assets[i].file;
      if (file != null && selectedDate.isSameDate(assets[i].createDateTime)) {
        galleryImages.add(file);
      }
    }

    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      fetchGalleryImages(selectedDate!);
    }
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
