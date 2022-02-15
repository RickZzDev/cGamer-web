// import 'package:cGamer/app/routes/app_routes.dart';
// import 'package:cGamer/app/ui/components/components.dart';
// import 'package:cGamer/app/ui/components/wallet_components/custom_body_widget.dart';
// import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
// import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_credit_card_detector/flutter_credit_card_detector.dart';
// import 'package:get/get.dart';

// class MyCreditCardWidget extends StatefulWidget {
//   final String labelTextNum;
//   final String labelTextName;
//   final String labelTextExpData;
//   final String labelTextCVV;
//   final String labelTextButton;
//   final String titleCreditCard; // body_widget
//   final String labelTextValidate; // body_widget
//   final String textRequired; // Controller
//   final String textSelectBand; // Controller
//   final String textNameMin; // Controller
//   final String textIntroNameValid; // Controller
//   final String textCardExpired; // Controller
//   final String textInvalidateMonth; // Controller
//   final Color colorButton;
//   final Color colorTextButton;
//   final Color colorTextField;
//   final Color colorCardSelect; // body_widget
//   final Color colorCreditWhite; // body_widget
//   final Color colorCreditBlack; // body_widget
//   final List<String> listBand;
//   final Function() onTap;

//   const MyCreditCardWidget(
//       {Key key,
//       this.labelTextNum = 'Numero do cartão',
//       this.labelTextName = 'Nome no cartão',
//       this.labelTextExpData = 'MM/YY',
//       this.labelTextCVV = 'CVV/CVC',
//       this.labelTextButton = 'Efetuar pagamento',
//       this.titleCreditCard = 'Cartão de Crédito',
//       this.labelTextValidate = 'Valido Até',
//       this.textRequired = 'Campo é obrigatorio',
//       this.textSelectBand = 'Selecione a bandeira',
//       this.textNameMin = 'O nome de conter pelo menos 6 caracteres',
//       this.textIntroNameValid = 'Insira um nome válido',
//       this.textCardExpired = 'Cartão vencido',
//       this.textInvalidateMonth = 'Mês incorreto.',
//       this.colorButton = const Color(0xFFfec177),
//       this.colorTextButton = Colors.white,
//       this.colorTextField = Colors.grey,
//       this.colorCardSelect = const Color(0xFFfec177),
//       this.colorCreditWhite = const Color(0xff535252),
//       this.colorCreditBlack = const Color(0xff211e1e),
//       this.listBand = const [
//         'visa',
//         'mastercard',
//         'amex',
//         'elo',
//         'dinersclub',
//         'discover',
//         'jcb',
//         'aura',
//         'hiper',
//         'hipercard',
//         'rupay'
//       ],
//       this.onTap})
//       : super(key: key);

//   @override
//   _MyCreditCardWidgetState createState() => _MyCreditCardWidgetState();
// }

// class _MyCreditCardWidgetState extends State<MyCreditCardWidget> {
//   FocusNode _numFocus = FocusNode();
//   FocusNode _nameFocus = FocusNode();
//   FocusNode _expDateFocus = FocusNode();
//   FocusNode _cvvFocus = FocusNode();

//   final _ccNum = MaskedTextController(mask: "0000 0000 0000 0000");
//   final _nome = TextEditingController();
//   final _expData = MaskedTextController(mask: "00/00");
//   final _cvv = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     creditCardNumber = '';
//     creditCardName = '';
//     creditCardExpData = '';
//     creditCardCVV = '';
//     creditCardBand = '';

//     textRequired = widget.textRequired;
//     textSelectBand = widget.textSelectBand;
//     textNameMin = widget.textNameMin;
//     textIntroNameValid = widget.textIntroNameValid;
//     textCardExpired = widget.textCardExpired;
//     textInvalidateMonth = widget.textInvalidateMonth;

//     listBand = widget.listBand;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<Controller>(context);

//     controller.creditCard.number = _ccNum.text == '' ? '' : _ccNum.text;
//     controller.creditCard.name = _nome.text == '' ? '' : _nome.text;
//     controller.creditCard.expData = _expData.text == '' ? '' : _expData.text;
//     controller.creditCard.cvv = _cvv.text == '' ? '' : _cvv.text;

//     _textFormField(
//         {width,
//         controllerTextField,
//         keyboardType,
//         textInputAction,
//         maxLength,
//         focusNode,
//         onChanged,
//         textCapitalization,
//         nextFocusNode,
//         labelText,
//         validator,
//         hasSuffixIcon,
//         String Function() errorText}) {
//       return Container(
//         width: width,
//         margin: EdgeInsets.only(bottom: 16),
//         child: TextFormField(
//           controller: controllerTextField,
//           keyboardType: keyboardType,
//           textInputAction: textInputAction,
//           maxLength: maxLength,
//           focusNode: focusNode,
//           onChanged: onChanged,
//           textCapitalization: textCapitalization,
//           validator: (value) => validator(),
//           // ignore: deprecated_member_use
//           inputFormatters: [BlacklistingTextInputFormatter(RegExp(r'[.,]'))],
//           autovalidateMode: AutovalidateMode.onUserInteraction,

//           // onFieldSubmitted: (v) {
//           //   if (controller.isValid) {
//           //     creditCardNumber =
//           //         controller.creditCard.number.replaceAll(' ', '');
//           //     creditCardName = controller.creditCard.name;
//           //     creditCardExpData = controller.creditCard.expData;
//           //     creditCardCVV = controller.creditCard.cvv;
//           //     creditCardBand = controller.validateIconBand();

//           //     widget.onTap();
//           //   } else {
//           //     return null;
//           //   }
//           // },
//           onEditingComplete: () {
//             FocusScope.of(context).requestFocus(nextFocusNode);
//           },

//           style: TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             counterText: "",
//             disabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: secondaryColor,
//               ),
//             ),
//             suffixIcon: hasSuffixIcon
//                 ? SizedBox(
//                     width: 24,
//                     height: 24,
//                     child: Observer(builder: (_) {
//                       return _iconBand(controller);
//                     }),
//                   )
//                 : null,
//             contentPadding: EdgeInsets.only(bottom: 0),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.white,
//               ),
//             ),
//             border: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.white,
//               ),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.white,
//               ),
//             ),
//             labelText: labelText,
//             labelStyle: TextStyle(color: widget.colorTextField),
//           ),
//           // autovalidateMode: AutovalidateMode.onUserInteraction,
//         ),
//       );
//     }

//     return SingleChildScrollView(
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: mediaQuery(context, 0.025)),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: <Widget>[
//               // CustomBodyWidget(
//               //   titleCreditCard: widget.titleCreditCard,
//               //   labelTextValidate: widget.labelTextValidate,
//               //   colorCardSelect: widget.colorCardSelect,
//               //   colorCreditWhite: widget.colorCreditWhite,
//               //   colorCreditBlack: widget.colorCreditBlack,
//               //   // listBand: widget.listBand,
//               // ),

//               // BodyWidget(
//               //   titleCreditCard: widget.titleCreditCard,
//               //   labelTextValidate: widget.labelTextValidate,
//               //   colorCardSelect: widget.colorCardSelect,
//               //   colorCreditWhite: widget.colorCreditWhite,
//               //   colorCreditBlack: widget.colorCreditBlack,
//               //   // listBand: widget.listBand,
//               // ),
//               SizedBox(height: 24),
//               _textFormField(
//                   controllerTextField: _ccNum,
//                   keyboardType: TextInputType.number,
//                   textInputAction: TextInputAction.next,
//                   maxLength: 19,
//                   focusNode: _numFocus,
//                   onChanged: controller.creditCard.changeNumero,
//                   textCapitalization: TextCapitalization.none,
//                   nextFocusNode: _nameFocus,
//                   labelText: widget.labelTextNum,
//                   validator: controller.validateNumero,
//                   errorText: controller.validateNumero,
//                   hasSuffixIcon: true),

//               // Observer(
//               //     name: 'Numero do cartão',
//               //     builder: (_) {
//               //       return _textFormField(
//               //           controllerTextField: _ccNum,
//               //           keyboardType: TextInputType.number,
//               //           textInputAction: TextInputAction.next,
//               //           maxLength: 19,
//               //           focusNode: _numFocus,
//               //           onChanged: controller.creditCard.changeNumero,
//               //           textCapitalization: TextCapitalization.none,
//               //           nextFocusNode: _nameFocus,
//               //           labelText: widget.labelTextNum,
//               //           validator: controller.validateNumero,
//               //           errorText: controller.validateNumero);
//               //     }),
//               SizedBox(height: 8),
//               _textFormField(
//                 controllerTextField: _nome,
//                 validator: controller.validateName,
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//                 maxLength: 25,
//                 focusNode: _nameFocus,
//                 onChanged: controller.creditCard.changeName,
//                 textCapitalization: TextCapitalization.characters,
//                 nextFocusNode: _expDateFocus,
//                 labelText: widget.labelTextName,
//                 errorText: controller.validateName,
//                 hasSuffixIcon: false,
//               ),
//               // Observer(
//               //     name: 'Nome no cartão',
//               //     builder: (_) {
//               //       return _textFormField(
//               //         controllerTextField: _nome,
//               //         validator: controller.validateName,
//               //         keyboardType: TextInputType.text,
//               //         textInputAction: TextInputAction.next,
//               //         maxLength: 25,
//               //         focusNode: _nameFocus,
//               //         onChanged: controller.creditCard.changeName,
//               //         textCapitalization: TextCapitalization.characters,
//               //         nextFocusNode: _expDateFocus,
//               //         labelText: widget.labelTextName,
//               //         errorText: controller.validateName,
//               //       );
//               //     }),
//               SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   _textFormField(
//                       width: mediaQuery(context, 0.35),
//                       controllerTextField: _expData,
//                       keyboardType: TextInputType.number,
//                       textInputAction: TextInputAction.next,
//                       maxLength: 5,
//                       focusNode: _expDateFocus,
//                       onChanged: controller.creditCard.changeExpData,
//                       textCapitalization: TextCapitalization.none,
//                       nextFocusNode: _cvvFocus,
//                       validator: controller.validateExpData,
//                       labelText: widget.labelTextExpData,
//                       errorText: controller.validateExpData,
//                       hasSuffixIcon: false),
//                   // Observer(
//                   //     name: 'MM/YY',
//                   //     builder: (_) {
//                   //       return _textFormField(
//                   //           width: mediaQuery(context, 0.35),
//                   //           controllerTextField: _expData,
//                   //           keyboardType: TextInputType.number,
//                   //           textInputAction: TextInputAction.next,
//                   //           maxLength: 5,
//                   //           focusNode: _expDateFocus,
//                   //           onChanged: controller.creditCard.changeExpData,
//                   //           textCapitalization: TextCapitalization.none,
//                   //           nextFocusNode: _cvvFocus,
//                   //           validator: controller.validateExpData,
//                   //           labelText: widget.labelTextExpData,
//                   //           errorText: controller.validateExpData);
//                   //     }),
//                   _textFormField(
//                       width: mediaQuery(context, 0.45),
//                       controllerTextField: _cvv,
//                       keyboardType: TextInputType.number,
//                       textInputAction: TextInputAction.done,
//                       maxLength: 4,
//                       validator: controller.validateCVV,
//                       focusNode: _cvvFocus,
//                       onChanged: controller.creditCard.changeCVV,
//                       textCapitalization: TextCapitalization.none,
//                       labelText: widget.labelTextCVV,
//                       errorText: controller.validateCVV,
//                       hasSuffixIcon: false),
//                   // Observer(
//                   //     name: 'CVV/CVC',
//                   //     builder: (_) {
//                   //       var ccType = detectCCType(controller.creditCard.number);

//                   //       return _textFormField(
//                   //           width: mediaQuery(context, 0.45),
//                   //           controllerTextField: _cvv,
//                   //           keyboardType: TextInputType.number,
//                   //           textInputAction: TextInputAction.done,
//                   //           maxLength: ccType == CreditCardType.amex ||
//                   //                   ccType == CreditCardType.discover
//                   //               ? 4
//                   //               : 3,
//                   //           validator: controller.validateCVV,
//                   //           focusNode: _cvvFocus,
//                   //           onChanged: controller.creditCard.changeCVV,
//                   //           textCapitalization: TextCapitalization.none,
//                   //           labelText: widget.labelTextCVV,
//                   //           errorText: controller.validateCVV);
//                   //     }),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Center(
//                 child: GenericButton(
//                   text: "Avançar",
//                   onPressedFunction: () {
//                     if (formKey.currentState.validate()) {
//                       if (detectCCType(controller.creditCard.number) ==
//                           CreditCardType.unknown) {
//                         SnackBarUtils.showSnackBar(
//                             title: "Atenção",
//                             desc:
//                                 "Número do cartão inválido, corriga e tente novamente.");
//                       } else {
//                         Get.toNamed(Routes.WALLET_EXTERN_CARD_SECOND_INFO);
//                       }
//                     }
//                   },
//                   txtColor: Colors.white,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _iconBand(controller) {
//     double sizeBand = mediaQuery(context, 0.09);
//     Widget icon;
//     var currType = detectCCType(controller.creditCard.number);

//     switch (currType) {
//       case CreditCardType.amex:
//         icon = Image(
//           image: AssetImage("assets/amex.png",
//               package: 'flutter_credit_card_detector'),
//           width: sizeBand,
//         );
//         break;

//       case CreditCardType.aura:
//         icon = Image(
//           image: AssetImage("assets/aura.png",
//               package: 'flutter_credit_card_detector'),
//           width: sizeBand,
//         );
//         break;

//       case CreditCardType.dinersclub:
//         icon = Image(
//           image: AssetImage("assets/dinersclub.png",
//               package: 'flutter_credit_card_detector'),
//           width: sizeBand,
//         );
//         break;

//       case CreditCardType.discover:
//         icon = Image(
//           image: AssetImage("assets/discover.png",
//               package: 'flutter_credit_card_detector'),
//           width: sizeBand,
//         );
//         break;

//       case CreditCardType.elo:
//         icon = Image(
//           image: AssetImage("assets/elo.png",
//               package: 'flutter_credit_card_detector'),
//           width: sizeBand,
//         );
//         break;

//       case CreditCardType.jcb:
//         icon = Image(
//           image: AssetImage("assets/jcb.png",
//               package: 'flutter_credit_card_detector'),
//           width: sizeBand,
//         );
//         break;

//       case CreditCardType.mastercard:
//         icon = Image(
//           image: AssetImage("assets/mastercard.png",
//               package: 'flutter_credit_card_detector'),
//           width: sizeBand,
//         );
//         break;

//       case CreditCardType.hiper:
//         icon = Image(
//           image: AssetImage("assets/hiper.png",
//               package: 'flutter_credit_card_detector'),
//           width: sizeBand,
//         );
//         break;

//       case CreditCardType.hipercard:
//         icon = Image(
//           image: AssetImage("assets/hipercard.png",
//               package: 'flutter_credit_card_detector'),
//           width: sizeBand,
//         );
//         break;

//       case CreditCardType.rupay:
//         icon = Image(
//           image: AssetImage("assets/rupay.png",
//               package: 'flutter_credit_card_detector'),
//           width: sizeBand,
//         );
//         break;

//       case CreditCardType.visa:
//         icon = Image(
//           image: AssetImage("assets/visa.png",
//               package: 'flutter_credit_card_detector'),
//           width: sizeBand,
//         );
//         break;

//       default:
//         Widget widget;
//         if (currType == CreditCardType.unknown &&
//             controller.creditCard.number.length < 4) {
//           widget = Container(
//             color: Color(0x00000000),
//           );
//         } else if (controller.creditCard.iconBand != 'unknown' &&
//             controller.creditCard.number.length < 19) {
//           widget = Container(
//             color: Color(0x00000000),
//           );
//         } else {
//           widget = Image(
//             image: AssetImage("assets/${controller.creditCard.iconBand}.png",
//                 package: 'flutter_credit_card_detector'),
//             width: sizeBand,
//           );
//         }
//         icon = widget;
//         break;
//     }

//     return icon;
//   }
// }
