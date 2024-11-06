// BLoC
import 'package:apac_e_commerce/src/products_list/data/repository/product_list_respostory.dart';
import 'package:bloc/bloc.dart';
import 'product_listing_event.dart';
import 'product_listing_state.dart';

class ProductListingBloc extends Bloc<ProductEvent, ProductState> {
  final ProductListRespostory productListRespostory;
  ProductListingBloc(this.productListRespostory) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());

      final response = await productListRespostory.getProductList();
      response.fold((failure) {
        emit(ProductError(failure.message));
      }, (products) {
        emit(ProductLoaded(products));
      });
    });
  }
}
