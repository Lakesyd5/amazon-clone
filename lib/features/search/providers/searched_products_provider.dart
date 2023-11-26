import 'package:amazon_clone/features/search/providers/search_provider.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedProductsProvider = FutureProvider<List<Product>?>((ref) async {
  final search = ref.watch(searchProvider);
  final SearchServices searchServices = SearchServices();

  return await searchServices.fetchSearchedProduct(ref: ref, serachQuery: search!);
});