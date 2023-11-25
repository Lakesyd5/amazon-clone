import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/features/home/service/home_servies.dart';
import 'package:amazon_clone/features/home/providers/category_provider.dart';

// Category Provider
final categoryProductsProvider = FutureProvider<List<Product>?>((ref) async {
  final category = ref.watch(selectedCategoryProvider) ;
  final HomeService homeService = HomeService();

  return await homeService.fetchCategoryProducts(category: category!, ref: ref);
});