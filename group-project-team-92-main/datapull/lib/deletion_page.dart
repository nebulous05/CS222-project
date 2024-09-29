/*

As shown on the Figma, we want to be routed to this page
from the grouping display page. The constructor for this page
take a specific List from our List<List<>> on the previous page.

*/

/// Flutter code sample for [AlertDialog].

// import 'package:flutter/material.dart';

// void main() => runApp(const AlertDialogExampleApp());

// class AlertDialogExampleApp extends StatelessWidget {
//   const AlertDialogExampleApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
//       home: Scaffold(
//         appBar: AppBar(title: const Text('AlertDialog Sample')),
//         body: const Center(
//           child: DialogExample(),
//         ),
//       ),
//     );
//   }
// }

// class DialogExample extends StatelessWidget {
//   const DialogExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       splashColor: Colors.red,
//       icon: const Icon(Icons.delete),
//       color: Colors.red,
//       onPressed: () => showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Deleting Duplicates'),
//           content: const Text('Do you want to delete all duplicates?\n Only the first image will be saved!'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'Cancel'),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Perform additional actions here
//                 print("User confirmed deletion");
                
//                 // Then close the dialog
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Yes'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
