import 'package:kulina_submission_test/models/cart.dart';

abstract class ProductListEvent {}

class RequestProduct extends ProductListEvent {}

class FindItemInCart extends ProductListEvent {
  final int itemId;
  FindItemInCart({this.itemId});
}

class AddProductToCart extends ProductListEvent {
  final int productId;
  AddProductToCart({this.productId});
}

class AddQuantity extends ProductListEvent {
  final Cart cart;
  AddQuantity({this.cart});
}

class SubtractQuantity extends ProductListEvent {
  final Cart cart;
  SubtractQuantity({this.cart});
}
