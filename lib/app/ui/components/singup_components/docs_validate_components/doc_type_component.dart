import 'package:cGamer/app/controllers/signup/validate_docs/choose_doc_type_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocTypeCard extends StatelessWidget {
  const DocTypeCard({
    required String docType,
    required Color color,
    required ChooseDocTypeController controller,
  })   : _controller = controller,
        _color = color,
        _docType = docType;

  final String _docType;
  final Color _color;
  final ChooseDocTypeController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _docType == "cnh" ? 130 : 100,
      height: 150,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            offset: Offset(2, 2.0), //(x,y)
            blurRadius: 8.0,
          ),
        ],
        color: _color,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(width: 2, color: Theme.of(context).primaryColor),
      ),
      child: SvgPicture.asset(
        "assets/images/docs_images/$_docType.svg",
        color: _controller.checkIconColor(_docType),
      ),
    );
  }
}
