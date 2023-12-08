import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

// void untuk profile
void _showProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Profile'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                'images/agita.jpg',
                width: 100,
              ),
            ),
            const SizedBox(height: 10),
            Text('Nama : Agita Nurfadillah'),
            Text('NPM : 1214029'),
            Text('Kelas : 3B'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UTS',
          style: TextStyle(color: Colors.black), // Set text color to black
        ),
        backgroundColor: const Color.fromARGB(255, 64, 141, 177),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0), // Add padding
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'images/ulbi.png', // Replace with the correct path to your image file
                width: 200, // Set the desired width for the image
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Selamat Datang di ULBI',
            style: TextStyle(fontSize: 23),
          ),
          const SizedBox(height: 10),
          const Text(
            'Asessment Pemrograman IV',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showProfileDialog(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: const Text('Profile'),
          ),
        ],
      ),
    );
  }
}
