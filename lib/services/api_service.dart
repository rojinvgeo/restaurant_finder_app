import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';

class ApiService {
  final String baseUrl = "https://openmensa.org/api/v2/canteens";

  Future<List<Restaurant>> fetchRestaurants() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      return data.map((e) => Restaurant.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load restaurants");
    }
  }
}
