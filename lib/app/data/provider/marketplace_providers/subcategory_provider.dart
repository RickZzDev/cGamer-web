import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/digital_products_endpoints/digital_products_endpoints.dart';
import 'package:meta/meta.dart';

class SubCategoryProvider {
  final Requester requester;
  SubCategoryProvider({required this.requester});

  productDetails(DigitalProduct? product) async {
    var url = DigitalProductsEndpoint.productDetails(
        product?.id ?? 0, product?.partnerId ?? 0);
    var header = await Headers().getAuthenticatedHeader();
    var response = await requester.fetch(url: url, header: header);
    return response;
  }
}
