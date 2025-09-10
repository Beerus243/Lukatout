import 'package:flutter/material.dart';
import '../models/models.dart';
import '../data/sample_data.dart';
import '../widgets/listing_card.dart';
import 'listing_detail_screen.dart';

class CategoryListingsScreen extends StatefulWidget {
  final Category category;

  const CategoryListingsScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryListingsScreen> createState() => _CategoryListingsScreenState();
}

class _CategoryListingsScreenState extends State<CategoryListingsScreen> {
  List<Listing> listings = [];
  String sortBy = 'recent';

  @override
  void initState() {
    super.initState();
    listings = SampleData.getListingsByCategory(widget.category.id);
  }

  void _sortListings(String sortType) {
    setState(() {
      sortBy = sortType;
      switch (sortType) {
        case 'recent':
          listings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
        case 'price_low':
          listings.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'price_high':
          listings.sort((a, b) => b.price.compareTo(a.price));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF6900),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search in category
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: _sortListings,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'recent',
                child: Text('Plus récentes'),
              ),
              const PopupMenuItem(
                value: 'price_low',
                child: Text('Prix croissant'),
              ),
              const PopupMenuItem(
                value: 'price_high',
                child: Text('Prix décroissant'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Category header
          Container(
            width: double.infinity,
            color: Colors.grey[100],
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  widget.category.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.category.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.category.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Results count and sort indicator
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${listings.length} annonce${listings.length > 1 ? 's' : ''}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Triés par: ${_getSortLabel(sortBy)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Listings
          Expanded(
            child: listings.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Aucune annonce dans cette catégorie',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: listings.length,
                    itemBuilder: (context, index) {
                      final listing = listings[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ListingCard(
                          listing: listing,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ListingDetailScreen(
                                  listing: listing,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _getSortLabel(String sortType) {
    switch (sortType) {
      case 'recent':
        return 'Plus récentes';
      case 'price_low':
        return 'Prix croissant';
      case 'price_high':
        return 'Prix décroissant';
      default:
        return 'Plus récentes';
    }
  }
}