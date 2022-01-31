import 'package:clustercategorization/Category/FileToCategory.dart';
import 'package:clustercategorization/Category/deleteLastFile.dart';
import 'package:clustercategorization/FileHandling/LogFiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:screenshot/screenshot.dart';

import '../Database.dart';
import 'DialogBox.dart';

class Footer extends StatefulWidget {
  final SwiperController _swiperController;
  final bool isChangeButtonDisabled;
  final bool isNextButtonDisabled;
  final bool isBackButtonDisabled;
  final Function _enableBackButton;
  final List files;
  final Function changeClusturIndicator;
  final Function changeClusturIndicatorBack;
  final ScreenshotController screenshotController;

  final LogStorage logStorage = LogStorage(accessibleFilePath!);

  Footer(
      this._swiperController,
      this.isChangeButtonDisabled,
      this.isNextButtonDisabled,
      this.isBackButtonDisabled,
      this._enableBackButton,
      this.files,
      this.changeClusturIndicator,
      this.changeClusturIndicatorBack,
      this.screenshotController);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: double.infinity,
                color: widget.isBackButtonDisabled
                    ? Colors.white
                    : Colors.blueGrey,
                child: MaterialButton(
                  onPressed: () {
                    if (!widget.isBackButtonDisabled) {
                      deleteLastFile(widget.files, widget._swiperController);
                      LogStorage logStorage = LogStorage(accessibleFilePath!);
                      logStorage.addLog("WENT BACK");
                      changeOutSelected("");
                      widget.changeClusturIndicatorBack();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      Text(
                        "  Previous",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: double.infinity,
                color: widget.isNextButtonDisabled ? Colors.white : Colors.blue,
                child: MaterialButton(
                  onPressed: () {
                    if (!widget.isNextButtonDisabled) {
                      if (currentIndex == widget.files.length - 1 &&
                          currentClusterCount == clusturCount - 1) {
                        fileToCategory(widget.files, widget._swiperController,
                            widget.screenshotController);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Congratulations!! directory has been completed",
                            ),
                          ),
                        );
                        LogStorage logStorage = LogStorage(accessibleFilePath!);
                        logStorage.addLog("COMPLETED");
                      } else {
                        fileToCategory(widget.files, widget._swiperController,
                            widget.screenshotController);
                        widget.changeClusturIndicator();
                        changeOutSelected("");
                      }
                      widget._enableBackButton(false);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Next  ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
