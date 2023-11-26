import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = StateNotifierProvider<SearchStateNotifier, String?>(
  (ref) => SearchStateNotifier(),
);

class SearchStateNotifier extends StateNotifier<String?> {
  SearchStateNotifier() : super('search');

  void searchValue(String searchValue) {
    state = searchValue;
  }
}
