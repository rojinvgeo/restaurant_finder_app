import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../providers/restaurant_provider.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        actions: [
          IconButton(
            icon: Icon(
              provider.isFavorite(restaurant.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () => provider.toggleFavorite(restaurant),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("City: ${restaurant.city}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Address: ${restaurant.address}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(
              restaurant.closed ? "Closed" : "Open",
              style: TextStyle(
                fontSize: 18,
                color: restaurant.closed ? Colors.red : Colors.green,
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton.icon(
              icon: Icon(Icons.map),
              label: Text("Open in Maps"),
              onPressed: () {
                // you can implement maps later
              },
            )
          ],
        ),
      ),
    );
  }
}
