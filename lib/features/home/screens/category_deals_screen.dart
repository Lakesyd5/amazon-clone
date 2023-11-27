import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/providers/category_provider.dart';
import 'package:amazon_clone/features/product_details/providers/product_detail_provider.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/category_product_provider.dart';

class CategoryDealsScreen extends ConsumerStatefulWidget {
  const CategoryDealsScreen({super.key});

  @override
  ConsumerState<CategoryDealsScreen> createState() =>
      _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends ConsumerState<CategoryDealsScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final categoryProduct = ref.watch(categoryProductsProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            '$selectedCategory',
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: categoryProduct.when(
        data: (List<Product>? product) {
          if (product == null || product.isEmpty) {
            return Center(
              child: Text('No products found for $selectedCategory'),
            );
          } else {
            return Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for $selectedCategory',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: product.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final currentProduct = product[index];

                      return GestureDetector(
                        onTap: () {
                          ref.read(productDetailProvider.notifier).selectedProduct(currentProduct);
                          context.push('/productDetails');
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    currentProduct.images[0],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                left: 0,
                                top: 5,
                                right: 15,
                              ),
                              child: Text(
                                currentProduct.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Loader(),
      ),
    );
  }
}
