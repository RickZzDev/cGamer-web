import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class VirtualCardPasswordController extends GetxController {
  final CardRepository repository;
  VirtualCardPasswordController({required this.repository});

  TextEditingController passwordController = TextEditingController();
}
