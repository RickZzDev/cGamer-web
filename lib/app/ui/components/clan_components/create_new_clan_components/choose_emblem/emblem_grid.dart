import 'package:cGamer/app/controllers/clan_controllers/create_new_clan_controller.dart';
import 'package:cGamer/app/data/models/clans_models/clan_emblems_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components.dart';

class EmblemGrid extends StatelessWidget {
  final Function(int) emblemTap;
  final List<EmblemGridItemModel> models;

  EmblemGrid({required this.emblemTap, required this.models});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: models.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              emblemTap(models[index].id);
            },
            child: Obx(() => EmblemGridItem(models[index]))));
  }
}
