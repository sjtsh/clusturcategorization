import 'package:clustercategorization/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogContent extends StatefulWidget {
  final List files;
  final Function changeClusturIndicator;
  final Function refresh;
  DialogContent(this.files, this.changeClusturIndicator, this.refresh);

  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  final TextEditingController _textEditingCount = TextEditingController();

  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Image.file(
          widget.files[currentIndex],
          fit: BoxFit.contain,
        )),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xffE2E2E2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (String i) {
                      try {
                        if (1 < int.parse(_textEditingCount.text)) {
                          clusturCount = int.parse(_textEditingCount.text);
                          currentClusterCount = 0;
                          error = false;
                          Navigator.of(context).pop();
                          widget.changeClusturIndicator(int.parse(_textEditingCount.text));
                        } else {
                          setState(() {
                            error = true;
                            _textEditingCount.text = "";
                          });
                        }
                      } catch (e) {
                        setState(() {
                          error = true;
                          _textEditingCount.text = "";
                        });
                      }
                      print(_textEditingCount.text);
                      widget.refresh();
                    },
                    controller: _textEditingCount,
                    maxLines: 1,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: error
                          ? "Enter a number more than 1"
                          : "No. of Shops in the Image",
                      hintStyle: TextStyle(
                        color:
                            error ? Colors.red : Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                try {
                  if (1 < int.parse(_textEditingCount.text)) {
                    clusturCount = int.parse(_textEditingCount.text);
                    currentClusterCount = 0;
                    error = false;
                    Navigator.of(context).pop();
                    widget.changeClusturIndicator(int.parse(_textEditingCount.text));
                  } else {
                    setState(() {
                      error = true;
                      _textEditingCount.text = "";
                    });
                  }
                } catch (e) {
                  setState(() {
                    error = true;
                    _textEditingCount.text = "";
                  });
                }
                print(_textEditingCount.text);
                widget.refresh();
              },
              child: Container(
                width: 50,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
