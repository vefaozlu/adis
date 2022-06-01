import 'dart:convert';
import 'package:adis/model.dart';
import 'package:flutter/services.dart';

class Service {
  const Service();

  final String jsonPath = 'assets/icons.json';
  Future<List<Item>> fetchData() async {
    final String response = await rootBundle.loadString('assets/icon.json');
    final Map<String, dynamic> data = await json.decode(response);
    List<Item> items = [];
    data["items"].forEach((item) => items.add(Item.fromJson(item)));
    return items;
  }
}
