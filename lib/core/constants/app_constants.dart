/// App-wide constants and configuration
class AppConstants {
  // App Info
  static const String appName = 'Product Feed';
  static const String appVersion = '1.0.0';

  // API & Supabase (Mock setup ready for real integration)
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key-here';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double cardBorderRadius = 12.0;
  static const double imageAspectRatio = 1.0;
  static const int gridCrossAxisCount = 2;
  static const double gridSpacing = 12.0;

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Network
  static const Duration apiTimeout = Duration(seconds: 30);
}

