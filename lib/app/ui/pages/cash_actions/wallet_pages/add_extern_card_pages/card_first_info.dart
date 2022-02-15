// import 'package:cGamer/app/ui/components/components.dart';
// import 'package:cGamer/app/ui/components/wallet_components/credit_card_component.dart';
// import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card_detector/flutter_credit_card_detector.dart';
// import 'package:provider/provider.dart';

// class AddExternCardFirstStep extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         Provider<Controller>(
//           create: (_) => Controller(),
//           dispose: (_, controler) => controler.dispose(),
//         )
//       ],
//       child: Scaffold(
//         backgroundColor: secondaryColor,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(70),
//           child: CustomAppBar(
//             appBarTxt: "Cartão de crédito",
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(left: 24, right: 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 MyCreditCardWidget(
//                   labelTextNum: 'Numero do cartão',
//                   labelTextName: 'Nome no cartão',
//                   labelTextExpData: 'MM/AA',
//                   labelTextCVV: 'CVV/CVC',
//                   titleCreditCard: 'Cartão de Crédito',
//                   labelTextValidate: 'Valido Até',
//                   textRequired: 'Este campo é obrigatorio',
//                   textSelectBand: 'Selecione a bandeira',
//                   textNameMin: 'O nome de conter pelo menos 6 caracteres',
//                   textIntroNameValid: 'Insira um nome válido',
//                   textCardExpired: 'Cartão vencido',
//                   textInvalidateMonth: 'Mês incorreto.',
//                   colorTextField: Colors.white,
//                   colorCardSelect: primaryColor,
//                   colorCreditWhite: Color(0xff535252),
//                   colorCreditBlack: Color(0xff211e1e),
//                   listBand: [
//                     'visa',
//                     'mastercard',
//                     'amex',
//                     'elo',
//                     'dinersclub',
//                     'discover',
//                     'jcb',
//                     'aura',
//                     'hiper',
//                     'hipercard',
//                     'rupay'
//                   ],
//                   onTap: () => {}, // Função
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
