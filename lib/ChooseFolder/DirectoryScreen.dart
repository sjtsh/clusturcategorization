import 'package:flutter/material.dart';

import 'ChooseFolder.dart';
import 'IndividualDirectory.dart';

class DirectoryScreen extends StatefulWidget {
  final List dirs;

  DirectoryScreen(this.dirs);

  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.blue,
        ),
        child: RawMaterialButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChooseFolder();
                },
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 10.0, left: 20, right: 20),
            child: Text(
              "Change",
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Wrap(
          children: widget.dirs
              .map(
                (e) => IndividualDirectory(e),
          )
              .toList(),
        ),
      ),
    );
  }
}
