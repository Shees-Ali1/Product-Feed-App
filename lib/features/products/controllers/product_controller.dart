import 'package:flutter/foundation.dart';
import 'package:product_feed_app/data/models/product_model.dart';
import 'package:product_feed_app/data/repositories/product_repository.dart';
import 'package:product_feed_app/core/utils/logger.dart';

/// State management controller for products using Provider
/// Handles loading states, data fetching, and error handling
class ProductController extends ChangeNotifier {
  final ProductRepository _repository;

  ProductController(this._repository);

  // State variables
  List<Product> _products = [];
  Product? _selectedProduct;
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'All';

  // Getters
  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  bool get hasError => _errorMessage != null;
  bool get hasProducts => _products.isNotEmpty;

  /// Filtered products based on selected category
  List<Product> get filteredProducts {
    if (_selectedCategory == 'All') {
      return _products;
    }
    return _products.where((p) => p.category == _selectedCategory).toList();
  }

  /// Get all unique categories from products
  List<String> get categories {
    final categorySet = _products.map((p) => p.category).toSet();
    return ['All', ...categorySet.toList()..sort()];
  }

  /// Fetch all products from repository
  Future<void> fetchProducts() async {
    try {
      _setLoading(true);
      _clearError();

      Logger.info('Fetching products...', tag: 'ProductController');

      _products = await _repository.fetchProducts();

      Logger.success(
        'Successfully loaded ${_products.length} products',
        tag: 'ProductController',
      );

      _setLoading(false);
    } catch (e, stackTrace) {
      _setError('Failed to load products. Please try again.');
      _setLoading(false);

      Logger.error(
        'Error fetching products',
        tag: 'ProductController',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Fetch single product by ID
  Future<void> fetchProductById(String id) async {
    try {
      Logger.info('Fetching product: $id', tag: 'ProductController');

      _selectedProduct = await _repository.fetchProductById(id);

      if (_selectedProduct != null) {
        Logger.success(
          'Product loaded: ${_selectedProduct!.title}',
          tag: 'ProductController',
        );
      }

      notifyListeners();
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching product',
        tag: 'ProductController',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Set selected product for detail view
  void selectProduct(Product product) {
    _selectedProduct = product;
    Logger.info('Selected product: ${product.title}', tag: 'ProductController');
    notifyListeners();
  }

  /// Clear selected product
  void clearSelectedProduct() {
    _selectedProduct = null;
    notifyListeners();
  }

  /// Set category filter
  void setCategory(String category) {
    _selectedCategory = category;
    Logger.info('Category changed to: $category', tag: 'ProductController');
    notifyListeners();
  }

  /// Refresh products (pull-to-refresh)
  Future<void> refreshProducts() async {
    Logger.info('Refreshing products...', tag: 'ProductController');
    await fetchProducts();
  }

  /// Retry loading products after error
  Future<void> retry() async {
    _clearError();
    await fetchProducts();
  }

  // Private helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
