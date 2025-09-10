class Category {
  final String id;
  final String name;
  final String icon;
  final String description;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}

class Listing {
  final String id;
  final String title;
  final String description;
  final double price;
  final String categoryId;
  final String location;
  final String imageUrl;
  final DateTime createdAt;
  final String sellerId;
  final String sellerName;
  final bool isUrgent;

  const Listing({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.location,
    required this.imageUrl,
    required this.createdAt,
    required this.sellerId,
    required this.sellerName,
    this.isUrgent = false,
  });
}