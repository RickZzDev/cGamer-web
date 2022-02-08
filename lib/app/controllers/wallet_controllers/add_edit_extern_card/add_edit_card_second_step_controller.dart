import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class AddEditCardSecondStepController extends GetxController {
  final CardRepository repository;
  AddEditCardSecondStepController({required this.repository});

  MaskedTextController cpfTextController =
      MaskedTextController(mask: '000.000.000-00');

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
