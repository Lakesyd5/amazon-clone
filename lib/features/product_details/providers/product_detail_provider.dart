import 'package:amazon_clone/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailProvider = StateNotifierProvider<ProductDetailNotifier, Product>((ref) => ProductDetailNotifier());

class ProductDetailNotifier extends StateNotifier<Product> {
  ProductDetailNotifier() : super(Product(name: '', description: '', quantity: 0.0, images: [], category: '', price: 0.0));

  void selectedProduct(Product product) {
    state = product;
  }
}