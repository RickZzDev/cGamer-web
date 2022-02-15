import 'package:cGamer/app/data/models/score_models/buy_badges/buy_badge_model.dart';
import 'package:cGamer/app/data/provider/score_providers/buy_badge_providers/buy_badge_provider.dart';
import 'package:meta/meta.dart';

class BuyBadgeRepository {
  BuyBadgeRepository({required this.provider});
  final BuyBadgeProvider provider;

  Future getBadges() async {
    return await provider.getBadges();
  }

  Future buyBadge(BuyBadgeModelRequest request) async {
    return await provider.buyBadge(request);
  }
}
