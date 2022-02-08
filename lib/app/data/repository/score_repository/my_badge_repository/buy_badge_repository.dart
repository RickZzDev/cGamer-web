import 'package:cGamer/app/data/models/score_models/buy_badges/my_badges_model.dart';
import 'package:cGamer/app/data/provider/score_providers/my_badge_providers/buy_badge_provider.dart';
import 'package:meta/meta.dart';

class MyBadgeRepository {
  MyBadgeRepository({required this.provider});
  final MyBadgeProvider provider;

  Future getBadges() async {
    return await provider.getBadges();
  }

  Future chooseBadge(MyBadgeModelRequest request) async {
    return await provider.chooseBadge(request);
  }
}
