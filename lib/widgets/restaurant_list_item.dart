import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../providers/restaurant_provider.dart';

class RestaurantListItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantListItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantProvider>(context);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.orange.shade100,
          child: Text(
            restaurant.name[0],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          restaurant.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          restaurant.address,
          style: TextStyle(color: Colors.grey.shade700),
        ),

        // ⭐ UPDATED TRAILING: Rating + Favorite Button
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            Text(
              restaurant.rating.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),

            // ❤️ FAVORITE BUTTON
            IconButton(
              icon: Icon(
                provider.isFavorite(restaurant.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () => provider.toggleFavorite(restaurant.id),
            ),
          ],
        ),
      ),
    );
  }
}
