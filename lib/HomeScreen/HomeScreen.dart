import 'dart:io';

import 'package:clustercategorization/Category/Category.dart';
import 'package:clustercategorization/Category/FileToCategory.dart';
import 'package:clustercategorization/Components/DialogBox.dart';
import 'package:clustercategorization/Components/Footer.dart';
import 'package:clustercategorization/Components/Header.dart';
import 'package:clustercategorization/SliderCategory/Slider.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:screenshot/screenshot.dart';

import '../Database.dart';

class HomeScreen extends StatefulWidget {
  final List files;

  HomeScreen(this.files);

  //this will be the index that will be changed along with the slider and changes the index in the header
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  int clusturIndex = 0;

  bool isNextButtonDisabled = true;
  bool isBackButtonDisabled = true;

  final SwiperController _swiperController = SwiperController();
  ScreenshotController screenshotController = ScreenshotController();

  _changeIndicator(int index) {
    setState(() {
      this.index = index;
    });
  }

  _enableNextButton(bool status) {
    setState(() {
      isNextButtonDisabled = status;
    });
  }

  _enableBackButton(bool status) {
    setState(() {
      isBackButtonDisabled = status;
    });
  }

  refresh() {
    setState(() {});
  }

  void changeClusturIndicator() {
    setState(() {
      if (currentClusterCount == clusturCount - 1) {
        clusturIndex = 0;
        currentClusterCount = 0;
        clusturCount = 0;
        _enableBackButton(true);
        showDialog(
          context: context,
          builder: (_) =>
              DialogBox(
                widget.files,
                changeClusturIndicator,
                refresh,
              ),
        );
        _swiperController.next(animation: true);
      } else {
        currentClusterCount += 1;
        clusturIndex = currentClusterCount;
      }
      print(clusturIndex);
    });
  }

  void changeClusturIndicatorBack() {
    setState(() {
      currentClusterCount -= 1;
      clusturIndex = currentClusterCount;
    });
    if(currentClusterCount==0){
      _enableBackButton(true);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) =>
        showDialog(
          context: context,
          builder: (_) =>
              DialogBox(
                widget.files,
                changeClusturIndicator,
                refresh,
              ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Header(index, widget.files),
                    Container(
                      height: 50,
                      child: Text(
                        "Category ${currentClusterCount + 1} of $clusturCount",
                        style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SliderCategory(_changeIndicator, _swiperController,
                        widget.files, clusturIndex, screenshotController),
                    Footer(
                        _swiperController,
                        false,
                        isNextButtonDisabled,
                        isBackButtonDisabled,
                        _enableBackButton,
                        widget.files,
                        changeClusturIndicator,
                        changeClusturIndicatorBack,
                        screenshotController),
                  ],
                ),
              ),
            ),
          ),
          Category(_enableNextButton, _enableBackButton),
        ],
      ),
    );
  }
}
