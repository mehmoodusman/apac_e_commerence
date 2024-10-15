import 'package:apac_e_commerce/src/producs_list/presentation/bloc/product_listing_bloc.dart';
import 'package:apac_e_commerce/src/producs_list/presentation/bloc/product_listing_event.dart';
import 'package:apac_e_commerce/src/producs_list/presentation/bloc/product_listing_state.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_product_listing_repositiry.dart';

void main() {
  group('ProductListingBloc Tests', () {
    late ProductListingBloc productListingBloc;
    late FakeProductListRepository fakeRepository;

    setUp(() {
      // Set up the fake repository and bloc before each test
      fakeRepository = FakeProductListRepository(shouldFail: false);
      productListingBloc = ProductListingBloc(fakeRepository);
    });

    tearDown(() {
      // Close the bloc after each test
      productListingBloc.close();
    });

    test(
      'emits [ProductLoading, ProductLoaded] when products are loaded successfully',
      () async {
        // Verify initial state is ProductInitial
        expect(productListingBloc.state, isA<ProductInitial>());

        // Listen to emitted states
        final List<ProductState> emittedStates = [];
        final subscription =
            productListingBloc.stream.listen(emittedStates.add);

        // Trigger LoadProducts event
        productListingBloc.add(LoadProducts());

        // Wait for all states to be emitted (you may need to adjust the delay if necessary)
        await Future.delayed(Duration(milliseconds: 500));

        // Assert that two states were emitted
        expect(emittedStates.length,
            2); // Assert that only two states were emitted
        expect(emittedStates[0], isA<ProductLoading>());
        expect(emittedStates[1], isA<ProductLoaded>());

        // Validate the ProductLoaded state
        final loadedState = emittedStates[1] as ProductLoaded;
        expect(loadedState.products.length, 4);
        expect(loadedState.products[0].title, "Product 1");
        expect(loadedState.products[1].title, "Product 2");

        // Cancel the subscription to the stream
        await subscription.cancel();
      },
    );

    test('emits ProductLoading and ProductError when product loading fails',
        () async {
      // Use a failing fake repository
      fakeRepository = FakeProductListRepository(shouldFail: true);
      productListingBloc = ProductListingBloc(fakeRepository);

      // Listen to emitted states
      final List<ProductState> emittedStates = [];
      final subscription = productListingBloc.stream.listen(emittedStates.add);

      // Trigger LoadProducts event
      productListingBloc.add(LoadProducts());

      // Wait for the events to be processed
      await Future.delayed(Duration.zero);

      // Assert the expected states
      expect(emittedStates[0], isA<ProductLoading>());
      expect(emittedStates[1], isA<ProductError>());

      final errorState = emittedStates[1] as ProductError;
      expect(errorState.message, "Failed to load products");

      // Cancel the subscription to the stream
      await subscription.cancel();
    });
  });
}
