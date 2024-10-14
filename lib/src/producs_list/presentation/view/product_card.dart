import 'dart:io';

import 'package:apac_e_commerce/core/utils/styles/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../data/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: product.title,
                  child: Image.network(
                    product.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,

                    // Adding a loader while the image is loading
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        // Image has finished loading, return the image
                        return child;
                      } else {
                        // Image is still loading, show a CircularProgressIndicator
                        return Center(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            ),
                          ),
                        );
                      }
                    },

                    // Handling error (broken image URL or loading failure)
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      // Returning a placeholder when an error occurs
                      if (exception is SocketException) {
                        return Container(
                          width: 100,
                          height: 100,
                          color:
                              Colors.grey[300], // Placeholder background color
                          child: const Center(
                            child: Text(
                              'No Internet Connection', // Display a friendly error message
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          color:
                              Colors.grey[300], // Placeholder background color
                          child: const Center(
                            child: Icon(
                              Icons.error, // Error icon for other errors
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        );
                      }
                    },
                  )),
              KDimension().kWidth15,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    KDimension().kHeight05,
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.w600),
                    ),
                    KDimension().kHeight05,
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text('${product.rating}'),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  context.read<CartBloc>().add(AddToCart(product));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.title} added to cart')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
