import 'package:apac_e_commerce/src/authentication/presentation/view/auth_wrapper.dart';
import 'package:apac_e_commerce/src/authentication/presentation/view/login_page.dart';
import 'package:apac_e_commerce/src/authentication/presentation/view/register_page.dart';
import 'package:apac_e_commerce/src/cart/presentation/view/cart_page.dart';
import 'package:apac_e_commerce/src/confirmation_page/presentation/view/confirmation_page.dart';
import 'package:apac_e_commerce/src/products_list/data/model/product.dart';
import 'package:apac_e_commerce/src/products_list/presentation/view/product_listing_page.dart';
import 'package:apac_e_commerce/src/product_detail/presentation/view/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'string_constants.dart';

class MyRouter {
  /// The route configuration.
  static final GlobalKey<NavigatorState> _rootNavKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: StringConst.initialPath,
        builder: (BuildContext context, GoRouterState state) {
          return AuthWrapper();
        },
      ),
      GoRoute(
        path: StringConst.cartPath,
        name: StringConst.cartName,
        builder: (BuildContext context, GoRouterState state) {
          return const CartPage();
        },
      ),
      GoRoute(
        path: StringConst.productListingPath,
        name: StringConst.productListingName,
        builder: (BuildContext context, GoRouterState state) {
          return ProductListingPage();
        },
      ),
      GoRoute(
        path: StringConst.registerPath,
        name: StringConst.registerName,
        builder: (BuildContext context, GoRouterState state) {
          return RegisterPage();
        },
      ),
      GoRoute(
        path: StringConst.loginPath,
        name: StringConst.loginName,
        builder: (BuildContext context, GoRouterState state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: StringConst.confirmationPath,
        name: StringConst.confirmationName,
        builder: (BuildContext context, GoRouterState state) {
          return const ConfirmationPage();
        },
      ),
      GoRoute(
        path: StringConst.productDetailPath,
        name: StringConst.productDetailName,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ProductDetailPage(product: state.extra as Product),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide in from right
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      ),
    ],
  );
}
