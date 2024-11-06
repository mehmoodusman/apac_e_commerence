import 'dart:convert';

import 'package:apac_e_commerce/core/utils/extensions.dart';
import 'package:apac_e_commerce/src/products_list/data/model/product.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/string_constants.dart';
import '../../../../network/api_helper.dart';

class ProductListDataSource {
  final APIHelper _apiHelper;

  ProductListDataSource(this._apiHelper);

  Future<List<Product>> getProductsList() async {
    try {
      final response = await _apiHelper.request(
        url: APIEndpoints.getProducts,
        method: Method.GET,
      );
      final List<Product> result = (response.data as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList();
      if (result.isNotEmpty) {
        jsonEncode(response.data).toString().saveToGetStorage(
              key: StringConst.productOffLine,
            );
        return result;
      } else {
        throw const APIException(
          message: StringConst.somethingWentWrong,
          statusCode: 200,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }
}
