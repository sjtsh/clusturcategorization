import 'dart:io';
import 'dart:typed_data';
import 'package:clustercategorization/Database.dart';
import 'package:clustercategorization/FileHandling/LogFiles.dart';
import 'package:clustercategorization/SliderCategory/Slider.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:screenshot/screenshot.dart';

import '../ChangeTime.dart';

fileToCategory(List files, SwiperController _swiperController,
    ScreenshotController screenshotController) async {
  String directoryPath = accessibleFilePath!
          .split("\\")
          .sublist(0, accessibleFilePath!.split("\\").length - 2)
          .join("\\") +
      '\\$currentItem';
  String toSave = directoryPath +
      '\\' +
      files[currentIndex]
          .path
          .split("\\")
          .last
          .substring(0, files[currentIndex].path.split("\\").last.length - 4) +
      "_${currentItem}_${currentClusterCount + 1}.png";
  // Map<PermissionGroup, PermissionStatus> permissions =
  // await PermissionHandler()
  //     .requestPermissions([PermissionGroup.storage]);

  //_______________________________________________________________

  await screenshotController.captureAndSave(
      toSave.split("\\").sublist(0, toSave.split("\\").length - 1).join("\\"),
      fileName: toSave.split("\\").last);

  //_______________________________________________________________

  LogStorage logStorage = LogStorage(accessibleFilePath!);
  await logStorage.addLog(
      "$currentItem image from index $currentIndex of folder ${accessibleFilePath!.split("\\").sublist(accessiblePath!.split("\\").length - 1, accessibleFilePath!.split("\\").length).join("\\")} has been saved to " +
          toSave);
  print(
      "$currentItem image from index $currentIndex of folder ${accessibleFilePath!.split("\\").sublist(accessiblePath!.split("\\").length - 1, accessibleFilePath!.split("\\").length).join("\\")} has been saved to" +
          toSave);
  searchExcelData(toSave.split("\\").last, _swiperController, files);
}

searchExcelData(
    String nameOfImage, SwiperController _swiperController, List files) {
  writeExcelData(
      nameOfImage, nameOfImage.split("_")[nameOfImage.split("_").length - 2]);
}

Function changeOutSelected = () {};

writeExcelData(String nameOfImage, String currentItemHere) {
  var bytes = File(accessibleExcelPath!).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);
  Sheet sheetObject = excel['Clustured'];
  sheetObject.appendRow([nameOfImage, currentItemHere]);
  excel.encode().then((onValue) {
    File("$accessibleExcelPath")
      ..createSync(recursive: true)
      ..writeAsBytesSync(onValue);
  });
}

class ImageData {
  String imageName;
  String category;

  ImageData(this.imageName, this.category);
}
