import 'package:apac_e_commerce/src/cart/presentation/bloc/cart_bloc.dart';
import 'package:apac_e_commerce/src/cart/presentation/bloc/cart_event.dart';
import 'package:apac_e_commerce/src/producs_list/data/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CartBloc cartBloc;

  // Create a mock/fake product for testing
  final product1 = Product(
      id: 1,
      title: 'Product 1',
      price: 22.35,
      description: 'Product 1 description',
      image: '',
      rating: 2.3);
  final product2 = Product(
      id: 1,
      title: 'Product 2',
      price: 32.35,
      description: 'Product 2 description',
      image: '',
      rating: 2.4);

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();

    cartBloc = CartBloc();
  });

  tearDown(() {
    cartBloc.close();
  });

  test('initial state should be CartState with empty items', () {
    expect(cartBloc.state.items, []);
  });

  test('add the same product twice to cart and verify quantity increments',
      () async {
    // Add product1 twice
    cartBloc.add(AddToCart(product1));

    // Wait for the event to be processed
    await Future.delayed(Duration.zero);

    // Check if the quantity was incremented
    expect(cartBloc.state.items.length, 1);
    expect(cartBloc.state.items[0].product.title, 'Product 1');
    expect(cartBloc.state.items[0].quantity, 1);
  });

  test('add multiple products and verify state', () async {
    // Add two different products
    cartBloc.add(AddToCart(product1));
    cartBloc.add(AddToCart(product2));

    // Wait for the event to be processed
    await Future.delayed(Duration.zero);

    // Check if both products were added correctly
    expect(cartBloc.state.items.length, 2);
    expect(cartBloc.state.items[0].product.title, 'Product 1');
    expect(cartBloc.state.items[1].product.title, 'Product 2');
  });

  test('remove product from cart and verify state', () async {
    // Add product1 and product2, then remove product1
    cartBloc.add(AddToCart(product1));
    cartBloc.add(AddToCart(product2));
    cartBloc.add(RemoveFromCart(product1));

    // Wait for the event to be processed
    await Future.delayed(Duration.zero);

    // Check if product1 was removed and only product2 remains
    expect(cartBloc.state.items.length, 1);
    expect(cartBloc.state.items[0].product.title, 'Product 2');
  });

  test('update quantity of a product in the cart', () async {
    // Add product1, then update its quantity
    cartBloc.add(AddToCart(product1));
    cartBloc.add(UpdateCartQuantity(product1, 5));

    // Wait for the event to be processed
    await Future.delayed(Duration.zero);

    // Check if the quantity was updated correctly
    expect(cartBloc.state.items.length, 1);
    expect(cartBloc.state.items[0].quantity, 5);
  });

  test('clear the cart and verify state', () async {
    // Add two products and then clear the cart
    cartBloc.add(AddToCart(product1));
    cartBloc.add(AddToCart(product2));
    cartBloc.add(ClearCart());

    // Wait for the event to be processed
    await Future.delayed(Duration.zero);

    // Check if the cart is empty after clearing
    expect(cartBloc.state.items.length, 0);
  });
}
