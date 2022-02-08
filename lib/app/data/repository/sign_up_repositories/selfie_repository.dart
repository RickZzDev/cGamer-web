import 'package:cGamer/app/data/models/photo_docs_model/photo_docs_model.dart';
import 'package:cGamer/app/data/provider/signup_providerrs/selfie_provider.dart';
import 'package:meta/meta.dart';

class SelfieRepository {
  final SelfieApiClient apiClient;

  SelfieRepository({required this.apiClient});

  Future<dynamic> sendDocuments(PhotoDocsModel _docsModel) async {
    var response = await apiClient.sendDocuments(_docsModel);
    return response;
  }

  Future<dynamic> create() async {
    var response = await apiClient.create();
    return response;
  }
}
