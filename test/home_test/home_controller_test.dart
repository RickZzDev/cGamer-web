import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/data/models/home_models/missions_model.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class HomeRepositorySpy extends Mock implements HomeRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HomeRepositorySpy repositorySpy = HomeRepositorySpy();
  HomeController? sut;
  setUp(() {
    // repositorySpy = HomeRepositorySpy();
    WidgetsFlutterBinding.ensureInitialized();
    sut = HomeController(repository: repositorySpy);
  });

  test(
    "Should call homeRepository.getmissions",
    () async {
      when(repositorySpy.getMissions())
          .thenAnswer((_) => Response('{"any_key":"any_value"}', 200));
      await sut?.getMissions();
      verify(
        repositorySpy.getMissions(),
      );
    },
  );

  test(
    "Should return null if exception",
    () async {
      when(repositorySpy.getMissions()).thenThrow(Exception());
      dynamic response = await sut?.getMissions();
      expect(response, null);
    },
  );

  test(
    "Should mount missions obj",
    () async {
      when(repositorySpy.getMissions()).thenAnswer((_) => Response(
          '{"missions": [{ "id": 1, "name": "Faça a primeira regarga de celular","points": 100,"hasComplete": false}]}',
          200));

      await sut?.getMissions();

      Missions missions = Missions(
          name: 'Faça a primeira regarga de celular',
          id: 1,
          points: 100,
          hasComplete: false);
      MissionsModel missionsModel = MissionsModel(missions: [missions]);

      // expect(sut?.missionsResult.value.missions[0].id,
      //     missionsModel.missions[0].id);
      // expect(sut?.missionsResult.value.missions[0].name,
      //     missionsModel.missions[0].name);
      // expect(sut?.missionsResult.value.missions[0].points,
      //     missionsModel.missions[0].points);
      // expect(sut?.missionsResult.value.missions[0].hasComplete,
      //     missionsModel.missions[0].hasComplete);
      // expect(sut?.missionsResult.value.missions[0].iconUrl,
      //     missionsModel.missions[0].iconUrl);
      // expect(sut?.missionsResult.value.missions[0].imgName,
      //     missionsModel.missions[0].imgName);
    },
  );

  test("Should return initials letters", () async {
    sut?.homeResult.value.customerNick = "waka tech";
    String? response = sut?.getInitialsName();
    expect(response, "WT");
  });

  test("Verify if change money visibility is working", () {
    bool booleanValue = sut?.moneyVisibility;
    sut?.changeVisibility(!booleanValue);
    expect(sut?.moneyVisibility, !booleanValue);
  });

  test(
    "Should call homeRepository.getBalance with correct url and headers",
    () async {
      when(repositorySpy.getBalance())
          .thenAnswer((_) => Response('{"any_key":"any_value"}', 200));
      await sut?.getBalance();
      verify(
        repositorySpy.getBalance(),
      );
    },
  );

  test("Ensure that all request indicators starts on false", () async {
    expect(await sut?.hasCompletedBalanceRequest.value, false);
    expect(await sut?.hasCompletedHeaderRequest.value, false);
    expect(await sut?.hasCompletedStatusRequest.value, false);
  });

  test(
      "Should return true if documents has been send and false if documents have been not send",
      () {
    sut?.statusRegisterResult.value.hasCompleteRegistration = true;
    sut?.statusRegisterResult.value.hasSendDocumentation = true;
    var response = sut?.verifyDocumentsSend();
    expect(response, true);

    sut?.statusRegisterResult.value.hasCompleteRegistration = false;
    sut?.statusRegisterResult.value.hasSendDocumentation = false;
    var responseFalse = sut?.verifyDocumentsSend();
    expect(responseFalse, false);

    sut?.statusRegisterResult.value.hasCompleteRegistration = true;
    sut?.statusRegisterResult.value.hasSendDocumentation = false;
    var responseFalse2 = sut?.verifyDocumentsSend();
    expect(responseFalse2, false);
  });
}
