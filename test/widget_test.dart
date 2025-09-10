import 'package:flutter_test/flutter_test.dart';
import 'package:lukatout/main.dart';
import 'package:lukatout/data/sample_data.dart';

void main() {
  group('Lukatout App Tests', () {
    testWidgets('App should load without errors', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const LukatoutApp());

      // Verify that our app loads with the correct title
      expect(find.text('Lukatout'), findsOneWidget);
      expect(find.text('Trouvez tout ce dont vous avez besoin'), findsOneWidget);
      expect(find.text('Catégories'), findsOneWidget);
    });

    test('Sample data should contain categories and listings', () {
      // Test that sample data is properly initialized
      expect(SampleData.categories.length, equals(8));
      expect(SampleData.listings.length, greaterThan(0));
      
      // Test category data structure
      final firstCategory = SampleData.categories.first;
      expect(firstCategory.id, isNotEmpty);
      expect(firstCategory.name, isNotEmpty);
      expect(firstCategory.icon, isNotEmpty);
      
      // Test listing data structure
      final firstListing = SampleData.listings.first;
      expect(firstListing.id, isNotEmpty);
      expect(firstListing.title, isNotEmpty);
      expect(firstListing.price, greaterThan(0));
    });

    test('Helper functions should work correctly', () {
      // Test getting listings by category
      final vehicleListings = SampleData.getListingsByCategory('vehicles');
      expect(vehicleListings.length, greaterThanOrEqualTo(0));
      
      // Test getting category by ID
      final category = SampleData.getCategoryById('vehicles');
      expect(category, isNotNull);
      expect(category!.name, equals('Véhicules'));
      
      // Test getting listing by ID
      final listing = SampleData.getListingById('1');
      expect(listing, isNotNull);
    });
  });
}