import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HomeApiClient? homeProvider;
  HomeRepository? homeRepository;
  Requester httpClient = Requester();
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    homeProvider = HomeApiClient(httpClient: httpClient);
    homeRepository = HomeRepository(apiClient: homeProvider!);
  });

  test(
    "Should call HomeRepository that will call a get balance of HomeProvider",
    () async {
      await homeRepository?.getBalance();
      verify(
        homeProvider?.getBalance(),
      );
    },
  );

  test(
    "Should call HomeRepository that will call a get home stats of HomeProvider",
    () async {
      await homeRepository?.getHomeStats();
      verify(
        homeProvider?.getHomeStats(),
      );
    },
  );

  test(
    "Should call HomeRepository that will call a get missions of HomeProvider",
    () async {
      await homeRepository?.getMissions();
      verify(
        homeProvider?.getMissions(),
      );
    },
  );

  test(
    "Should call HomeRepository that will call a get home satus register of HomeProvider",
    () async {
      await homeRepository?.getStatusRegister();
      verify(
        homeProvider?.getStatusRegister(),
      );
    },
  );
}
