import 'package:clustercategorization/Category/FileToCategory.dart';
import 'package:clustercategorization/FileHandling/Storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Database.dart';
import '../Search.dart';
import 'SingleCategory.dart';

List categories = [
  "99 Mart",
  "Arts & Crafts",
  "Auto Showroom",
  "Bakery",
  "Bank & Finance",
  "Banquet",
  "Chain Mart-A class",
  "Chain Mart-B class",
  "Chemist Shop",
  "Closed Shutter",
  "Clothing Store",
  "Confused",
  "Consultancy",
  "Cosmetic",
  "Cycle Shop",
  "Dairy",
  "Driving School",
  "Duplicate Screenshots",
  "Electronics",
  "Fitness Centre",
  "Flower Shop",
  "Food Suppliers",
  "Fruits Shop",
  "Furniture and Decor",
  "Futsal",
  "Gas Shop",
  "Gift Shop",
  "Groceries Store",
  "HOREKA",
  "Hair Salon",
  "Hardware Store",
  "Hardware Suppliers",
  "Hospital",
  "Hostel",
  "Industry",
  "Instrumental Shop",
  "Jewellery Shop",
  "Kitchen Wares",
  "Laundry",
  "Liquor Shop",
  "Mart",
  "Masala Shop",
  "Meat Shop",
  "Medical Suppliers",
  "Nursery",
  "Optical",
  "Other Business",
  "Others",
  "Masala Shop",
  "Meat Shop",
  "Medical Suppliers",
  "Nursery",
  "Optical",
  "Other Business",
  "Others",
  "Paint Shop",
  "Pet Shop",
  "Photo Studio",
  "Plant Shop",
  "Printing Press (Offset/Flex)",
  "Re-condition Shop",
  "School & College",
  "Shopping Mall",
  "Small Eateries",
  "Spa",
  "Stationery",
  "Sweets",
  "Tattoo Shop",
  "Travel Agency",
  "Water Suppliers",
  "Workshop",
];
List dynamicCategories = [];

class Category extends StatefulWidget {
  final Function _enableBackButton;
  final Storage storage = Storage();
  final Function _enableNextButton;
  Category(
    this._enableNextButton,
      this._enableBackButton,
  );

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isSearching = false;
  List<String> searchedResults = [];

  @override
  void initState() {
    widget.storage.readList().then((List value) {
      setState(() {
        dynamicCategories = value;
        categories.addAll(dynamicCategories);
        List temp = categories;
        categories = [];
        temp.forEach((element) {if(!categories.contains(element)){
        categories.add(element);
        }
        });
        categories.sort();
      });
    });

    super.initState();
  }

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController1 = TextEditingController();

  changeSelected(String item) {
    setState(() {
      currentItem = item;
      currentItem == ""
          ? widget._enableNextButton(true)
          : widget._enableNextButton(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    changeOutSelected = changeSelected;
    return Container(
      width: 300,
      color: Color(0xffF3F3F3),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(12),
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xffE2E2E2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (String i) {
                  bool condition = true;
                  if (i != "") {
                    for (String category in categories) {
                      if (category == i) {
                        condition = false;
                      }
                    }
                    if (condition) {
                      setState(() {
                        dynamicCategories.add(i);
                        categories.add(i);
                      });
                      widget.storage.writeList(dynamicCategories);
                    }
                  }
                  setState(() {
                    _textEditingController.text = "";
                  });
                },
                controller: _textEditingController,
                textCapitalization: TextCapitalization.words,
                maxLines: 1,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Add New Category",
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xffE2E2E2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (String i) {
                  if (findSearchResults(i).length == 0) {
                    setState(() {
                      isSearching = false;
                    });
                  } else {
                    setState(() {
                      isSearching = true;
                      searchedResults = findSearchResults(i);
                    });
                  }
                },
                controller: _textEditingController1,
                textCapitalization: TextCapitalization.words,
                maxLines: 1,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: isSearching
                  ? Wrap(
                      children: searchedResults
                          .map(
                            (item) => SingleCategory(
                              item,
                              currentItem,
                              changeSelected,
                            ),
                          )
                          .toList(),
                    )
                  : Wrap(
                      children: categories
                          .map(
                            (item) => SingleCategory(
                              item,
                              currentItem,
                              changeSelected,
                            ),
                          )
                          .toList(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
