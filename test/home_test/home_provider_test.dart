import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HomeApiClient? homeProvider;
  Requester httpClient = Requester();
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    homeProvider = HomeApiClient(httpClient: httpClient);
  });

  test(
    "Should call homeProvider.getbalances with correct url and headers",
    () async {
      await homeProvider?.getBalance()!;
      verify(
        httpClient.fetch(
          url: HomeEndpoint.urlBalance,
          header: await Headers().getAuthenticatedHeader(),
        ),
      );
    },
  );

  test(
    "Should call homeProvider.getHomeStats with correct url and headers",
    () async {
      await homeProvider?.getHomeStats();
      verify(
        httpClient.fetch(
          url: HomeEndpoint.urlBalance,
          header: await Headers().getAuthenticatedHeader(),
        ),
      );
    },
  );

  test(
    "Should call homeProvider.getMissions with correct url and headers",
    () async {
      await homeProvider?.getMissions();
      verify(
        httpClient.fetch(
          url: HomeEndpoint.urlBalance,
          header: await Headers().getAuthenticatedHeader(),
        ),
      );
    },
  );

  test(
    "Should call homeProvider.getStatusRegister with correct url and headers",
    () async {
      await homeProvider?.getStatusRegister();
      verify(
        httpClient.fetch(
          url: HomeEndpoint.urlBalance,
          header: await Headers().getAuthenticatedHeader(),
        ),
      );
    },
  );

  // test(
  //   "Should call HomeRepository that will call a get home stats of HomeProvider",
  //   () async {
  //     await homeRepository.getHomeStats();
  //     verify(
  //       homeProvider.getHomeStats(),
  //     );
  //   },
  // );

  // test(
  //   "Should call HomeRepository that will call a get missions of HomeProvider",
  //   () async {
  //     await homeRepository.getMissions();
  //     verify(
  //       homeProvider.getMissions(),
  //     );
  //   },
  // );

  // test(
  //   "Should call HomeRepository that will call a get home satus register of HomeProvider",
  //   () async {
  //     await homeRepository.getStatusRegister();
  //     verify(
  //       homeProvider.getStatusRegister(),
  //     );
  //   },
  // );
}
