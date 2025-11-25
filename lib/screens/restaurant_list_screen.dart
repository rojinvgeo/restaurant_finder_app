import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../screens/restaurant_detail_screen.dart';


class RestaurantListScreen extends StatefulWidget {
  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false).loadRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Finder"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by name or city…",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) =>
                  Provider.of<RestaurantProvider>(context, listen: false)
                      .search(value),
            ),
          ),

          Expanded(
            child: Consumer<RestaurantProvider>(
              builder: (_, provider, __) {
                if (provider.filtered.isEmpty) {
                  return Center(child: Text("No restaurants found"));
                }

                return ListView.builder(
                  itemCount: provider.filtered.length,
                  itemBuilder: (_, index) {
                    final r = provider.filtered[index];

                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(r.name[0]),
                      ),
                      title: Text(r.name),
                      subtitle: Text("${r.city} • ${r.address}"),
                      trailing: r.closed
                          ? Icon(Icons.close, color: Colors.red)
                          : Icon(Icons.check, color: Colors.green),
                          
                        onTap: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RestaurantDetailScreen(restaurant: r),
                            ),
                          );
                        },    
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
