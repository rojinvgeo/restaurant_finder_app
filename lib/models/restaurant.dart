class Restaurant {
  final int id;
  final String name;
  final String city;
  final String address;
  final bool closed;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.closed,
     required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Unknown",
      city: json['city'] ?? "",
      address: json['address'] ?? "",
      closed: json['closed'] ?? false,
      rating: (json['rating'] ?? 0).toDouble(), // 👈 FIX
    );
  }
}
