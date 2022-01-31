import 'dart:io';


import 'package:path_provider/path_provider.dart';

import '../Database.dart';
import 'LogFiles.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/categories.txt');
  }

  Future<List> readList() async {
    try {
      final file = await _localFile;
      List list;
      // Read the file
      final contents = await file.readAsString();
      list = contents.substring(1, contents.length - 1).split(", ");
      for(String i in list){
        if(i==""||i==" "){
          list.remove(i);
        }
      }
      return list;
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  writeList(List list) async {
    final file = await _localFile;
    // Write the file
    LogStorage logStorage = LogStorage(accessibleFilePath!);
    logStorage.addLog("category has been updated to $list");
    return file.writeAsString(list.toString());
  }
}
