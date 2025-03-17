import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Container(
        color: Colors.brown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 300,
              height: 40,
              color: Colors.orangeAccent,
              alignment: Alignment.center,
              child: Text(
                'APP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(color: Colors.blue, width: 50, height: 50),
                Container(color: Colors.green, width: 50, height: 50),
                Container(color: Colors.yellow, width: 50, height: 50),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(color: Colors.red, width: 100, height: 100),
                Container(color: Colors.blue, width: 50, height: 50),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(color: Colors.blue, width: 100, height: 100),
                Container(color: Colors.red, width: 50, height: 50),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(color: Colors.yellow, width: 100, height: 100),
                Container(color: Colors.green, width: 50, height: 50),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(color: Colors.green, width: 50, height: 50),
                Container(color: Colors.yellow, width: 50, height: 50),
                Container(color: Colors.blue, width: 50, height: 50),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                print("Clicou");
              },
              child: Text("Ok"),
            ),
          ],
        ),
      ),
    ),
  );
}

// void main() {
//   runApp(
//     MaterialApp(
//       home: Stack(
//         alignment: AlignmentDirectional.center,
//         children: [
//           Container(color: Colors.yellow, width: 200, height: 200, ),
//           Container(color: Colors.blueGrey, width: 100, height: 100),
//         ],
//       ),
//     ),
//   );
// }

// void main() {
//   runApp(
//     MaterialApp(
//       home: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(color: Colors.blue, width: 200, height: 200, ),
//           Container(color: Colors.red, width: 100, height: 100),
//           Container(color: Colors.green, width: 50, height: 50),
//         ],
//       ),
//     ),
//   );
// }

// void main() {
//   runApp(
//     MaterialApp(
//       home: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(color: Colors.blue, width: 200, height: 200, ),
//           Container(color: Colors.red, width: 100, height: 100),
//           Container(color: Colors.green, width: 50, height: 50),
//         ],
//       ),
//     ),
//   );
// }
