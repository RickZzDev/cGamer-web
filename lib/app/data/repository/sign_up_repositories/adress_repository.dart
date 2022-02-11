import 'package:cGamer/app/data/models/complete_register/adress_models/city_model.dart';
import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/data/provider/signup_providerrs/adress_provider.dart';
import 'package:meta/meta.dart';

class AdreessRepository {
  final AdressApiClient apiClient;

  AdreessRepository({required this.apiClient});

  Future<CepModel> getCepInfo(String _cep) async {
    CepModel _cepModel = await apiClient.getInfoByCep(_cep);
    return _cepModel;
  }

  Future<List<UfModel>> getUfs() async {
    List<UfModel> _ufModel = await apiClient.getUfs();
    return _ufModel;
  }

  Future<List<CityModel>> getCities(String _uf) async {
    List<CityModel> _cities = await apiClient.getCities(_uf);
    return _cities;
  }

  // delete(id) {
  //   return apiClient.delete(id);
  // }

  // edit(obj) {
  //   return apiClient.edit(obj);
  // }

  // add(obj) {
  //   return apiClient.add(obj);
  // }
}
