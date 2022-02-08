import 'package:cGamer/app/controllers/extract/extract_controller.dart';
import 'package:cGamer/app/controllers/pro/pro_controller.dart';
import 'package:cGamer/app/data/provider/extract_provider/extract_provider.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/provider/pro_provider/pro_provider.dart';
import 'package:cGamer/app/data/repository/extract_repositories/extract_repository.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/data/repository/pro_repositories/pro_repository.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:get/get.dart';

class ProBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();

    ProProvider provider = ProProvider(requester: requester);
    ProRepository repository = ProRepository(provider: provider);

    Get.lazyPut<ProController>(
      () => ProController(
        repository: repository,
      ),
    );
  }
}
