import 'package:cGamer/app/data/models/user_account_models/user_info.dart';
import 'package:cGamer/app/data/provider/signup_providerrs/register_provider.dart';
import 'package:meta/meta.dart';

class RegisterRepository {
  final RegisterApiClient apiClient;

  RegisterRepository({required this.apiClient});

// getAll(){
//   return apiClient.getAll();
// }
// getId(id){
//   return apiClient.getId(id);
// }
// delete(id){
//   return apiClient.delete(id);
// }
// edit(obj){
//   return apiClient.edit( obj );
// }
  add(UserRegisterModel _user) async {
    return await apiClient.add(_user);
  }
}
