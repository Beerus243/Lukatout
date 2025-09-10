import '../models/models.dart';

class SampleData {
  static const List<Category> categories = [
    Category(
      id: 'vehicles',
      name: 'Véhicules',
      icon: '🚗',
      description: 'Voitures, motos, vélos...',
    ),
    Category(
      id: 'real_estate',
      name: 'Immobilier',
      icon: '🏠',
      description: 'Ventes, locations, colocations...',
    ),
    Category(
      id: 'fashion',
      name: 'Mode',
      icon: '👕',
      description: 'Vêtements, chaussures, accessoires...',
    ),
    Category(
      id: 'electronics',
      name: 'Multimédia',
      icon: '📱',
      description: 'Informatique, téléphones, consoles...',
    ),
    Category(
      id: 'home',
      name: 'Maison',
      icon: '🏡',
      description: 'Meubles, décoration, jardinage...',
    ),
    Category(
      id: 'leisure',
      name: 'Loisirs',
      icon: '🎮',
      description: 'Sports, jeux, livres, instruments...',
    ),
    Category(
      id: 'services',
      name: 'Services',
      icon: '🛠️',
      description: 'Aide à domicile, cours, événements...',
    ),
    Category(
      id: 'jobs',
      name: 'Emplois',
      icon: '💼',
      description: 'CDI, CDD, stages, freelance...',
    ),
  ];

  static final List<Listing> listings = [
    Listing(
      id: '1',
      title: 'iPhone 14 Pro Max 256GB',
      description: 'iPhone 14 Pro Max en excellent état, très peu utilisé. Acheté il y a 6 mois, encore sous garantie. Livré avec boîte et accessoires d\'origine.',
      price: 950.0,
      categoryId: 'electronics',
      location: 'Paris 15ème',
      imageUrl: 'https://via.placeholder.com/300x200/1E88E5/FFFFFF?text=iPhone+14+Pro',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      sellerId: 'user1',
      sellerName: 'Marie D.',
      isUrgent: true,
    ),
    Listing(
      id: '2',
      title: 'Canapé 3 places IKEA',
      description: 'Canapé 3 places IKEA modèle KIVIK, couleur gris clair. En très bon état, non fumeur, pas d\'animaux. Dimension: 228x95x83 cm.',
      price: 300.0,
      categoryId: 'home',
      location: 'Lyon 3ème',
      imageUrl: 'https://via.placeholder.com/300x200/4CAF50/FFFFFF?text=Canapé+IKEA',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      sellerId: 'user2',
      sellerName: 'Thomas L.',
    ),
    Listing(
      id: '3',
      title: 'Volkswagen Golf 7 TDI',
      description: 'Golf 7 TDI 110ch, année 2016, 85 000 km. Excellent état, révisions à jour, pneus neufs. Véhicule non fumeur.',
      price: 15500.0,
      categoryId: 'vehicles',
      location: 'Marseille',
      imageUrl: 'https://via.placeholder.com/300x200/FF5722/FFFFFF?text=VW+Golf',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      sellerId: 'user3',
      sellerName: 'Pierre M.',
    ),
    Listing(
      id: '4',
      title: 'Appartement T2 - 45m²',
      description: 'Bel appartement T2 de 45m² au 3ème étage avec ascenseur. Cuisine équipée, salle de bain rénovée, proche métro.',
      price: 800.0,
      categoryId: 'real_estate',
      location: 'Toulouse Centre',
      imageUrl: 'https://via.placeholder.com/300x200/9C27B0/FFFFFF?text=Appartement+T2',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      sellerId: 'user4',
      sellerName: 'Agence Immobilière',
    ),
    Listing(
      id: '5',
      title: 'Robe de soirée noire',
      description: 'Magnifique robe de soirée noire, taille 38, portée une seule fois. Parfaite pour un mariage ou une soirée chic.',
      price: 80.0,
      categoryId: 'fashion',
      location: 'Nice',
      imageUrl: 'https://via.placeholder.com/300x200/E91E63/FFFFFF?text=Robe+Soirée',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      sellerId: 'user5',
      sellerName: 'Sophie R.',
    ),
    Listing(
      id: '6',
      title: 'Console PlayStation 5',
      description: 'PlayStation 5 en parfait état avec 2 manettes et 3 jeux inclus (Spider-Man, FIFA 23, Call of Duty). Très peu utilisée.',
      price: 450.0,
      categoryId: 'leisure',
      location: 'Bordeaux',
      imageUrl: 'https://via.placeholder.com/300x200/2196F3/FFFFFF?text=PlayStation+5',
      createdAt: DateTime.now().subtract(const Duration(hours: 18)),
      sellerId: 'user6',
      sellerName: 'Alex B.',
      isUrgent: true,
    ),
  ];

  static List<Listing> getListingsByCategory(String categoryId) {
    return listings.where((listing) => listing.categoryId == categoryId).toList();
  }

  static Category? getCategoryById(String categoryId) {
    try {
      return categories.firstWhere((category) => category.id == categoryId);
    } catch (e) {
      return null;
    }
  }

  static Listing? getListingById(String listingId) {
    try {
      return listings.firstWhere((listing) => listing.id == listingId);
    } catch (e) {
      return null;
    }
  }
}