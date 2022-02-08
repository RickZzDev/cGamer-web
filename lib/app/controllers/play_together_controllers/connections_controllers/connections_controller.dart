import 'dart:async';
import 'dart:convert';

import 'package:cGamer/app/data/models/play_together_models/connections_model.dart';
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
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'firestore_utils.dart' as utils;

class ConnectionController extends GetxController {
  final ConnectionsRepository repository;
  ConnectionController({required this.repository});

  bool fromHome = false;

  final PageController pageController = PageController();
  Rx<MatchInvitesModel> matchInvitesModel = MatchInvitesModel().obs;
  Rx<FriendInvitesModel> friendInvitesModel = FriendInvitesModel().obs;
  Rx<FriendInvitesModel> friendsModel = FriendInvitesModel().obs;

  var loading = false.obs;
  User? _user;
  Rx<ProfileModel> statusProfileResult = ProfileModel().obs;

  @override
  void onInit() async {
    await getMatchInvites();
    await getFriendInvites();
    await getFriends();
    await getProfile();
    await initializeFlutterFire();
    initializeDateFormatting('pt_BR', null);
    fromHome = Get.arguments['fromHome'];
    super.onInit();
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

  Future<void> getMatchInvites() async {
    loading.value = true;
    try {
      var response = await repository.getMatchInvites();
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        matchInvitesModel.value = response;
        return;
      }

      SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível buscar os convites, volte e tente novamente.",
          title: "Atenção");
      return;
    }
  }

  Future<void> getFriendInvites() async {
    loading.value = true;
    try {
      var response = await repository.getFriendInvites();
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        friendInvitesModel.value = response;
        return;
      }

      SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível buscar os convites, volte e tente novamente.",
          title: "Atenção");
      return;
    }
  }

  Future<void> getFriends() async {
    loading.value = true;
    try {
      var response = await repository.getFriends();
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        friendsModel.value = response;
        return;
      }

      SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível buscar seus amigos, volte e tente novamente.",
          title: "Atenção");
      return;
    }
  }

  Future<void> recuseMatchInvite(MatchInvite? invite) async {
    loading.value = true;
    try {
      var response = await repository.recusedMatchInvite(invite);
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: "Convite para jogar foi recusado com sucesso!",
            title: "Sucesso",
            color: primaryColor);
        await getMatchInvites();
        Timer(Duration(seconds: 2), () {
          Navigator.of(Get.context!).pop();
          Navigator.of(Get.context!).pop();
        });

        return;
      }

      SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível recusar o convite, volte e tente novamente.",
          title: "Atenção");
      return;
    }
  }

  Future<void> recuseFriendInvite(int customerId) async {
    loading.value = true;
    try {
      var response = await repository.recuseFriendInvite(customerId);
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: "O convite de amizade foi recusado!",
            title: "Sucesso",
            color: primaryColor);
        await getFriendInvites();
        await getFriends();
        Timer(Duration(seconds: 2), () {
          Navigator.of(Get.context!).pop();
          Navigator.of(Get.context!).pop();
        });

        return;
      }

      SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível recusar o convite, volte e tente novamente.",
          title: "Atenção");
      return;
    }
  }

  Future<void> openFriendChat(FriendInvite friend) async {
    Map<String, dynamic> mapUser = await _fetchUser(
        friend.firebaseId ?? '', 'users',
        customerId: friend.customerId?.toString());

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

  Future<void> acceptMatchInvite(MatchInvite? invite) async {
    loading.value = true;
    try {
      var response = await repository.acceptMatchInvite(invite);

      if (!ExceptionUtils.verifyIfIsException(response)) {
        Map<String, dynamic> mapUser = await _fetchUser(
            invite?.player?.firebaseId ?? '', 'users',
            customerId: invite?.player?.customerId?.toString());

        types.User otherUser = types.User.fromJson(mapUser);

        final makeRoom = await createRoom(otherUser);
        final room = await FirebaseChatCore.instance.room(makeRoom.id).first;
        loading.value = false;
        await getMatchInvites();
        Navigator.of(Get.context!).pop();
        Navigator.of(Get.context!).push(
          MaterialPageRoute(
            builder: (context) => DirectChatPage(
              room: room,
            ),
          ),
        );
        return;
      }
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: response.message ??
              "Ocorreu um erro ao aceitar o convite, tente novamente mais tarde",
          title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível aceitar o convite, volte e tente novamente.",
          title: "Atenção");
      return;
    }
  }

  Future<void> acceptFriendInvite(FriendInvite? invite) async {
    loading.value = true;
    try {
      var response =
          await repository.acceptFriendInvite(invite?.customerId ?? 0);
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: '${invite?.nickName} entrou na sua lista de amigos!',
            title: 'Parabéns',
            color: primaryColor);
        await getFriendInvites();
        await getFriends();
        Timer(Duration(seconds: 2), () {
          Navigator.of(Get.context!).pop();
          Navigator.of(Get.context!).pop();
        });
        return;
      }
      loading.value = false;
      SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível aceitar o convite, volte e tente novamente.",
          title: "Atenção");
      return;
    }
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
        customerId: statusProfileResult.value.customerId?.toString());

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

  Stream<List<types.Room>> rooms({bool orderByUpdatedAt = false}) {
    final fu = FirebaseChatCore.instance.firebaseUser;

    if (fu == null) return const Stream.empty();

    final collection = orderByUpdatedAt
        ? FirebaseFirestore.instance
            .collection('directs')
            .where('userIds', arrayContains: fu.uid)
            .orderBy('updatedAt', descending: true)
        : FirebaseFirestore.instance
            .collection('directs')
            .where('userIds', arrayContains: fu.uid);

    return collection.snapshots().asyncMap(
          (query) => utils.processRoomsQuery(
            fu,
            query,
            'users',
          ),
        );
  }

  Future<void> initializeFlutterFire() async {
    FirebaseChatCoreConfig config = FirebaseChatCoreConfig("directs", "users");
    FirebaseChatCore.instance.setConfig(config);
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        _user = user;
        String token = await Provider.of<GetStorage>(Get.context, listen: false)
            .read('x-token');
        if (_user == null) {
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
                  metadata: {"token": token.replaceAll("/", "\/")}),
            );

            await repository.saveFirebaseId(credential.user!.uid);
          } catch (e) {
            print(e.toString());
          }
        } else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_user?.uid ?? "x")
              .update({
            'metadata': {'token': token.replaceAll("/", "\/")}
          });

          await repository.saveFirebaseId(_user!.uid);
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
