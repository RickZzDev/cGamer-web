import 'package:cGamer/app/utils/api_utils/api_path.dart';

class DigitalProductsEndpoint {
  static String collections() => "/marketplace/collections";
  static String productsByCollection(int id) => "/marketplace/collections/$id";
  static String productDetails(int id, int partnerId) =>
      "/marketplace/$partnerId/products/$id";
  static String purchase(int id, int partnerId) =>
      "/marketplace/$partnerId/products/$id/purchase";
  static String offers() => "/offers";
}
