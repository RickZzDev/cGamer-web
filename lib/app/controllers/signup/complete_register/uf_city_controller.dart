import 'package:cGamer/app/data/repository/sign_up_repositories/adress_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class UfCityController extends GetxController {
  var validatingCep = false.obs;
  final selectValue = 'UF'.obs;
  final selectCityValue = 'Escolha seu UF'.obs;

  final formKey = GlobalKey<FormState>();

  final AdreessRepository repository;
  UfCityController({required this.repository});
}
