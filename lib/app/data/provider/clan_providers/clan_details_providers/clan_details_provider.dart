import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/clan_endpoints/clan_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:flutter/foundation.dart';

class ClanDetailsProvider {
  final Requester requester;
  ClanDetailsProvider({required this.requester});

  Future<dynamic> getClanDetails(String id) async {
    var response = await requester.fetch(
        url: ClanEndpoints.getClanDetailsUrl(id),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> requestEntry(String id) async {
    var response = await requester.post(
        url: ClanEndpoints.requestEntry(id),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getRequestEntry(String id) async {
    var response = await requester.fetch(
        url: ClanEndpoints.requestEntry(id),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> approveMember(String id, String customerId) async {
    var response = await requester.put(
        url: ClanEndpoints.approveMember(id, customerId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> promoveMember(
      String roleName, String id, String customerId) async {
    var response = await requester.put(
        url: ClanEndpoints.promoveMember(id, customerId, roleName),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> removeMember(String id, String customerId) async {
    var response = await requester.delete(
        url: ClanEndpoints.removeMember(id, customerId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> reproveMember(String id, String customerId) async {
    var response = await requester.delete(
        url: ClanEndpoints.reproveMember(id, customerId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> updateCla(String id, CreateClanModel model) async {
    var response = await requester.put(
        url: ClanEndpoints.putEditClanUrl(id),
        header: await Headers().getAuthenticatedHeader(),
        body: model.toJson());
    return response;
  }

  Future<dynamic> leftCla(String id) async {
    var response = await requester.delete(
        url: ClanEndpoints.leftCla(id),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getProfile() async {
    var response = await Requester().fetch(
        url: ProfileEndpoint.url,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getEmblems() async {
    var response = await requester.fetch(
        url: ClanEndpoints.getEmblems,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getPlayWinTrophys() async {
    var response = await requester.fetch(
        url: ClanEndpoints.getPlayWinTrophys,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> rescueTrophy() async {
    var response = await requester.post(
        url: ClanEndpoints.rescueTrophy,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> saveFirebaseId(String firebaseId) async {
    var response = await requester.put(
        url: ProfileEndpoint.saveFirebaseId(firebaseId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
