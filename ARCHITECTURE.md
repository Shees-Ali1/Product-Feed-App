# Architecture Documentation

## Overview

This Flutter application follows **Clean Architecture** principles with a clear separation between data, business logic, and presentation layers. The architecture is designed to be scalable, maintainable, and testable.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────┐
│                   Presentation Layer                     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │
│  │   Screens   │  │   Widgets   │  │ Controllers │    │
│  └─────────────┘  └─────────────┘  └─────────────┘    │
└──────────────────────┬──────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│                   Business Logic                         │
│  ┌─────────────┐  ┌─────────────┐                      │
│  │ Repository  │  │   Provider  │                      │
│  └─────────────┘  └─────────────┘                      │
└──────────────────────┬──────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│                      Data Layer                          │
│  ┌─────────────┐  ┌─────────────┐                      │
│  │   Models    │  │  Services   │                      │
│  └─────────────┘  └─────────────┘                      │
└─────────────────────────────────────────────────────────┘
```

## Layer Breakdown

### 1. Core Layer (`lib/core/`)

**Purpose**: Shared utilities, constants, and configurations used across the app.

**Components**:
- **constants/**: App-wide constants (API URLs, UI values, timeouts)
- **theme/**: Material theme configuration with light/dark modes
- **utils/**: Utility classes (Logger, helpers)

**Philosophy**: 
- No business logic
- Pure utility functions
- Reusable across features

---

### 2. Data Layer (`lib/data/`)

**Purpose**: Data models and repository interfaces.

#### Models (`lib/data/models/`)
- **Product Model**: Represents product entity
- Includes JSON serialization/deserialization
- Matches Supabase schema structure
- Immutable with copyWith method

**Example**:
```dart
class Product {
  final String id;
  final String title;
  final double price;
  // ... other fields
  
  factory Product.fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
}
```

#### Repositories (`lib/data/repositories/`)
- **Product Repository**: Handles all product-related data operations
- Abstracts data source (Supabase) from business logic
- Provides clean API for controllers
- Error handling and logging

**Benefits**:
- Easy to swap data sources
- Testable (can mock repository)
- Single source of truth

---

### 3. Services Layer (`lib/services/`)

**Purpose**: External service integrations (APIs, databases, etc.)

#### Supabase Service (`lib/services/supabase/`)
- Initializes Supabase client
- Provides methods to interact with database
- Currently uses mock data
- Ready for real Supabase integration

**Structure**:
```dart
class SupabaseService {
  // Initialize Supabase
  Future<void> initialize() async { ... }
  
  // Get products (ready for real API)
  Future<List<Product>> getProducts() async {
    // In production: _client.from('products').select()
    return _mockProducts; // Current: mock data
  }
}
```

**Why Separate Service?**
- Repository doesn't know about Supabase implementation
- Easy to add other services (Firebase, REST API, etc.)
- Can cache or transform data before returning

---

### 4. Features Layer (`lib/features/`)

**Purpose**: Feature-specific code organized by domain.

#### Products Feature (`lib/features/products/`)

**Structure**:
```
products/
├── controllers/          # State management
├── presentation/
│   ├── screens/         # Full-screen widgets
│   └── widgets/         # Reusable components
```

##### Controllers (`controllers/`)
- **ProductController**: State management using Provider
- Manages product list, selected product, loading states
- Handles errors and retry logic
- Notifies listeners on state changes

**State Variables**:
```dart
- List<Product> _products      // All products
- Product? _selectedProduct     // Currently selected
- bool _isLoading               // Loading state
- String? _errorMessage         // Error state
- String _selectedCategory      // Category filter
```

**Methods**:
```dart
- fetchProducts()               // Load products
- refreshProducts()             // Pull-to-refresh
- selectProduct(product)        // Set selected
- setCategory(category)         // Filter by category
- retry()                       // Retry after error
```

##### Presentation Layer

**Screens** (`presentation/screens/`):
1. **FeedScreen**: 
   - Grid layout of products
   - Category filtering
   - Pull-to-refresh
   - Navigation to detail

2. **ProductDetailScreen**: 
   - Full product information
   - Hero animation from feed
   - Scrollable content
   - Buy button with WebView

3. **WebViewScreen**: 
   - In-app browser
   - Loading progress indicator
   - Navigation controls

**Widgets** (`presentation/widgets/`):
1. **ProductCard**: 
   - Reusable product card
   - Hero animation support
   - Image caching
   - Tap animation

2. **LoadingWidget**: 
   - Shimmer loading effect
   - Placeholder cards

3. **ErrorWidget**: 
   - Error display
   - Retry button
   - Empty states

---

## State Management

### Provider Pattern

**Why Provider?**
- Simple and lightweight
- Built-in to Flutter ecosystem
- Easy to understand
- Sufficient for this app's complexity

**Implementation**:

1. **Setup** (`main.dart`):
```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (_) => ProductController(repository),
    ),
  ],
  child: MaterialApp(...),
)
```

2. **Access State**:
```dart
// Read state (rebuilds on change)
Consumer<ProductController>(
  builder: (context, controller, child) {
    return Text(controller.products.length);
  },
)

// Read without rebuild
context.read<ProductController>().fetchProducts();
```

**Benefits**:
- Centralized state
- Automatic UI updates
- Easy testing
- No boilerplate

---

## Data Flow

### Example: Loading Products

```
1. User opens app
   ↓
2. FeedScreen calls fetchProducts()
   ↓
3. ProductController._setLoading(true)
   ↓
4. Controller calls Repository.fetchProducts()
   ↓
5. Repository calls SupabaseService.getProducts()
   ↓
6. Service returns mock/real data
   ↓
7. Repository returns List<Product>
   ↓
8. Controller._products = products
   ↓
9. Controller._setLoading(false)
   ↓
10. Controller.notifyListeners()
   ↓
11. UI rebuilds with products
```

### Example: Tapping a Product

```
1. User taps ProductCard
   ↓
2. onTap callback fired
   ↓
3. Controller.selectProduct(product)
   ↓
4. Controller._selectedProduct = product
   ↓
5. Navigate to ProductDetailScreen
   ↓
6. Hero animation starts
   ↓
7. Detail screen displays
```

---

## Key Design Decisions

### 1. Why Clean Architecture?
- **Scalability**: Easy to add features
- **Testability**: Can mock each layer
- **Maintainability**: Clear responsibilities
- **Team Collaboration**: Multiple developers can work independently

### 2. Why Provider over Bloc/Riverpod?
- **Simplicity**: Easier learning curve
- **Sufficient**: App complexity doesn't require heavier solution
- **Performance**: Fast enough for this use case
- **Bundle Size**: Smaller app size

### 3. Why Repository Pattern?
- **Abstraction**: UI doesn't know about data source
- **Flexibility**: Easy to switch from mock to real API
- **Testing**: Can inject mock repository
- **Single Responsibility**: Repository only handles data

### 4. Mock Data Structure
- **Matches Supabase Schema**: Zero changes needed for migration
- **Realistic**: Includes all fields a real API would have
- **Demonstrative**: Shows how data flows through layers

---

## Code Quality Standards

### Naming Conventions
- **Classes**: PascalCase (`ProductCard`, `ProductController`)
- **Files**: snake_case (`product_card.dart`)
- **Variables**: camelCase (`selectedProduct`)
- **Constants**: camelCase with const (`defaultPadding`)
- **Private**: Underscore prefix (`_products`, `_setLoading()`)

### Widget Structure
```dart
class MyWidget extends StatelessWidget {
  // 1. Constants
  static const double _padding = 16.0;
  
  // 2. Final fields
  final String title;
  final VoidCallback onTap;
  
  // 3. Constructor
  const MyWidget({
    super.key,
    required this.title,
    required this.onTap,
  });
  
  // 4. Build method
  @override
  Widget build(BuildContext context) { ... }
  
  // 5. Private helper methods
  void _handleTap() { ... }
}
```

### Error Handling
- Try-catch blocks in repository and controller
- User-friendly error messages
- Retry functionality
- Logging for debugging

### Performance Optimizations
- `const` constructors where possible
- `CachedNetworkImage` for images
- Lazy loading (GridView.builder)
- Hero animations for smooth transitions

---

## Testing Strategy

### Unit Tests (Future Implementation)
```dart
// Test controller
test('fetchProducts updates state correctly', () async {
  final mockRepo = MockProductRepository();
  final controller = ProductController(mockRepo);
  
  await controller.fetchProducts();
  
  expect(controller.products.length, 8);
  expect(controller.isLoading, false);
});
```

### Widget Tests
```dart
// Test ProductCard widget
testWidgets('ProductCard displays product info', (tester) async {
  await tester.pumpWidget(ProductCard(product: mockProduct));
  
  expect(find.text('Product Title'), findsOneWidget);
  expect(find.text('\$99.99'), findsOneWidget);
});
```

### Integration Tests
- Test full user flows
- Navigation between screens
- State management across screens

---

## Scalability Considerations

### Adding New Features

**Example: Adding User Authentication**

1. Create `auth` service in `lib/services/auth/`
2. Create `User` model in `lib/data/models/`
3. Create `AuthController` in a new feature folder
4. Add to Provider setup in `main.dart`
5. Screens consume AuthController

**Example: Adding Shopping Cart**

1. Create `cart` feature folder
2. Create `CartController` with add/remove logic
3. Create cart UI widgets
4. Connect to existing ProductController
5. Add persistence (local DB or Supabase)

### Performance at Scale

**Current**: Mock 8 products
**Production**: Thousands of products

**Solutions**:
1. **Pagination**: Load products in chunks
   ```dart
   Future<List<Product>> fetchProducts({
     int page = 1, 
     int limit = 20
   })
   ```

2. **Search**: Add search index in Supabase
3. **Caching**: Store products locally
4. **Image Optimization**: Use thumbnails in grid, full size in detail

---

## Migration to Real Supabase

### Step-by-Step

1. **Create Supabase Project**
   - Sign up at supabase.com
   - Create new project
   - Note URL and anon key

2. **Update Constants**
   ```dart
   // lib/core/constants/app_constants.dart
   static const String supabaseUrl = 'YOUR_URL';
   static const String supabaseAnonKey = 'YOUR_KEY';
   ```

3. **Create Database Table**
   ```sql
   CREATE TABLE products (
     id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
     title TEXT NOT NULL,
     price DECIMAL(10, 2) NOT NULL,
     -- ... other fields
   );
   ```

4. **Uncomment Supabase Code**
   ```dart
   // lib/services/supabase/supabase_service.dart
   
   // Initialize
   await Supabase.initialize(
     url: AppConstants.supabaseUrl,
     anonKey: AppConstants.supabaseAnonKey,
   );
   
   // Fetch data
   final response = await _client
     .from('products')
     .select();
   ```

5. **Test**: Run app, should load from Supabase

---

## Conclusion

This architecture provides:
- ✅ **Clean Separation**: Each layer has a single responsibility
- ✅ **Scalability**: Easy to add features without refactoring
- ✅ **Testability**: Can mock and test each layer independently
- ✅ **Maintainability**: Clear structure, easy to navigate
- ✅ **Production Ready**: Can handle real-world requirements

The code is structured to be professional, clean, and maintainable.

