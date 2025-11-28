import 'package:product_feed_app/data/models/product_model.dart';
import 'package:product_feed_app/core/utils/logger.dart';

/// Supabase service handling database operations
/// Currently using mock data, but structured for easy Supabase integration
class SupabaseService {
  // In production, initialize Supabase client here:
  // final SupabaseClient _client = Supabase.instance.client;

  SupabaseService();

  /// Initialize Supabase (ready for real implementation)
  Future<void> initialize() async {
    try {
      Logger.info('Initializing Supabase...', tag: 'SupabaseService');

      // In production:
      // await Supabase.initialize(
      //   url: AppConstants.supabaseUrl,
      //   anonKey: AppConstants.supabaseAnonKey,
      // );

      Logger.success('Supabase initialized', tag: 'SupabaseService');
    } catch (e, stackTrace) {
      Logger.error(
        'Failed to initialize Supabase',
        tag: 'SupabaseService',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Get all products
  /// In production: await _client.from('products').select();
  Future<List<Product>> getProducts() async {
    // Mock data matching Supabase schema
    return _mockProducts;
  }

  /// Get product by ID
  /// In production: await _client.from('products').select().eq('id', id).single();
  Future<Product?> getProductById(String id) async {
    try {
      return _mockProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get products by category
  /// In production: await _client.from('products').select().eq('category', category);
  Future<List<Product>> getProductsByCategory(String category) async {
    return _mockProducts
        .where((product) => product.category == category)
        .toList();
  }

  /// Mock data representing what would come from Supabase
  /// This matches the Product model and Supabase table structure
  static final List<Product> _mockProducts = [
    Product(
      id: '1',
      title: 'Wireless Headphones',
      price: 89.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&h=500&fit=crop',
      description:
          'Premium wireless headphones with active noise cancellation. Crystal clear sound quality and 30-hour battery life. Perfect for music lovers and professionals.',
      productLink: 'https://www.apple.com/airpods',
      category: 'Electronics',
      rating: 4.5,
      reviewCount: 1250,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Product(
      id: '2',
      title: 'Smart Watch Pro',
      price: 299.99,
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&h=500&fit=crop',
      description:
          'Advanced smartwatch with health tracking, GPS, and cellular connectivity. Track your fitness goals and stay connected on the go.',
      productLink: 'https://www.apple.com/watch',
      category: 'Electronics',
      rating: 4.8,
      reviewCount: 2100,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Product(
      id: '3',
      title: 'Designer Backpack',
      price: 79.99,
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500&h=500&fit=crop',
      description:
          'Stylish and functional backpack with laptop compartment. Water-resistant material and ergonomic design for daily use.',
      productLink: 'https://www.nike.com',
      category: 'Fashion',
      rating: 4.3,
      reviewCount: 890,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Product(
      id: '4',
      title: 'Running Shoes',
      price: 129.99,
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&h=500&fit=crop',
      description:
          'High-performance running shoes with advanced cushioning technology. Lightweight design and superior grip for all terrains.',
      productLink: 'https://www.nike.com/running',
      category: 'Sports',
      rating: 4.7,
      reviewCount: 3400,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Product(
      id: '5',
      title: 'Coffee Maker Deluxe',
      price: 149.99,
      imageUrl:
          'https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=500&h=500&fit=crop',
      description:
          'Professional-grade coffee maker with programmable settings. Brew perfect coffee every morning with one-touch operation.',
      productLink: 'https://www.nespresso.com',
      category: 'Home & Kitchen',
      rating: 4.6,
      reviewCount: 1680,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Product(
      id: '6',
      title: 'Yoga Mat Premium',
      price: 49.99,
      imageUrl:
          'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=500&h=500&fit=crop',
      description:
          'Eco-friendly yoga mat with superior grip and cushioning. Non-slip surface and easy to clean. Includes carrying strap.',
      productLink: 'https://www.lululemon.com',
      category: 'Sports',
      rating: 4.4,
      reviewCount: 920,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
    Product(
      id: '7',
      title: 'Desk Lamp LED',
      price: 39.99,
      imageUrl:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&h=500&fit=crop',
      description:
          'Modern LED desk lamp with adjustable brightness and color temperature. Perfect for work or study. USB charging port included.',
      productLink: 'https://www.ikea.com',
      category: 'Home & Kitchen',
      rating: 4.2,
      reviewCount: 560,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Product(
      id: '8',
      title: 'Portable Speaker',
      price: 69.99,
      imageUrl:
          'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500&h=500&fit=crop',
      description:
          'Waterproof Bluetooth speaker with 360° sound. 20-hour battery life and durable design for outdoor adventures.',
      productLink: 'https://www.jbl.com',
      category: 'Electronics',
      rating: 4.6,
      reviewCount: 2800,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];
}
