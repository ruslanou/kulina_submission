class Cart {
  final int id;
  final int orderedItemId;
  final int quantity;

  Cart({this.id, this.orderedItemId, this.quantity});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      orderedItemId: json["ordered_item_id"],
      quantity: json['quantity'],
    );
  }
}
