import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:filesystem_picker/filesystem_picker.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_file_manager/flutter_file_manager.dart';

import '../Database.dart';
import 'DirectoryScreen.dart';

class ChooseFolder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var files, excelPath, dirs;
    List dirsWithFiles = [];
    return Scaffold(
      backgroundColor: Colors.white,

      //the complete icon is going to be centered
      body: Center(
        //the icon and the material button's layout has been set into column
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //the first aspect of the column is going to be icon for add
            Icon(
              Icons.add,
              size: 100,
              color: Colors.black.withOpacity(0.3),
            ),

            //this is added in replacement for the padding
            SizedBox(
              height: 40,
            ),

            //this is going to be the material button which will navigate the user into the home screen
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
              ),
              child: RawMaterialButton(
                onPressed: () async {
                  String? path = await FilesystemPicker.open(
                    title: 'Pick the folder with images',
                    context: context,
                    rootDirectory: Directory("C:\\Users\\Sajat\\Desktop"),
                    fsType: FilesystemType.folder,
                    folderIconColor: Colors.blueGrey,
                    fileTileSelectMode: FileTileSelectMode.wholeTile,
                  );
                  //_______________________________________________________
                  var fm = FileManager(root: Directory(path!));
                  dirs = await fm.dirsTree();
                  for (var dir in dirs) {
                    bool condition = false;
                    files =
                        await FileManager(root: Directory(dir.path)).filesTree(
                      excludedPaths: [],
                      extensions: ["png", "jpg"],
                    );
                    for (int i = 0; i < dir.path.split("\\").length; i++) {
                      if (dir.path.split("\\")[i] == "Clustured Image") {
                        condition = true;
                      }if (dir.path.split("\\")[i] == "Others") {
                        condition = true;
                      }if (dir.path.split("\\")[i] == "Confused") {
                        condition = true;
                      }
                    }
                    if (files.length != 0) {
                      if (condition) {
                        dirsWithFiles.add(dir);
                      }
                    }
                  }
                  try {
                    excelPath =
                    await FileManager(root: Directory(path)).filesTree(
                      extensions: ["xlsx"],
                    );
                    List aList = excelPath[0].path.split("\\");
                    aList.removeLast();
                    print("Our excel file is ${excelPath[0].path}");
                    accessibleExcelPath = excelPath[0].path;
                  } catch (e) {
                    var excel = Excel.createExcel();
                    Sheet sheetObject = excel['Clustured'];
                    var header1 =
                    sheetObject.cell(CellIndex.indexByString("A1"));
                    var header2 =
                    sheetObject.cell(CellIndex.indexByString("B1"));
                    CellStyle cellStyle =
                    CellStyle(backgroundColorHex: "#27AE60");
                    header1.value = "Name";
                    header2.value = "Category";
                    header1.style = cellStyle;
                    header2.style = cellStyle;
                    excel.encode().then((onValue) {
                      File("$path\\CategorySheet.xlsx")
                        ..createSync(recursive: true)
                        ..writeAsBytesSync(onValue);
                    });
                    print("Our excel file is $path\\CategorySheet.xlsx");
                    accessibleExcelPath = "$path\\CategorySheet.xlsx";
                  }
                  accessiblePath = path;
                  print(accessiblePath);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        // return HomeScreen(files,);
                        return DirectoryScreen(
                          dirsWithFiles,
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(
                    "Add Folder",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
