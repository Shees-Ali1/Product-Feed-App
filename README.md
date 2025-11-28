# Product Feed App

A professional Flutter mobile application for product feeds with clean architecture, modern UI, and Supabase integration.

## 🎯 Features

- **Product Feed Screen**: Grid layout displaying product cards with images, titles, prices, and ratings
- **Product Detail View**: Complete product information with hero animations
- **In-App Browser**: WebView integration for external product links
- **Category Filtering**: Filter products by category with elegant chip UI
- **Pull-to-Refresh**: Refresh product feed with swipe gesture
- **State Management**: Provider pattern for scalable state management
- **Clean Architecture**: Modular folder structure with separation of concerns
- **Modern UI**: Beautiful, responsive design with shimmer loading effects
- **Supabase Ready**: Structured for easy Supabase integration (currently using mock data)

## 📱 Screenshots

The app features:
- Clean product grid with 2-column layout
- Smooth hero animations between screens
- Professional loading states with shimmer effects
- Error handling with retry functionality
- Category filter chips
- In-app browser for product links

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a clear separation of concerns:

```
lib/
├── core/                          # Core app-wide utilities
│   ├── constants/                 # App constants and configuration
│   │   └── app_constants.dart
│   ├── theme/                     # Theme configuration
│   │   └── app_theme.dart
│   └── utils/                     # Utility classes
│       └── logger.dart
│
├── data/                          # Data layer
│   ├── models/                    # Data models
│   │   └── product_model.dart
│   └── repositories/              # Repository implementations
│       └── product_repository.dart
│
├── services/                      # External services
│   └── supabase/                  # Supabase service layer
│       └── supabase_service.dart
│
├── features/                      # Feature modules
│   └── products/
│       ├── controllers/           # State management (Provider)
│       │   └── product_controller.dart
│       └── presentation/          # UI layer
│           ├── screens/           # Screen widgets
│           │   ├── feed_screen.dart
│           │   ├── product_detail_screen.dart
│           │   └── webview_screen.dart
│           └── widgets/           # Reusable widgets
│               ├── product_card.dart
│               ├── loading_widget.dart
│               └── error_widget.dart
│
└── main.dart                      # App entry point
```

### Architecture Layers

1. **Core Layer**: Contains app-wide constants, theme, and utilities
2. **Data Layer**: Models and repositories for data operations
3. **Services Layer**: External service integrations (Supabase)
4. **Features Layer**: Feature-specific code organized by domain
5. **Presentation Layer**: UI components (screens and widgets)

### Design Patterns Used

- **Repository Pattern**: Abstracts data sources from business logic
- **Provider Pattern**: State management and dependency injection
- **Observer Pattern**: UI updates based on state changes
- **Factory Pattern**: Model creation from JSON

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `^3.10.0`
- Dart SDK: `^3.10.0`
- iOS Simulator / Android Emulator / Physical Device

### Installation

1. **Navigate to the project directory**:
   ```bash
   cd product_feed_app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

   Or for specific platform:
   ```bash
   # iOS
   flutter run -d ios
   
   # Android
   flutter run -d android
   ```

### Running on Different Devices

- **List available devices**:
  ```bash
  flutter devices
  ```

- **Run on specific device**:
  ```bash
  flutter run -d <device-id>
  ```

## 📦 Dependencies

Key packages used in this project:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.1.1
  
  # Supabase
  supabase_flutter: ^2.3.4
  
  # In-App Browser
  url_launcher: ^6.2.5
  webview_flutter: ^4.7.0
  
  # UI & Utilities
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  google_fonts: ^6.2.1
```

## 🔧 Configuration

### Supabase Setup (For Production)

Currently, the app uses mock data. To integrate with real Supabase:

1. **Create a Supabase project** at [supabase.com](https://supabase.com)

2. **Update constants** in `lib/core/constants/app_constants.dart`:
   ```dart
   static const String supabaseUrl = 'YOUR_SUPABASE_URL';
   static const String supabaseAnonKey = 'YOUR_ANON_KEY';
   ```

3. **Create products table** in Supabase:
   ```sql
   CREATE TABLE products (
     id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
     title TEXT NOT NULL,
     price DECIMAL(10, 2) NOT NULL,
     image_url TEXT NOT NULL,
     description TEXT,
     product_link TEXT,
     category TEXT NOT NULL,
     rating DECIMAL(2, 1),
     review_count INTEGER,
     created_at TIMESTAMP DEFAULT NOW()
   );
   ```

4. **Uncomment Supabase code** in `lib/services/supabase/supabase_service.dart`

## 🎨 Customization

### Theme

Modify app theme in `lib/core/theme/app_theme.dart`:
- Colors
- Typography (Google Fonts)
- Component themes (buttons, cards, etc.)

### Constants

Adjust layout constants in `lib/core/constants/app_constants.dart`:
- Grid column count
- Spacing values
- Animation durations

## 📝 Code Quality

### Best Practices Implemented

✅ **Null Safety**: Full null safety compliance  
✅ **Const Constructors**: Used for better performance  
✅ **Separation of Concerns**: Clean architecture layers  
✅ **Reusable Widgets**: Modular, composable components  
✅ **Error Handling**: Complete error states and retry logic  
✅ **Loading States**: Shimmer effects and progress indicators  
✅ **Comments**: Well-documented code with explanations  
✅ **Logger**: Debug logging for development  
✅ **Type Safety**: Strong typing throughout

### Code Structure

- **Single Responsibility**: Each class has one clear purpose
- **DRY Principle**: Reusable components and utilities
- **SOLID Principles**: Followed for maintainable code
- **Naming Conventions**: Clear, descriptive names

## 🧪 Testing

To run tests (when implemented):

```bash
flutter test
```

## 📱 Platform Support

- ✅ **iOS**: Fully supported
- ✅ **Android**: Fully supported
- ⚠️ **Web**: WebView may have limitations
- ⚠️ **Desktop**: Basic support, may need adjustments


## 📖 Learning Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Supabase Flutter Docs](https://supabase.com/docs/guides/getting-started/quickstarts/flutter)
- [Provider Package](https://pub.dev/packages/provider)
- [Clean Architecture in Flutter](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## 🤝 Contributing

For improvements:
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a pull request

## 📄 License

This project is provided as-is.

## 📧 Contact

For questions or feedback about this project, please reach out.
# Product-Feed-App
