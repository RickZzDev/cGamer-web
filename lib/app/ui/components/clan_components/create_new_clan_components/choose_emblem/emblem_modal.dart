import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/controllers/clan_controllers/create_new_clan_controller.dart';
import 'package:cGamer/app/data/models/clans_models/clan_emblems_model.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components.dart';

class EmblemModal extends StatelessWidget {
  final Function(int) emblemTap;
  final VoidCallback onSaveTap;
  final List<EmblemGridItemModel> emblemsList;
  EmblemModal(
      {required this.emblemTap,
      required this.emblemsList,
      required this.onSaveTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: screenHeigthSize * 0.85,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Escolha o emblema do seu clã',
                style: textStyle.copyWith(fontSize: 18),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              )
            ],
          ),
          Expanded(
              child: EmblemGrid(
            models: this.emblemsList,
            emblemTap: this.emblemTap,
          )),
          Divider(
            color: Colors.white,
          ),
          Padding(
              padding: EdgeInsets.only(bottom: Platform.isIOS ? 24 : 0),
              child: Container(
                height: 40,
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: primaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      child: Container(
                          child: Center(
                              child: AutoSizeText(
                        "Cancelar",
                        minFontSize: 10,
                        maxFontSize: 12,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ))),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: OutlinedButton(
                          onPressed: onSaveTap,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: primaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                "Salvar",
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
