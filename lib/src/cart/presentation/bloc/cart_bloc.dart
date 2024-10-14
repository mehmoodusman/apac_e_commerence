import 'dart:convert';

import 'package:apac_e_commerce/core/utils/extensions.dart';
import 'package:apac_e_commerce/core/utils/string_constants.dart';
import 'package:bloc/bloc.dart';

import '../../data/model/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    // Registering the AddToCart event handler

    on<AddToCart>(_onAddToCart);
    on<UpdateCartQuantity>(_onUpdateCartQuantity);
    on<RemoveFromCart>(_onRemoveFromCart);

    // Dispatch LoadCartState event to load initial cart state
    on<LoadCart>(_onLoadCartState);
    on<ClearCart>(_onClearCartState);
  }

  // This method handles the AddToCart event
  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final items = List<CartItem>.from(state.items);

    final existingItem = items.firstWhere(
      (item) => item.product.title == event.product.title,
      orElse: () {
        items.add(CartItem(product: event.product));
        return CartItem(product: event.product);
      },
    );
    if (existingItem.product.title == event.product.title) {
      existingItem.quantity++;
    } else {
      items.add(CartItem(product: event.product));
    }
    _saveCartState(items);

    emit(CartState(items: items));
  }

  void _onUpdateCartQuantity(
      UpdateCartQuantity event, Emitter<CartState> emit) {
    final items = List<CartItem>.from(state.items);
    final existingItem = items.firstWhere(
      (item) => item.product.title == event.product.title,
      orElse: () => CartItem(product: event.product),
    );

    if (event.newQuantity > 0) {
      existingItem.quantity = event.newQuantity;
    } else {
      // If quantity is 0 or less, remove the item from the cart
      items.remove(existingItem);
    }
    _saveCartState(items);

    emit(CartState(items: items));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final items = List<CartItem>.from(state.items);
    final existingItem = items.firstWhere(
      (item) => item.product.title == event.product.title,
      orElse: () => CartItem(product: event.product),
    );

    // If quantity is 0 or less, remove the item from the cart
    items.remove(existingItem);
    _saveCartState(items);
    emit(CartState(items: items));
  }

  void _onLoadCartState(LoadCart event, Emitter<CartState> emit) async {
    final List<dynamic> storedItems =
        await StringConst.cartItemKey.readJsonListFromGetStorage();
    if (storedItems.isNotEmpty) {
      final List<CartItem> items = storedItems
          .map((item) => CartItem.fromJson(jsonEncode(item)))
          .toList();
      emit(CartState(items: items));
    }
  }

  void _onClearCartState(ClearCart event, Emitter<CartState> emit) async {
    emit(CartState(items: []));
    ''.saveToGetStorage(key: StringConst.cartItemKey);
  }

  // Method to save cart state to storage
  void _saveCartState(List<CartItem> items) {
    final List<dynamic> jsonItems = items.map((item) => item.toJson()).toList();
    jsonItems.toString().saveToGetStorage(key: StringConst.cartItemKey);
    // _storage.write('cart_items', jsonItems);
  }
}
