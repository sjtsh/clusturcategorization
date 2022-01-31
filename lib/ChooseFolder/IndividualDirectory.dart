import 'package:clustercategorization/FileHandling/LogFiles.dart';
import 'package:clustercategorization/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_file_manager/flutter_file_manager.dart';

import '../Database.dart';

class IndividualDirectory extends StatefulWidget {
  final e;

  IndividualDirectory(this.e);

  @override
  _IndividualDirectoryState createState() => _IndividualDirectoryState();
}

class _IndividualDirectoryState extends State<IndividualDirectory> {
  bool completed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LogStorage logStorage = LogStorage(widget.e.path);
    logStorage.readCompleted().then((bool completed) {
      setState(() {
        this.completed = completed;
      });
      print(completed);
      print(this.completed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onPressed: () async {
        var files;
        var fm = FileManager(root: widget.e);
        files = await fm.filesTree(
          excludedPaths: [],
          extensions: [
            "jpg",
            "png",
          ],
        );
        accessibleFilePath = widget.e.path;
        print(accessibleFilePath);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen(
                files,
              );
            },
          ),
        );
      },
      child: AnimatedContainer(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        height: 100,
        width: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: RadialGradient(
            colors: completed
                ? [
                    Color(0xff2FA155),
                    Color(0xff2FA155),
                  ]
                : [
                    Colors.white,
                    Colors.white.withOpacity(0.5),
                  ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 2),
                blurRadius: 3)
          ],
          border: Border.all(color: Colors.black.withOpacity(0.1)),
        ),
        duration: Duration(milliseconds: 500),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.e.path
                .split("\\")
                .sublist(accessiblePath!.split("\\").length - 1,
                    widget.e.path.split("\\").length)
                .join("\\"),
            style: TextStyle(
              fontSize: 20,
              color: completed ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
