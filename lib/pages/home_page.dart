import 'package:flutter/material.dart';
import '../pages/app_theme.dart';
import '../widgets/promo_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste des catégories avec icônes associées
    final categories = [
      {'name': 'Smartphones', 'icon': Icons.smartphone},
      {'name': 'Chaussures', 'icon': Icons.shopping_bag},
      {'name': 'Électroménager', 'icon': Icons.kitchen},
      {'name': 'Réfrigérateurs', 'icon': Icons.ac_unit},
      {'name': 'Télévisions', 'icon': Icons.tv},
      {'name': 'Informatique', 'icon': Icons.computer},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/lukatout.jpg',
              height: 36,
            ),
            const SizedBox(width: 10),
            Text(
              'Lukatout',
              style: TextStyle(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              // Action de recherche à définir
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // PromoBanner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: PromoBanner(
                title: "Tendance Electro Ménager",
                buttonLabel: "Découvrir",
                imageUrl: 'https://picsum.photos/seed/promo/900/500',
                onTap: () {},
                promoText: "Flat 50% discount on your first order.",
                onBuyNow: () {},
              ),
            ),
          ),

          // Titre des catégories
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Catégories",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),

          // Section Catégories - Design amélioré
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.primary.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            category['icon'] as IconData,
                            color: AppTheme.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          category['name'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Titre des produits
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Produits Populaires",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Voir tout",
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Grille de produits
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // Données des produits (normalement viendraient d'une API)
                  final products = [
                    {
                      'name': 'Iphone 13 simple',
                      'location': 'Kinshasa',
                      'price': '200\$',
                      'image': 'https://picsum.photos/seed/iphone13/400/400',
                    },
                    {
                      'name': 'Air Force One',
                      'location': 'Lubumbashi',
                      'price': '30\$',
                      'image': 'https://picsum.photos/seed/airforce/400/400',
                    },
                    {
                      'name': 'Machine à laver',
                      'location': 'Kinshasa',
                      'price': '150\$',
                      'image': 'https://picsum.photos/seed/washingmachine/400/400',
                    },
                    {
                      'name': 'Réfrigérateur',
                      'location': 'Lubumbashi',
                      'price': '250\$',
                      'image': 'https://picsum.photos/seed/fridge/400/400',
                    },
                  ];

                  final product = products[index % products.length];

                  return ProductCard(product: product);
                },
                childCount: 4, // Nombre de produits à afficher
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, String> product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image du produit
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Stack(
              children: [
                Image.network(
                  product['image']!,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 90,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey),
                    );
                  },
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom du produit
                Text(
                  product['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Localisation avec icône
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        product['location']!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Prix
                Text(
                  product['price']!,
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}