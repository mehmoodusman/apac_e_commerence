import 'package:apac_e_commerce/core/error/failure.dart';
import 'package:apac_e_commerce/src/products_list/data/data_source/product_list_data_source.dart';
import 'package:apac_e_commerce/src/products_list/data/model/product.dart';
import 'package:apac_e_commerce/src/products_list/data/repository/product_list_respostory.dart';
import 'package:connectivity_plus_platform_interface/src/enums.dart';
import 'package:dartz/dartz.dart';

class FakeProductListRepository implements ProductListRespostory {
  final bool shouldFail;

  FakeProductListRepository({this.shouldFail = false});

  @override
  Future<Either<Failure, List<Product>>> getProductList() async {
    if (shouldFail) {
      return Left(
          APIFailure(message: "Failed to load products", statusCode: 404));
    } else {
      return Right([
        Product(
            id: 1,
            title: 'Product 1',
            price: 22.35,
            description: 'Product 1 description',
            image: '',
            rating: 2.3),
        Product(
            id: 1,
            title: 'Product 2',
            price: 32.35,
            description: 'Product 2 description',
            image: '',
            rating: 2.4),
        Product(
            id: 1,
            title: 'Product 3',
            price: 42.35,
            description: 'Product 3 description',
            image: '',
            rating: 2.5),
        Product(
            id: 1,
            title: 'Product 4',
            price: 52.35,
            description: 'Product 4 description',
            image: '',
            rating: 2.6),
      ]);
    }
  }

  @override
  List<ConnectivityResult> get connectivityResult => throw UnimplementedError();

  @override
  ProductListDataSource get productListDataSource => throw UnimplementedError();
}
