import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/string_constants.dart';
import '../bloc/product_listing_bloc.dart';
import '../bloc/product_listing_state.dart';

class ProductSearchDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search products...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Return empty since this search is handled within the buildSuggestions method
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Accessing the current product state to filter the products list
    return BlocBuilder<ProductListingBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          // Filter products based on search query
          final products = state.products.where((product) {
            return product.title.toLowerCase().contains(query.toLowerCase());
          }).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                child: ListTile(
                  title: Text(product.title),
                  onTap: () {
                    // close(context, product.title);
                    context.pushNamed(StringConst.productDetailName,
                        extra: product);
                  },
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
