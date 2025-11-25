import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/restaurant.dart';
import '../services/api_service.dart';

class RestaurantProvider extends ChangeNotifier {
  List<Restaurant> restaurants = [];
  List<Restaurant> filtered = [];

  final Box favBox = Hive.box('favorites'); // Hive favorites box

  // -----------------------------
  // LOAD RESTAURANTS
  // -----------------------------
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

  // -----------------------------
  // SEARCH FUNCTION
  // -----------------------------
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

  // -----------------------------
  // FAVORITE FUNCTIONS
  // -----------------------------

  bool isFavorite(int id) {
    return favBox.get(id.toString(), defaultValue: false);
  }

  void toggleFavorite(Restaurant r) {
    final key = r.id.toString();

    if (isFavorite(r.id)) {
      favBox.delete(key);
    } else {
      favBox.put(key, true);
    }

    notifyListeners();
  }

  List<Restaurant> get favoriteRestaurants {
    return restaurants.where((r) => isFavorite(r.id)).toList();
  }
}
