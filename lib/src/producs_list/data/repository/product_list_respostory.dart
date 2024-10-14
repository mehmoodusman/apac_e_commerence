// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:apac_e_commerce/core/utils/extensions.dart';
import 'package:apac_e_commerce/src/producs_list/data/data_source/product_list_data_source.dart';
import 'package:apac_e_commerce/src/producs_list/data/model/product.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/string_constants.dart';
import '../../../../core/utils/typedef.dart';

class ProductListRespostory {
  final ProductListDataSource productListDataSource;
  final List<ConnectivityResult> connectivityResult;

  ProductListRespostory(
      {required this.productListDataSource, required this.connectivityResult});

  ResultFuture<List<Product>> getProductList() async {
    // If device is offline
    if (connectivityResult == ConnectivityResult.none) {
      final offlneProducts =
          await StringConst.productOffLine.readFromGetStorage();
      if (offlneProducts != '') {
        final List<Product> result = (jsonDecode(offlneProducts) as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();

        return Right(result);
      } else {
        return Left(
          APIFailure.fromException(
            const APIException(
              message: '"No offline data available"',
              statusCode: 404,
            ),
          ),
        );
      }
    } else {
      try {
        final bookingSessionDetailResponse =
            await productListDataSource.getProductsList();
        return Right(bookingSessionDetailResponse);
      } on APIException catch (e) {
        final offlneProducts =
            await StringConst.productOffLine.readFromGetStorage();
        if (offlneProducts != '') {
          final List<Product> result = (jsonDecode(offlneProducts) as List)
              .map((productJson) => Product.fromJson(productJson))
              .toList();

          return Right(result);
        } else {
          return Left(
            APIFailure.fromException(e),
          );
        }
      }
    }
  }
}
