import 'package:cGamer/app/controllers/play_together_controllers/connections_controllers/connections_controller.dart';
import 'package:cGamer/app/data/provider/play_together_providers/connections_provider.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/connections_repository.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:get/get.dart';

class ConnectionBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    ConnectionsProvider provider = ConnectionsProvider(requester);
    ConnectionsRepository repository = ConnectionsRepository(provider);
    Get.lazyPut<ConnectionController>(
        () => ConnectionController(repository: repository));
  }
}
