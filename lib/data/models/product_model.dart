/// Product model representing a product entity
/// This structure matches what would be stored in Supabase
class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String description;
  final String? productLink;
  final String category;
  final double? rating;
  final int? reviewCount;
  final DateTime createdAt;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.productLink,
    required this.category,
    this.rating,
    this.reviewCount,
    required this.createdAt,
  });

  /// Factory constructor to create Product from JSON (Supabase response)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      description: json['description'] as String,
      productLink: json['product_link'] as String?,
      category: json['category'] as String,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      reviewCount: json['review_count'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// Convert Product to JSON for Supabase operations
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image_url': imageUrl,
      'description': description,
      'product_link': productLink,
      'category': category,
      'rating': rating,
      'review_count': reviewCount,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Create a copy with modified fields
  Product copyWith({
    String? id,
    String? title,
    double? price,
    String? imageUrl,
    String? description,
    String? productLink,
    String? category,
    double? rating,
    int? reviewCount,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      productLink: productLink ?? this.productLink,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, title: $title, price: \$$price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

