import 'dart:convert';

import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/data/repository/profile_repositories/profile_repository.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:share/share.dart';

class InviteFriendController extends GetxController {
  var indicationCode = ''.obs;

  final ProfileRepository? repository;
  InviteFriendController({required this.repository});

  Rx<ProfileModel> statusProfileResult = ProfileModel().obs;
  Rx<Future?> hasCompletedRequest = Rx<Future?>(null);

  var isPrime = false.obs;

  @override
  void onReady() async {
    isPrime.value = await PrimeUtils.isPrime();
    // indicationCode.value = Get.argum
    // ents["indication_code"];
    hasCompletedRequest.value = getIndicationCode();

    super.onReady();
  }

  void shareInvitationCode() {
    Share.share(GenericUtils.getIndicationShare(indicationCode.value));
  }

  Future getIndicationCode() async {
    var response = await repository?.getProfile();
    Map<String, dynamic> mapResponse =
        json.decode(utf8.decode(response.bodyBytes));
    indicationCode.value = mapResponse['customerInviteCode'];
  }
}
