import 'dart:io';

import 'package:clustercategorization/FileHandling/LogFiles.dart';
import 'package:excel/excel.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../Database.dart';

deleteLastFile(List files, SwiperController _swiperController) async {
  var bytes = File(accessibleExcelPath!).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);
  Sheet sheetObject = excel['Clustured'];
  String nameOfImage = sheetObject.rows.last[0];
  String nameOfCurrentCategory = sheetObject.rows.last[1];

  sheetObject.removeRow(sheetObject.rows.length-1);
  print(nameOfCurrentCategory);
  excel.encode().then((onValue) {
    File("$accessibleExcelPath")
      ..createSync(recursive: true)
      ..writeAsBytesSync(onValue);
  });

  String directoryPath = accessibleFilePath!
          .split("\\")
          .sublist(0, accessibleFilePath!.split("\\").length - 2)
          .join("\\") +
      '\\$nameOfCurrentCategory';
  String toDelete = directoryPath + '\\' + nameOfImage;
  File(toDelete).delete(recursive: true);
  LogStorage logStorage = LogStorage(accessibleFilePath!);
  await logStorage.addLog(
      "$currentItem image from index $currentIndex in the location $toDelete was deleted ");
  print(
      "$currentItem image from index $currentIndex in the location $toDelete was deleted ");
}
