import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../services/api_service.dart';

class RestaurantProvider extends ChangeNotifier {
  List<Restaurant> restaurants = [];
  List<Restaurant> filtered = [];

  Future<void> loadRestaurants() async {
    try {
      restaurants = await ApiService().fetchRestaurants();
      filtered = restaurants;
      notifyListeners();
    } catch (e) {
      print("ERR: $e");
      restaurants = [];
      filtered = [];
      notifyListeners();
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      filtered = restaurants;
    } else {
      filtered = restaurants
          .where((r) =>
              r.name.toLowerCase().contains(query.toLowerCase()) ||
              r.city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
