import 'dart:convert';

import 'package:cGamer/app/data/models/play_together_models/connections_model.dart';
import 'package:cGamer/app/data/models/profile_model/profile_model.dart';
import 'package:cGamer/app/data/provider/play_together_providers/connections_provider.dart';

class ConnectionsRepository {
  final ConnectionsProvider provider;
  ConnectionsRepository(this.provider);

  Future<dynamic> getMatchInvites() async {
    try {
      dynamic response = await provider.getMatchInvites();
      MatchInvitesModel model = MatchInvitesModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getFriendInvites() async {
    try {
      dynamic response = await provider.getFriendInvites();
      FriendInvitesModel model = FriendInvitesModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getFriends() async {
    try {
      dynamic response = await provider.getFriends();
      FriendInvitesModel model = FriendInvitesModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> recusedMatchInvite(MatchInvite? invite) async {
    try {
      dynamic response = await provider.recuseMatchInvite(invite);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> acceptMatchInvite(MatchInvite? invite) async {
    try {
      dynamic response = await provider.acceptMatchInvite(invite);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> acceptFriendInvite(int customerId) async {
    try {
      dynamic response = await provider.acceptFriendInvite(customerId);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getUserProfile(int customerId) async {
    try {
      dynamic response = await provider.getUserProfile(customerId);
      UserProfileModel model = UserProfileModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> recuseFriendInvite(int customerId) async {
    try {
      dynamic response = await provider.recuseFriendInvite(customerId);
      return response;
    } catch (e) {
      throw e;
    }
  }

  getProfile() async {
    return await provider.getProfile();
  }

  saveFirebaseId(String firebaseId) async {
    return await provider.saveFirebaseId(firebaseId);
  }

  Future<dynamic> getGamersList(String query) async {
    try {
      var response = await provider.getGamersList(query);
      return GamersListModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> sendInviteFriend(int customerId) async {
    try {
      dynamic response = await provider.sendInviteFriend(customerId);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> removeFriend(int customerId) async {
    try {
      dynamic response = await provider.removeFriend(customerId);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
