import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class CardsOverViewController extends GetxController {
  final CardRepository repository;
  CardsOverViewController({required this.repository});

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
