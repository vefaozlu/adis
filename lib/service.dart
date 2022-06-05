import 'dart:convert';
import 'package:adis/models/model.dart';
import 'package:flutter/services.dart';

class Service {
  const Service();
  final String jsonPath = 'assets/icons.json';

  Future<List<Item>> fetchData(String categoryName) async {
    final String response = await rootBundle.loadString('assets/icon.json');
    final Map<String, dynamic> data = await json.decode(response);
    List<Item> items = [];
    data[categoryName].forEach((item) => items.add(Item.fromJson(item)));
    return items;
  }
}
