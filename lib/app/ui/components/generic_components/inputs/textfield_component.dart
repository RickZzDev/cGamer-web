import 'package:cGamer/app/controllers/login/login_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final LoginController? loginController;
  final dynamic controller;
  final String? labelText;
  final String? hintText;
  final TextInputType? type;
  final Key? key;
  final Function? validation;
  final Function? onChange;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final bool obscureText;
  final bool autoFocus;
  final String? value;
  final bool enabled;
  final bool isLoginCpfField;
  final AutovalidateMode validateMode;
  final TextStyle labelStyle;
  final Function()? onKeyboardGo;
  final TextStyle hintStyle;
  final double fontSize;
  final Icon? sufixIcon;
  final int? maxLength;
  final bool darkMode;
  final Color txtColor;
  final bool isBold;
  final Color borderEnabledColor;
  final FocusNode? focusNode;
  final Widget? prefixIcon;

  final Color disabledTextColor;
  final TextCapitalization textCapitalization;

  CustomTextField(
      {this.loginController,
      this.controller,
      this.focusNode,
      this.prefixIcon,
      this.key,
      this.type,
      this.onKeyboardGo,
      this.sufixIcon,
      @required this.labelText,
      this.hintText,
      this.fontSize = 16,
      this.obscureText = false,
      this.hintStyle = textStyle,
      this.disabledTextColor = Colors.grey,
      this.autoFocus = true,
      this.isLoginCpfField = false,
      this.onChange,
      this.onFieldSubmitted,
      this.onTap,
      this.value,
      this.isBold = false,
      this.labelStyle = const TextStyle(
          color: Colors.grey, fontSize: 14, height: 0, fontFamily: 'Exo'),
      this.enabled = true,
      this.validateMode = AutovalidateMode.always,
      this.validation,
      this.maxLength,
      this.textCapitalization = TextCapitalization.none,
      this.txtColor = Colors.white,
      this.borderEnabledColor = Colors.white,
      this.darkMode = false});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePassword = false;
  bool enabledEditText = true;
  @override
  void initState() {
    hidePassword = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: widget.key,
      focusNode: widget.focusNode != null ? widget.focusNode : null,
      enableInteractiveSelection: true,
      autofocus: widget.autoFocus,
      onFieldSubmitted: widget.onFieldSubmitted,
      autovalidateMode: widget.validateMode,
      controller: widget.controller,
      obscureText: hidePassword,
      keyboardType: widget.type,
      initialValue: widget.value,
      onTap: widget.onTap,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      onEditingComplete: widget.onKeyboardGo != null
          ? () => widget.onKeyboardGo!()
          : () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
      textCapitalization: widget.textCapitalization,
      buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) =>
          SizedBox(),
      keyboardAppearance: Brightness.dark,
      validator: widget.validation != null
          ? (value) => widget.validation!(value)
          : null,
      style: TextStyle(
          color: widget.enabled ? widget.txtColor : widget.disabledTextColor,
          fontSize: widget.fontSize,
          fontWeight: widget.isBold ? FontWeight.bold : FontWeight.normal),
      decoration: InputDecoration(
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.darkMode ? secondaryColor : primaryColor,
          ),
        ),
        contentPadding: EdgeInsets.only(bottom: 0),
        hintText: widget.hintText == null ? '' : widget.hintText,
        hintStyle: widget.hintStyle,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.darkMode ? secondaryColor : widget.borderEnabledColor,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.darkMode ? secondaryColor : Colors.white,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.darkMode ? secondaryColor : widget.borderEnabledColor,
          ),
        ),
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        prefix: widget.prefixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: widget.prefixIcon,
              )
            : null,
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: () {
                  setState(
                    () {
                      hidePassword = !hidePassword;
                    },
                  );
                },
                child: Icon(
                  hidePassword ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : widget.sufixIcon != null
                ? widget.sufixIcon
                : null,
      ),
      onChanged: (value) {
        widget.isLoginCpfField
            ? widget.loginController?.verifyCpfToChangePage(value)
            : widget.onChange != null
                ? widget.onChange!(value)
                : DoNothingAction();
      },
    );
  }
}
