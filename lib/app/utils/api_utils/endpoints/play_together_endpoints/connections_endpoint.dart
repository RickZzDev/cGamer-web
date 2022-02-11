import 'package:cGamer/app/data/models/play_together_models/connections_model.dart';

abstract class ConnectionsEndpoints {
  static String getMatchInvites = '/playtogether/invite-player';
  static String recuseMatchInvite(MatchInvite? invite) =>
      '/playtogether/${invite?.platformId}/${invite?.gameId}/invite-player/${invite?.player?.customerId}/RECUSED';
  static String acceptMatchInvite(MatchInvite? invite) =>
      '/playtogether/${invite?.platformId}/${invite?.gameId}/invite-player/${invite?.player?.customerId}/ACCEPT';

  static String getFriendInvites = '/customer/profile/invites';
  static String getFriends = '/customer/profile/invites';
  static String acceptFriendInvite(int customerId) =>
      '/customer/profile/invites/$customerId/ACCEPT';
  static String recuseFriendInvite(int customerId) =>
      '/customer/profile/invites/$customerId/RECUSED';
  static String getUserProfile(int customerId) =>
      '/customer/profile/$customerId';
}
