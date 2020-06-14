class Product {
  final int id;
  final String name;
  final String imageUrl;
  final String brandName;
  final String packageName;
  final int price;
  final double rating;

  Product(
      {this.id,
      this.name,
      this.imageUrl,
      this.brandName,
      this.packageName,
      this.price,
      this.rating});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      brandName: json['brand_name'],
      packageName: json['package_name'],
      price: json['price'],
      rating: json['rating'],
    );
  }
}
