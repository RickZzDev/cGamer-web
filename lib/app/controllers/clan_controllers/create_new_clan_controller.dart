import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_emblems_model.dart';
import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/models/profile_model/profile_model.dart';
import 'package:cGamer/app/data/repository/clan_repositories/create_new_clan_repositories/create_new_clan_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class CreateNewClanController extends GetxController {
  final CreateNewClanRepository repository;
  final CreateClanModel model = CreateClanModel();

  CreateNewClanController({required this.repository});

  TextEditingController clanNameController = TextEditingController();
  TextEditingController clanDescriptionController = TextEditingController();

  RxList<EmblemGridItemModel> emblemsLinks = <EmblemGridItemModel>[].obs;
  var currentEmblem = ''.obs;

  Rx<ProfileModel> statusProfileResult = ProfileModel().obs;
  User? _user;

  var loading = false.obs;

  void emblemTap(int id) {
    emblemsLinks.forEach((element) {
      if (element.id == id) {
        element.isSelected = true;
      } else {
        element.isSelected = false;
      }
    });

    this.emblemsLinks.refresh();
  }

  void saveEmblem() {
    bool hasEmblemSelected = false;

    emblemsLinks.forEach((element) {
      if (element.isSelected) {
        this.currentEmblem.value = element.urlImage;
        hasEmblemSelected = true;
        Get.back();
      }
    });

    !hasEmblemSelected
        ? SnackBarUtils.showSnackBar(
            desc: "Você não selecionou nenhum emblema.", title: "Atenção")
        : DoNothingAction();
  }

  @override
  void onInit() async {
    getEmblems();
    //FirebaseAuth.instance.signOut();
    await getProfile().whenComplete(() => initializeFlutterFire());
    super.onInit();
  }

  bool fieldIsValid() {
    if (clanNameController.text.isEmpty) {
      return false;
    }

    if (currentEmblem.value.isEmpty || currentEmblem.value == "") {
      return false;
    }
    return true;
  }

  Future<bool> getEmblems() async {
    try {
      var response = await repository.getEmblems();

      if (ExceptionUtils.verifyIfIsException(response)) {
        dynamic error = response;

        SnackBarUtils.showSnackBar(desc: error.message, title: "Atenção");
        return false;
      }
      this.emblemsLinks.value = response.emblems;
      return true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, atualize a página.",
          title: "Atenção");
      return false;
    }
  }

  Future<bool> getProfile() async {
    try {
      var response = await repository.getProfile();

      statusProfileResult.value = ProfileModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );

      CacheUtils.addToCache(
          key: 'x-customerId',
          value: statusProfileResult.value.customerId.toString());

      statusProfileResult.refresh();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: statusProfileResult.value.customerEmail ?? "",
        password: SecurityUtils.encodeTo64(
            statusProfileResult.value.customerCPF ?? ""),
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> initializeFlutterFire() async {
    FirebaseChatCoreConfig config = FirebaseChatCoreConfig("rooms", "users");
    FirebaseChatCore.instance.setConfig(config);

    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        _user = user;
        if (_user == null && statusProfileResult.value.customerEmail != null) {
          try {
            final credential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: statusProfileResult.value.customerEmail ?? "",
              password: SecurityUtils.encodeTo64(
                  statusProfileResult.value.customerCPF ?? ""),
            );

            await FirebaseChatCore.instance.createUserInFirestore(
              types.User(
                firstName: statusProfileResult.value.customerNick,
                id: credential.user!.uid,
                imageUrl: statusProfileResult.value.customerAvatar ??
                    "https://i.ibb.co/x5CpK1w/image-profile.png",
                lastName: "",
              ),
            );
          } catch (e) {
            print(e.toString());
          }
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future postNewClan() async {
    if (!fieldIsValid()) {
      SnackBarUtils.showSnackBar(
          desc: "O nome do clã e a escolha de um emblema são obrigatórios.",
          title: "Atenção");
      return;
    }

    this.model.image = currentEmblem.value;
    this.model.name = clanNameController.text;

    clanDescriptionController.text.isEmpty
        ? DoNothingAction()
        : this.model.description = clanDescriptionController.text;

    types.Room? room = await FirebaseChatCore.instance
        .createGroupRoom(name: this.model.name ?? "", users: []);
    this.model.roomId = room.id;

    try {
      loading.value = true;
      var response = await repository.postNewClan(model.toJson());
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: response.message ??
                "Algo de errado aconteceu, tente novamente.",
            title: "Atenção");
      } else {
        var clanId = json.decode(utf8.decode(response.bodyBytes))['clanId'];
        Get.offNamedUntil(Routes.CLAN_DETAILS,
            (route) => route.settings.name == Routes.MAIN_PAGES_HOLDER,
            arguments: {'clanId': clanId});
      }
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(desc: e.toString(), title: "Atenção");
    }
  }

  void openChooseEmblemModal() {
    showModalBottomSheet(
        backgroundColor: secondaryColor,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        context: Get.context!,
        builder: (context) {
          return Builder(
              builder: (context) => EmblemModal(
                    emblemTap: emblemTap,
                    emblemsList: emblemsLinks,
                    onSaveTap: saveEmblem,
                  ));
        });
  }
}
