import '../../data/model/cart_item.dart';

class CartState {
  final List<CartItem> items;

  CartState({this.items = const []});
}
