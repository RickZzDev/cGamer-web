import 'dart:io';

import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoBox extends StatelessWidget {
  const PhotoBox(
      {Key? key,
      required bool frontSide,
      required String file,
      required String docType})
      : _docType = docType,
        _frontSide = frontSide,
        _file = file,
        super(key: key);

  final String _docType;
  final String _file;
  final bool _frontSide;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 170,
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8),
              offset: Offset(2, 2.0), //(x,y)
              blurRadius: 8.0,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(width: 2, color: Theme.of(context).primaryColor)),
      child: _file != ""
          ? ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.file(
                File(_file),
                fit: BoxFit.fill,
              ),
            )
          : Center(
              child: Text(
                _frontSide
                    ? " Frente do documento ${_docType.toUpperCase()}"
                    : "Verso do documento ${_docType.toUpperCase()}",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 14),
              ),
            ),
    );
  }
}
