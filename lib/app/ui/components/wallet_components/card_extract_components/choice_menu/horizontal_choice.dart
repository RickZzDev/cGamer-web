import 'dart:async';

import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HorizontalChoiceComponent extends StatefulWidget {
  final Function(int) onTap;
  final List<ItemModel>? menuList;
  final double? width;

  List<ItemModel> items = [
    ItemModel(0, true, "Todos"),
    ItemModel(1, false, "Entrada"),
    ItemModel(2, false, "Saída"),
  ];

  HorizontalChoiceComponent({required this.onTap, this.menuList, this.width});
  @override
  _HorizontalChoiceComponentState createState() =>
      _HorizontalChoiceComponentState();
}

class _HorizontalChoiceComponentState extends State<HorizontalChoiceComponent> {
  List<StreamController<ItemModel>>? streams;
  List<ItemModel>? items;

  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    items = widget.menuList == null ? widget.items : widget.menuList;
    streams = createStreams((items?.length ?? 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        width: widget.width == null ? Get.width : widget.width,
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: buildContent(),
        ));
  }

  List<Widget> buildContent() {
    List<Widget> content = <Widget>[];

    if (widget.menuList == null) {
      for (int index = 0; index < widget.items.length; index++) {
        content.add(
          Expanded(
            flex: 1,
            child: ItemChoice(
              items?[index],
              stream: streams?[index].stream,
              onTap: (index) {
                updateList(index);
                widget.onTap(index);
              },
            ),
          ),
        );
      }
    } else {
      for (int index = 0; index < (items?.length ?? 0); index++) {
        content.add(
          Expanded(
            flex: 1,
            child: ItemChoice(
              items?[index],
              stream: streams?[index].stream,
              onTap: (index) {
                updateList(index);
                widget.onTap(index);
              },
            ),
          ),
        );
      }
    }
    return content;
  }

  void updateList(int index) {
    if (widget.menuList == null) {
      widget.items.forEach((element) {
        if (index == element.index) {
          element.isSelected = true;
        } else {
          element.isSelected = false;
        }

        streams?.forEach((element) {
          element.sink.add(
              widget.menuList == null ? widget.items[index] : items![index]);
        });
      });
    } else {
      items?.forEach((element) {
        if (index == element.index) {
          element.isSelected = true;
        } else {
          element.isSelected = false;
        }

        streams?.forEach((element) {
          element.sink.add(
              widget.menuList == null ? widget.items[index] : items![index]);
        });
      });
    }
  }
}

class ItemChoice extends StatefulWidget {
  ItemModel? _itemModel;
  final Stream<ItemModel>? stream;
  ItemChoice(this._itemModel, {required this.onTap, required this.stream});
  Function(int) onTap;
  @override
  _ItemChoiceState createState() => _ItemChoiceState();
}

class _ItemChoiceState extends State<ItemChoice> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.onTap(widget._itemModel?.index ?? -1);
          });
        },
        child: StreamBuilder<ItemModel>(
          stream: widget.stream,
          initialData: widget._itemModel,
          builder: (context, snapshot) {
            return Container(
              height: 30,
              decoration: BoxDecoration(
                  color: widget._itemModel?.isSelected ?? false
                      ? primaryColor
                      : secondaryColor,
                  borderRadius: BorderRadius.circular(9)),
              child: Center(
                  child: Text(
                widget._itemModel?.title ?? "",
                style: textStyle.copyWith(fontSize: 14),
              )),
            );
          },
        ));
  }
}

class ItemModel {
  int index;
  bool isSelected;
  String title;
  ItemModel(this.index, this.isSelected, this.title);
}

List<StreamController<ItemModel>> createStreams(int? index) {
  List<StreamController<ItemModel>> streamList = [];
  for (int i = 0; i < (index ?? 0); i++) {
    streamList.add(new StreamController<ItemModel>());
  }
  return streamList;
}
