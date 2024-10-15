# Fakestore App
This project is a shopping application that uses the Fakestore API to fetch product information and manage a cart. The application allows users to browse products, view product details, manage a shopping cart, and proceed to checkout. Users can also authenticate with Firebase before placing an order.

# Features

## Product Listing Page: 
Fetches and displays products from the Fakestore API with pagination or infinite scroll.

## Product Details Page: 
Displays detailed information about a selected product with an option to add it to the cart.

## Cart Management: 
Users can add, update, and remove items from the cart. The total price is displayed at the bottom of the cart page.

## Order Checkout: 
Users can review their order and proceed to checkout.

## Authentication: 
Users must register or log in using Firebase Authentication before placing an order.

## Offline Functionality: 
Browsing of previously fetched products and cart functionality is available offline using GetStorage.

## Search Functionality: 
Users can search for products by name or category.

## State Management: 
The application uses Bloc for state management.

## Unit Tests: 
Includes unit tests for state management and Unit tests.

# Tech Stack
 - Flutter: Cross-platform mobile application development.
 - Dio: For API integration.
 - Bloc: For state management.
 - Firebase Authentication: For user authentication.
 - GetStorage: For offline storage.

# API Information
- Base URL: https://fakestoreapi.com/
- Product List Endpoint: /products
- Example API Endpoints
- List all products: GET https://fakestoreapi.com/products



# Prerequisites
 - Flutter SDK: Install Flutter
 - Firebase Project: You will need to set up a Firebase project and add Firebase Authentication.
 - Dart: Dart SDK should be installed along with Flutter.

# Install Flutter dependencies:
Run the following command in the project directory:

- flutter pub get
- Set up Firebase:

Go to Firebase Console, create a new project, and add Firebase Authentication.
Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) files from Firebase.
Place these files in their respective directories:
For Android: android/app/
For iOS: ios/Runner/
Modify your android/build.gradle and android/app/build.gradle to include Firebase dependencies.
Ensure that you have added Firebase to your iOS project by following this guide.
Configure GetStorage:

# Add the following dependencies in pubspec.yaml:

dependencies:
  get_storage: ^2.0.3
  dio: ^4.0.0
  flutter_bloc: ^8.0.0
  firebase_auth: ^4.0.1

# Run the application:

- Run the following command to launch the app in debug mode:

# flutter run
If you're targeting a specific platform, you can specify it:

- Android: flutter run -d android
- viOS: flutter run -d ios


# Unit Tests
To run the unit tests, use the following command:

- flutter test
- Tests will be executed for both state management and UI components.
