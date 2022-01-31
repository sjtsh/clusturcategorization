import 'package:clustercategorization/Category/Category.dart';
import 'package:flutter/material.dart';

List<String> findSearchResults(String i) {
  List<String> searchedResults = [];
  categories.forEach((category) {
    category.toString().split(" ").forEach((word) {
      if(word.length>i.length){
        if (word.substring(0, i.length).toLowerCase() == i.toLowerCase()) {
          if(!searchedResults.contains(category)){
            searchedResults.add(category);
          }
        }
      }
    });
  });
  return searchedResults;
}
