import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_feed_app/core/theme/app_theme.dart';
import 'package:product_feed_app/features/products/controllers/product_controller.dart';
import 'package:product_feed_app/features/products/presentation/screens/feed_screen.dart';
import 'package:product_feed_app/data/repositories/product_repository.dart';
import 'package:product_feed_app/services/supabase/supabase_service.dart';
import 'package:product_feed_app/core/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  Logger.info('Initializing Product Feed App...', tag: 'Main');

  // Initialize Supabase service
  final supabaseService = SupabaseService();
  await supabaseService.initialize();

  // Setup dependency injection
  final productRepository = ProductRepository(supabaseService);

  Logger.success('App initialized successfully', tag: 'Main');

  runApp(ProductFeedApp(productRepository: productRepository));
}

/// Main application widget
class ProductFeedApp extends StatelessWidget {
  final ProductRepository productRepository;

  const ProductFeedApp({
    super.key,
    required this.productRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Product Controller Provider
        ChangeNotifierProvider(
          create: (_) => ProductController(productRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Product Feed',
        debugShowCheckedModeBanner: false,
        
        // Theme Configuration
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        
        // Home Screen
        home: const FeedScreen(),
        
        // Navigation
        onGenerateRoute: (settings) {
          Logger.info('Navigating to: ${settings.name}', tag: 'Navigation');
          
          // Add custom routes here if needed
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => const FeedScreen());
            default:
              return null;
          }
        },
      ),
    );
  }
}
