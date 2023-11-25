// import 'package:amazon_clone/features/home/service/home_servies.dart';
// import 'package:amazon_clone/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedCategoryNotifier extends StateNotifier<String?> {
  SelectedCategoryNotifier() : super('Mobiles');

  void setSelectedCategory(String category) {
    state = category;
  }
}

final selectedCategoryProvider = StateNotifierProvider<SelectedCategoryNotifier, String?>((ref) {
  return SelectedCategoryNotifier();
});



