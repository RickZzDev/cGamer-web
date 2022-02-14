import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownComponent extends StatelessWidget {
  final String? value;
  final Function onChangeFunction;
  final List<dynamic> items;
  final String? txt;
  final bool hasPreviousValue;

  DropdownComponent({
    required this.value,
    required this.onChangeFunction,
    required this.items,
    this.hasPreviousValue = false,
    required this.txt,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      icon: Icon(Icons.keyboard_arrow_down),
      iconDisabledColor: Colors.grey,
      iconEnabledColor: Theme.of(context).primaryColor,
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      style: TextStyle(color: Colors.white),
      dropdownColor: Theme.of(context).accentColor,
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      onChanged: (String? newValue) {
        onChangeFunction(newValue);
      },
      hint: Text(
        txt ?? "",
        style: TextStyle(color: Colors.white),
      ),
      items: hasPreviousValue
          ? null
          : items.map<DropdownMenuItem<String>>((dynamic value) {
              return DropdownMenuItem<String>(
                value: txt == "UF" ? value.sigla : value.nome,
                child: Text(txt == "UF" ? value.sigla : value.nome),
              );
            }).toList(),
    );
  }
}
