import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/digital_products_endpoints/digital_products_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/digital_products_endpoints/store_partners_endpoints.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:meta/meta.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';

class MarketPlaceProvider {
  final Requester requester;
  MarketPlaceProvider({required this.requester});

  digitalProductCollections(String? category) async {
    Map<String, String>? _params;
    if (category != null) {
      _params = {'category': category};
    }
    var url = DigitalProductsEndpoint.collections();
    var header = await Headers().getAuthenticatedHeader();
    var response =
        await requester.fetch(url: url, header: header, params: _params);
    return response;
  }

  storePartnerCollections(String? category) async {
    Map<String, String>? _params;
    if (category != null) {
      _params = {'category': category};
    }
    var url = StorePartnersEndpoint.collections();
    var header = await Headers().getAuthenticatedHeader();
    var response =
        await requester.fetch(url: url, header: header, params: _params);
    return response;
  }

  products(int id) async {
    var url = DigitalProductsEndpoint.productsByCollection(id);
    var header = await Headers().getAuthenticatedHeader();
    var response = await requester.fetch(url: url, header: header);
    return response;
  }

  purchase(DigitalProduct? product, String? password) async {
    var url = DigitalProductsEndpoint.purchase(
        product?.id ?? 0, product?.partnerId ?? 0);
    Map<String, dynamic> body = new Map<String, dynamic>();
    body['amount'] = product?.salesPrice;
    body['password'] = SecurityUtils.encodeTo64(password ?? "");
    var header = await Headers().getAuthenticatedHeader();
    var response = await requester.post(url: url, body: body, header: header);
    return response;
  }

  offers() async {
    var url = DigitalProductsEndpoint.offers();
    var header = await Headers().getAuthenticatedHeader();
    var response = await requester.fetch(url: url, header: header);
    return response;
  }
}
