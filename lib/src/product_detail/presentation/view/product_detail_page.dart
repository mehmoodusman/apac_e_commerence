import 'dart:io';

import 'package:flutter/material.dart';

import '../../../products_list/data/model/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: product.title,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,

                    // Centered loader while the image is loading
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        // Image has finished loading, return the image
                        return child;
                      } else {
                        // Image is still loading, show the loader centered
                        return Center(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              child, // Display the child (image) as it is progressively loading
                              Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              ),
                            ],
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
                          height: 300,
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
              const SizedBox(height: 16),
              Text(
                product.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${product.price}',
                style: const TextStyle(fontSize: 20, color: Colors.teal),
              ),
              const SizedBox(height: 8),
              Text('Rating: ${product.rating}'),
              const SizedBox(height: 16),
              Text(product.description, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
