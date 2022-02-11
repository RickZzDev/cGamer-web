import 'package:cGamer/app/data/models/play_together_models/connections_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/play_together_endpoints/connections_endpoint.dart';

class ConnectionsProvider {
  final Requester requester;
  ConnectionsProvider(this.requester);

  Future<dynamic> getMatchInvites() async {
    var response = await requester.fetch(
        url: ConnectionsEndpoints.getMatchInvites,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getFriendInvites() async {
    Map<String, String> _params = {'status': 'PENDING'};
    var response = await requester.fetch(
        url: ConnectionsEndpoints.getFriendInvites,
        params: _params,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getFriends() async {
    Map<String, String> _params = {'status': 'ACCEPT'};
    var response = await requester.fetch(
        url: ConnectionsEndpoints.getFriendInvites,
        params: _params,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getUserProfile(int customerId) async {
    var response = await requester.fetch(
        url: ConnectionsEndpoints.getUserProfile(customerId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> recuseMatchInvite(MatchInvite? invite) async {
    var response = await requester.put(
        url: ConnectionsEndpoints.recuseMatchInvite(invite),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> acceptMatchInvite(MatchInvite? invite) async {
    var url = ConnectionsEndpoints.acceptMatchInvite(invite);
    var response = await requester.put(
        url: url, header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> acceptFriendInvite(int customerId) async {
    var response = await requester.put(
        url: ConnectionsEndpoints.acceptFriendInvite(customerId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> recuseFriendInvite(int customerId) async {
    var response = await requester.put(
        url: ConnectionsEndpoints.recuseFriendInvite(customerId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getProfile() async {
    var response = await Requester().fetch(
        url: ProfileEndpoint.url,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  saveFirebaseId(String firebaseId) async {
    var response = await Requester().put(
        url: ProfileEndpoint.saveFirebaseId(firebaseId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getGamersList(String query) async {
    Map<String, String> _params = {'name': query};
    try {
      var response = await requester.fetch(
          url: ProfileEndpoint.getGamersList,
          header: await Headers().getAuthenticatedHeader(),
          params: _params);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  sendInviteFriend(int customerId) async {
    var response = await Requester().post(
        url: ProfileEndpoint.sendInviteFriend(customerId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  removeFriend(int customerId) async {
    var response = await Requester().delete(
        url: ProfileEndpoint.removeFriend(customerId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
