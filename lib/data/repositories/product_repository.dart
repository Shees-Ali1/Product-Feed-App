import 'package:product_feed_app/data/models/product_model.dart';
import 'package:product_feed_app/services/supabase/supabase_service.dart';
import 'package:product_feed_app/core/utils/logger.dart';

/// Repository handling product data operations
/// Acts as abstraction layer between data source and business logic
class ProductRepository {
  final SupabaseService _supabaseService;

  ProductRepository(this._supabaseService);

  /// Fetch all products
  /// In production, this would query Supabase
  Future<List<Product>> fetchProducts() async {
    try {
      Logger.info('Fetching products...', tag: 'ProductRepository');
      
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      // For now, use mock data from service
      final products = await _supabaseService.getProducts();
      
      Logger.success('Fetched ${products.length} products', tag: 'ProductRepository');
      return products;
    } catch (e, stackTrace) {
      Logger.error(
        'Failed to fetch products',
        tag: 'ProductRepository',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Fetch single product by ID
  Future<Product?> fetchProductById(String id) async {
    try {
      Logger.info('Fetching product with id: $id', tag: 'ProductRepository');
      
      await Future.delayed(const Duration(milliseconds: 500));
      
      final product = await _supabaseService.getProductById(id);
      
      if (product != null) {
        Logger.success('Product found: ${product.title}', tag: 'ProductRepository');
      }
      return product;
    } catch (e, stackTrace) {
      Logger.error(
        'Failed to fetch product',
        tag: 'ProductRepository',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Fetch products by category
  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      Logger.info('Fetching products for category: $category', tag: 'ProductRepository');
      
      await Future.delayed(const Duration(milliseconds: 600));
      
      final products = await _supabaseService.getProductsByCategory(category);
      
      Logger.success('Fetched ${products.length} products in $category', tag: 'ProductRepository');
      return products;
    } catch (e, stackTrace) {
      Logger.error(
        'Failed to fetch products by category',
        tag: 'ProductRepository',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

