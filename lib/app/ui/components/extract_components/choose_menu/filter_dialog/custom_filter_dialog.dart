import 'package:cGamer/app/controllers/extract/extract_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components.dart';

class CustomDialogFilter extends StatefulWidget {
  final ExtractController extractController;

  CustomDialogFilter({required this.extractController});

  @override
  _CustomDialogFilterState createState() => _CustomDialogFilterState();
}

class _CustomDialogFilterState extends State<CustomDialogFilter> {
  TextEditingController _initialController = TextEditingController();
  TextEditingController _finalController = TextEditingController();
  @override
  void initState() {
    if (_finalController.text.isEmpty &&
        widget.extractController.finalDateValue == null) {
      _finalController.text =
          widget.extractController.dateFormatter(DateTime.now(), true);
      widget.extractController.finalDateValue =
          widget.extractController.dateFormatter(DateTime.now(), false);
      widget.extractController.finalController = _finalController;
    }
    if (_initialController.text.isEmpty &&
        widget.extractController.initialDateValue == null) {
      _initialController.text = widget.extractController.getInitialDayOnInit();
      widget.extractController.initialController = _initialController;
    }

    if (widget.extractController.isManuallyChoose.value) {
      widget.extractController.atualCustomFilterChooseItem.value = 5;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Builder(builder: (context) {
        return Container(
          width: Get.width,
          //color: Colors.red,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () => Get.back()),
                ],
              ),
              Container(
                width: screenWidthhSize,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border.all(color: primaryColor, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Período",
                            style: textStyle,
                          ),
                          Expanded(
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              Get.width / (Get.height / 7)),
                                  itemCount: widget.extractController
                                      .customFilterChooseItens.length,
                                  itemBuilder: (context, index) {
                                    return Obx(() => FilterDialogGridItem(
                                          onTap: () {
                                            widget
                                                .extractController
                                                .atualCustomFilterChooseItem
                                                .value = index;
                                            widget.extractController
                                                .syncButtonWithDateValues(
                                                    index);
                                          },
                                          index: index,
                                          atualChoose: widget
                                              .extractController
                                              .atualCustomFilterChooseItem
                                              .value,
                                          title: widget.extractController
                                              .customFilterChooseItens[index],
                                        ));
                                  }))
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            'Selecionar dias',
                            style: textStyle,
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _CustomTextField(
                                onTap: () => widget.extractController
                                    .getDateFromMap(true, context: context),
                                textEditingController:
                                    widget.extractController.initialController!,
                                title: 'Data Inicial',
                              ),
                              _CustomTextField(
                                  onTap: () => widget.extractController
                                      .getDateFromMap(false, context: context),
                                  textEditingController:
                                      widget.extractController.finalController!,
                                  title: 'Data Final'),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    SizedBox(
                        width: screenWidthhSize * 0.5,
                        height: 35,
                        child: GenericButton(
                            color: primaryColor,
                            text: 'Aplicar Filtros',
                            txtColor: secondaryColor,
                            onPressedFunction:
                                () async =>
                                    widget.extractController.verification()
                                        ? widget.extractController
                                            .getCustomExtract(
                                                widget.extractController
                                                        .initialDateValue ??
                                                    "",
                                                widget.extractController
                                                        .finalDateValue ??
                                                    "")
                                            .whenComplete(() => Get.back())
                                        : null))
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final TextEditingController textEditingController;

  _CustomTextField(
      {this.title, this.onTap, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: TextFormField(
        enabled: false,
        controller: textEditingController,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            hintText: title ?? "",
            hintStyle: TextStyle(color: Colors.white)),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
