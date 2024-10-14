// ignore_for_file: constant_identifier_names

class APIEndpoints {
  static const String APIBaseURL = "https://fakestoreapi.com/";
  static const String getProducts = "products";
  static String productDetailEndpoint(String productId) => "product/$productId";
}
