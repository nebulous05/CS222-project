import 'package:flutter/material.dart';
import 'package:datapull/home_page.dart';
import 'dart:io';
import 'package:datapull/learn_more.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  // runApp(SecondPage());
}

class SecondPage extends StatefulWidget {
  final List<List<File>> imageLists;

  const SecondPage(this.imageLists, {super.key});

  @override
  _SecondPageState createState() => _SecondPageState(imageLists);
}

class _SecondPageState extends State<SecondPage> {
  List<List<File>> imageLists;

  _SecondPageState(this.imageLists);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grouping Results',
          style: (TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
        ),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: imageLists.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Group #${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    IconButton(
                      splashColor: Colors.red,
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Deleting Duplicates'),
                          content: const Text(
                              'Do you want to delete all duplicates?\n Only the first image will be saved!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Perform additional actions here
                                //print("User confirmed deletion");
                                deleteFilesFromGallery(imageLists[index]).then((_) {
                                  imageLists[index].length = 1;
                                  // Then close the dialog
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SecondPage(imageLists),
                                      ),
                                  );
                                });
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageLists[index].length,
                  itemBuilder: (context, subIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        imageLists[index][subIndex],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            if (value == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const GalleryAccess(),
                ),
              );
            } else if (value == 1) {
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

  Future<void> deleteFile(File file) async {
  try {
    if (await file.exists()) {
      await file.delete();
      //print('File deleted: ${file.path}');
    } else {
      //print('File does not exist: ${file.path}');
    }
  } catch (e) {
    //print('Error deleting file: $e');
  }
}

Future<void> deleteFilesFromGallery(List<File> files) async {
  if (await _requestPermission(Permission.manageExternalStorage)) {
    var directory = Directory('/storage/emulated/0/Pictures');

    for (final file in files.skip(1)) {
      final filePath = '${directory.path}/${file.path.split('/').last}';
      final fileToDelete = File(filePath);
      await deleteFile(fileToDelete);
    }
  } else {
    throw Exception("Deletion Failed due to no permissions");
  }
}

Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

}
