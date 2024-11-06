import '../../../products_list/data/model/product.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;

  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;

  RemoveFromCart(this.product);
}

class UpdateCartQuantity extends CartEvent {
  final Product product;
  final int newQuantity;

  UpdateCartQuantity(this.product, this.newQuantity);
}

class LoadCart extends CartEvent {}

class ClearCart extends CartEvent {}
