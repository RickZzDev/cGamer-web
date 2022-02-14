import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class AddEditExternCardFirstStepController extends GetxController {
  final CardRepository repository;
  AddEditExternCardFirstStepController({required this.repository});

  MaskedTextController cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
}
