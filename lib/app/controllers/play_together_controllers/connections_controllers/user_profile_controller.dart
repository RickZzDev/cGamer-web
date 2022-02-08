import 'dart:async';
import 'dart:convert';

import 'package:cGamer/app/data/models/profile_model/profile_model.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/connections_repository.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/chat/direct_chat.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

import 'package:cGamer/app/utils/utils_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class UserProfileController extends GetxController {
  final ConnectionsRepository repository;
  UserProfileController({required this.repository});

  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;
  Rx<ProfileModel> myProfileModel = ProfileModel().obs;

  var loading = false.obs;
  int customerId = -1;
  int myCustomerId = -1;

  @override
  void onInit() async {
    customerId = Get.arguments['customerId'];
    String myCustomerIdString =
        await Provider.of<GetStorage>(Get.context, listen: false)
            .read('x-customerId');
    myCustomerId = int.parse(myCustomerIdString);
    await getUserProfile();
    super.onInit();
  }

  Future<bool> getUserProfile() async {
    loading.value = true;
    try {
      var response = await repository.getUserProfile(customerId);
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: response.message ??
                "Algo de errado aconteceu, tente novamente.",
            title: "Atenção");

        return false;
      }
      this.userProfileModel.value = response;
      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      return false;
    }
  }

  Future<bool> getMyProfile() async {
    try {
      var response = await repository.getProfile();
      myProfileModel.value = ProfileModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      CacheUtils.addToCache(
          key: 'x-customerId',
          value: myProfileModel.value.customerId.toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFriend() async {
    loading.value = true;
    try {
      var response = await repository.removeFriend(customerId);
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: response.message ??
                "Algo de errado aconteceu, tente novamente.",
            title: "Atenção");

        return false;
      }
      SnackBarUtils.showSnackBar(
          desc: "Seu amigo foi removido com sucesso.",
          title: "Parabéns",
          color: primaryColor);
      userProfileModel.value.statusInvite = null;
      userProfileModel.refresh();
      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      return false;
    }
  }

  Future<bool> sendInviteFriend() async {
    loading.value = true;
    try {
      var response = await repository.sendInviteFriend(customerId);
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: response.message ??
                "Algo de errado aconteceu, tente novamente.",
            title: "Atenção");

        return false;
      }
      SnackBarUtils.showSnackBar(
          desc: "O convite de amizade foi enviado com sucesso.",
          title: "Parabéns",
          color: primaryColor);
      userProfileModel.value.statusInvite = "PENDING";
      userProfileModel.refresh();

      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      return false;
    }
  }

  Future<void> sendMessageUser() async {
    Map<String, dynamic> mapUser = await _fetchUser(
        userProfileModel.value.firebaseId ?? '', 'users',
        customerId: userProfileModel.value.customerId?.toString());

    types.User otherUser = types.User.fromJson(mapUser);

    final makeRoom = await createRoom(otherUser);
    final room = await FirebaseChatCore.instance.room(makeRoom.id).first;
    loading.value = false;

    Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => DirectChatPage(
          room: room,
        ),
      ),
    );
    return;
  }

  Future<Map<String, dynamic>> _fetchUser(
    String userId,
    String usersCollectionName, {
    String? role,
    String? customerId,
  }) async {
    final doc = await FirebaseFirestore.instance
        .collection(usersCollectionName)
        .doc(userId)
        .get();

    final data = doc.data()!;

    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['id'] = doc.id;
    data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
    data['role'] = role;
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;
    data['metadata'] = {'customerId': customerId};
    return data;
  }

  Future<types.Room> createRoom(
    types.User otherUser, {
    Map<String, dynamic>? metadata,
  }) async {
    final fu = FirebaseChatCore.instance.firebaseUser;

    if (fu == null) return Future.error('User does not exist');

    final query = await FirebaseFirestore.instance
        .collection('directs')
        .where('userIds', arrayContains: fu.uid)
        .get();

    final rooms = await processRoomsQuery(fu, query, 'users');

    try {
      return rooms.firstWhere((room) {
        if (room.type == types.RoomType.group) return false;

        final userIds = room.users.map((u) => u.id);
        return userIds.contains(fu.uid) && userIds.contains(otherUser.id);
      });
    } catch (e) {
      // Do nothing if room does not exist
      // Create a new room instead
    }

    final currentUser = await _fetchUser(fu.uid, 'users',
        customerId: myProfileModel.value.customerId?.toString());

    final users = [types.User.fromJson(currentUser), otherUser];
    metadata = Map<String, dynamic>();

    users.forEach((u) {
      metadata?[u.id] = u.metadata?['customerId'];
    });

    final room = await FirebaseFirestore.instance.collection('directs').add({
      'createdAt': FieldValue.serverTimestamp(),
      'imageUrl': null,
      'metadata': metadata,
      'name': null,
      'type': types.RoomType.direct.toShortString(),
      'updatedAt': FieldValue.serverTimestamp(),
      'userIds': users.map((u) => u.id).toList(),
      'userRoles': null,
    });

    return types.Room(
      id: room.id,
      metadata: metadata,
      type: types.RoomType.direct,
      users: users,
    );
  }
}
