import 'package:cGamer/app/data/models/photo_docs_model/photo_docs_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/sign_up_endpoints/complete_register/selfie_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class SelfieApiClient {
  final http.Client httpClient;
  SelfieApiClient({required this.httpClient});

  sendDocuments(PhotoDocsModel? model) async {
    var url = SelfieEndpoints().sendDocuments();
    var header = await Headers().getAuthenticatedHeader();

    Map<String, dynamic> body = Map<String, dynamic>();
    body['frontDocument'] = model?.frontDocPhoto;
    body['backDocument'] = model?.backDocPhoto;
    body['selfie'] = model?.selfiePhoto;
    body['documentType'] = model?.documentType;

    //var response =
    //    await Requester().post(header: header, url: url, body: model);
    var uploadResponse = await Requester().uploadDocuments(
        model!.documentType!,
        model.frontDocPhoto!,
        model.backDocPhoto!,
        model.selfiePhoto!,
        url,
        header);

    return uploadResponse;
  }

  create() async {
    var url = SelfieEndpoints().create();
    var header = await Headers().getAuthenticatedHeader();
    var response = await Requester().post(url: url, header: header);
    return response;
  }
}
