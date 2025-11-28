# Quick Setup Guide

This guide will help you get the Product Feed App running in under 5 minutes.

## Prerequisites Check

Before starting, ensure you have:

```bash
# Check Flutter installation
flutter --version

# Check Dart installation  
dart --version

# Check available devices
flutter devices
```

**Required versions:**
- Flutter: 3.10.0 or higher
- Dart: 3.10.0 or higher

## Installation Steps

### 1. Navigate to Project Directory

```bash
cd product_feed_app
```

### 2. Get Dependencies

```bash
flutter pub get
```

This will download all required packages.

### 3. Run the App

#### Option A: Using your preferred IDE

**VS Code:**
- Press `F5` or click "Run > Start Debugging"

**Android Studio:**
- Click the green "Run" button

#### Option B: Command Line

**iOS (macOS only):**
```bash
flutter run -d ios
```

**Android:**
```bash
flutter run -d android
```

**Chrome (Web):**
```bash
flutter run -d chrome
```

### 4. Wait for Build

First build takes 2-5 minutes. Subsequent builds are much faster.

## Troubleshooting

### Issue: "No devices available"

**Solution:**
```bash
# Start iOS Simulator (macOS)
open -a Simulator

# Or check connected devices
flutter devices
```

### Issue: "CocoaPods not installed" (iOS)

**Solution:**
```bash
sudo gem install cocoapods
cd ios
pod install
cd ..
flutter run
```

### Issue: Android licenses not accepted

**Solution:**
```bash
flutter doctor --android-licenses
```

### Issue: Build fails

**Solution:**
```bash
# Clean build
flutter clean

# Get dependencies again
flutter pub get

# Run
flutter run
```

## What to Expect

Once the app launches, you'll see:

1. **Product Feed Screen** with a grid of products
2. **Tap any product** to see details
3. **Pull down** to refresh
4. **Filter icon** (top right) to filter by category
5. **Buy Now button** on detail screen opens in-app browser

## Project Structure Overview

```
lib/
├── main.dart              ← App entry point
├── core/                  ← Constants, theme, utils
├── data/                  ← Models and repositories
├── services/              ← Supabase service (mock data)
├── features/
    └── products/
        ├── controllers/   ← State management
        └── presentation/  ← Screens and widgets
```

## Testing Features

### 1. Product Feed
- ✅ Grid layout with product cards
- ✅ Images load from Unsplash
- ✅ Shimmer loading effect
- ✅ Pull-to-refresh

### 2. Category Filtering
- ✅ Tap filter icon (top right)
- ✅ Select a category
- ✅ Products filter instantly

### 3. Product Details
- ✅ Tap any product card
- ✅ Hero animation from card to detail
- ✅ Scroll to see full description
- ✅ Rating and review count

### 4. In-App Browser
- ✅ Tap "Buy Now" button
- ✅ WebView opens with product link
- ✅ Loading progress bar
- ✅ Refresh button

## Next Steps

### Switch to Real Supabase Data

1. Create account at [supabase.com](https://supabase.com)
2. Create new project
3. Update `lib/core/constants/app_constants.dart`:
   ```dart
   static const String supabaseUrl = 'YOUR_SUPABASE_URL';
   static const String supabaseAnonKey = 'YOUR_ANON_KEY';
   ```
4. Create `products` table (SQL in README)
5. Uncomment Supabase code in `lib/services/supabase/supabase_service.dart`

### Customize Theme

Edit `lib/core/theme/app_theme.dart`:
```dart
static const Color primaryColor = Color(0xFF6200EE); // Change this
```

### Add Your Products

Modify `_mockProducts` in `lib/services/supabase/supabase_service.dart`

## Performance Tips

### Hot Reload
While app is running:
- Press `r` in terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

### Release Build
For testing performance:
```bash
flutter run --release
```

## Common Commands

```bash
# Check for issues
flutter doctor

# Analyze code
flutter analyze

# Format code
flutter format lib/

# Generate build
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web
```

## Support

For issues:
1. Check [README.md](README.md) for detailed info
2. Check [ARCHITECTURE.md](ARCHITECTURE.md) for code structure
3. Run `flutter doctor` for environment issues

## Success Checklist

- [ ] Flutter installed
- [ ] Dependencies downloaded
- [ ] App running on device/simulator
- [ ] Products displaying in grid
- [ ] Can tap product to see details
- [ ] Can filter by category
- [ ] WebView opens on "Buy Now"

If all checked, you're good to go!

---

**Estimated total setup time: 3-5 minutes**

