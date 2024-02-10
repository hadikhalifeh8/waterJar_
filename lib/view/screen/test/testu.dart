// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool showContainerA = false;
//   bool showContainerB = false;

//   void toggleContainers(bool showA, bool showB) {
//     setState(() {
//       showContainerA = showA;
//       showContainerB = showB;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Button and Container Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Visibility(
//               visible: showContainerA,
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 color: Colors.blue,
//                 child: Text('Text A'),
//               ),
//             ),
//             Visibility(
//               visible: showContainerB,
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 color: Colors.green,
//                 child: Text('Text B'),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => toggleContainers(true, false),
//                   child: Text('Button A'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => toggleContainers(false, true),
//                   child: Text('Button B'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Text Form Example'),
        ),
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial text to "0"
    _controller.text = "0";
    // Add listener to the controller to handle changes
    _controller.addListener(_handleControllerChange);
  }

  void _handleControllerChange() {
    String text = _controller.text;
    // If the text is empty or "0", do nothing
    if (text.isEmpty || text == "0") {
      return;
    }
    // If the text starts with "0", remove it
    if (text.startsWith("0")) {
      _controller.text = text.substring(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Enter a number',
        ),
      ),
    );
  }
}