import 'dart:convert';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';

class AdressApiClient {
  final http.Client? httpClient;
  AdressApiClient({required this.httpClient});
  CepModel? _cepModelResponse;
  List<UfModel> _ufModel = [];
  List<CityModel> _cityModel = [];
  var uf;

  getInfoByCep(String cep) async {
    var url = CompleteRegisterEndpoints().getCepUrl(cep);
    Uri uri = Uri.https('viacep.com.br', '/ws/$cep/json/');
    try {
      var response = await Requester().fetch(url: url, uri: uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        _cepModelResponse = CepModel.fromJson(jsonResponse);
      }
      return _cepModelResponse;
    } catch (e) {
      throw new Exception(e);
    }
  }

  List<UfModel> convertResponse(List<dynamic> _response) {
    _ufModel.add(UfModel(sigla: "UF"));
    for (var item in _response) {
      _ufModel.add(UfModel.fromJson(item));
    }
    return _ufModel;
  }

  getUfs() async {
    var url = CompleteRegisterEndpoints().getUfUrl();
    Uri uri = Uri.https(
        'servicodados.ibge.gov.br', '/api/v1/localidades/estados?orderBy=nome');
    try {
      var response = await Requester().fetch(url: url, uri: uri);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        return convertResponse(jsonResponse);
      }
    } catch (e) {
      throw new Exception(e);
    }
  }

  getCities(String _uf) async {
    var url = CompleteRegisterEndpoints().getCityByUfUrl(_uf);

    Uri uri = Uri.https('servicodados.ibge.gov.br',
        '/api/v1/localidades/estados/$_uf/municipios?orderBy=nome');

    try {
      var response = await Requester().fetch(url: url, uri: uri);
      if (response.statusCode == 200) {
        _cityModel = [];
        List<dynamic> _jsonResponse = json.decode(response.body);

        for (var item in _jsonResponse) {
          _cityModel.add(CityModel.fromJson(item));
        }

        return _cityModel;
      }
    } catch (e) {
      throw new Exception(e);
    }
  }
}
