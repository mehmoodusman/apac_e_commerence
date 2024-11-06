import 'package:apac_e_commerce/src/products_list/presentation/view/product_listing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'login_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if user is logged in or not
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in, navigate to HomePage
      return const ProductListingPage();
    } else {
      // User is not logged in, navigate to LoginPage
      return LoginPage();
    }
  }
}
