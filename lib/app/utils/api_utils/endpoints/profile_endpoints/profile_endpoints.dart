import 'package:cGamer/app/utils/api_utils/api_path.dart';

abstract class ProfileEndpoint {
  static String url = "/customer/profile";

  static String profileGames = '/customer/games';

  static String profileSelectedGames = '/customer/games';

  static String saveFirebaseId(String firebaseId) =>
      "/customer/firebase-id/$firebaseId";

  static String getGamersList = '/customer/profile/search';
  static String sendInviteFriend(int customerId) =>
      '/customer/profile/$customerId';
  static String removeFriend(int customerId) => '/customer/profile/$customerId';
}
