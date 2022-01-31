import 'package:flutter/material.dart';

import '../Database.dart';



class SingleCategory extends StatelessWidget {

  final String item;
  final String selected;
  final Function _changeSelected;

  SingleCategory(this.item, this.selected, this._changeSelected);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(selected==item){
          _changeSelected("");
        }else{
          _changeSelected(item);
          currentItem = item;
        }
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: selected==item ? Colors.blue : Color(0xffE2E2E2),
          borderRadius: BorderRadius.circular(12),
        ),
        duration: Duration(milliseconds: 500),
        child: Text(
          item,
          style: TextStyle(
            color: selected==item ? Colors.white : Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
