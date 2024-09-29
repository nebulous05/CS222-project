import 'dart:io';
import 'package:image_compare/image_compare.dart';

Future<List<List<File>>> groupImagesByDifference(
    List<File> files) async {

    double tolerance = 0.325; //Input can only have 1 variable, change this as needed

  if (files.isEmpty) return [];
  List<List<File>> groupedFiles = [];

  // Initialize the first group with the first file
  groupedFiles.add([files.first]);

  // Asynchronously compare images and group them based on tolerance
  for (var file in files.skip(1)) {
    var foundGroup = false;

    // Use Future.wait to perform comparisons in parallel
    var comparisons = await Future.wait(groupedFiles
        .map((group) => _imagesWithinTolerance(file, group.first, tolerance)));

    for (var i = 0; i < comparisons.length; i++) {
      if (comparisons[i]) {
        groupedFiles[i].add(file);
        foundGroup = true;
        break;
      }
    }

    if (!foundGroup) {
      groupedFiles.add([file]);
    }
  }

  return groupedFiles;
}

Future<bool> _imagesWithinTolerance(
    File image1, File image2, double tolerance) async {
  var result = await comparator(image1, image2);
  return result <= tolerance;
}

Future<double> comparator(File imageFile1, File imageFile2) async {
  var result = await compareImages(
      src1: imageFile1,
      src2: imageFile2,
      algorithm: AverageHash());
  return result;
}

// void main() async {
//   // Provide file paths for the images to compare
//   File image1 = File('images/dog_1.jpg');
//   File image2 = File('images/dog_2.jpg');
//   File image3 = File('images/grass.jpg');
//   File image4 = File('images/parrot.jpg');
//   File image5 = File('images/tree.jpg');
//   List<File> files = [image1, image2, image3, image4, image5];

//   var output = await groupImagesByDifference(files);

//   for (int i = 0; i < output.length; i++) {
//     print('List #${i + 1}');
//     for (int j = 0; j < output[i].length; j++) {
//       print(output[i][j].toString());
//     }
//   }
// }
