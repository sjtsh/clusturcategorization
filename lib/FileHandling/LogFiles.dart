import 'dart:io';

import 'package:flutter/cupertino.dart';

String path = "";
File file = File(path);
String content = await file.readAsString();

class LogStorage {

  String pathPrime;
  LogStorage(this.pathPrime);

  Future<String> get _localPath async {
    final directory = Directory(pathPrime);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path\\logFile.txt');
  }

  Future<String> readLog() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<bool> readCompleted() async{
    try{
      List list;
      bool result = false;
      final file = await _localFile;
      final contents = await file.readAsString();
      list = contents.split("\n");
      for(String i in list){
        if(i=="COMPLETED"){
          result = true;
        }
      }
      return result;
    }catch(e){
      return false;
    }
  }

  addLog(String content) async {
    final file = await _localFile;
    // Write the file
    String existingContent = await readLog();
    return file.writeAsString(existingContent + "\n" + content);
  }
}
