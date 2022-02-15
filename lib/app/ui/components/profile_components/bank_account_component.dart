import 'package:cGamer/app/controllers/bank/bank_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cGamer/app/data/models/models_export.dart';

class BankAccountComponent extends StatelessWidget {
  const BankAccountComponent(
      {Key? key,
      required BankController bankController,
      required BankAccount? bankAccount})
      : _controller = bankController,
        _bankAccount = bankAccount,
        super(key: key);

  final BankController _controller;
  final BankAccount? _bankAccount;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 4,
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
              ),
              BoxShadow(
                color: primaryColor,
                spreadRadius: -2.0,
                blurRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Instituição de pagamento",
                              style: textStyle.copyWith(
                                fontSize: 14,
                                color: secondaryColor,
                              ),
                            ),
                            Text(
                              "${_bankAccount?.bank}",
                              style: textStyle.copyWith(
                                  fontSize: 15,
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Banco",
                                      style: textStyle.copyWith(
                                        fontSize: 14,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${_bankAccount?.bankNumber}",
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Agência",
                                      style: textStyle.copyWith(
                                        fontSize: 14,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${_bankAccount?.agency}",
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Conta",
                                      style: textStyle.copyWith(
                                        fontSize: 14,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${_bankAccount?.account}",
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ])),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              _controller.copyBankAccount();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Dados bancários copiados com sucesso."),
                                ),
                              );
                            },
                            child: Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(
                                      width: 2, color: secondaryColor),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/profile_images/copy.svg',
                                    fit: BoxFit.contain,
                                    color: secondaryColor,
                                    height: 24,
                                    width: 24,
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 16,
                        ),
                        InkWell(
                            onTap: () {
                              _controller.shareBankAccount();
                            },
                            child: Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(
                                      width: 2, color: secondaryColor),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/profile_images/share.svg',
                                    fit: BoxFit.contain,
                                    color: secondaryColor,
                                    height: 24,
                                    width: 24,
                                  ),
                                ],
                              ),
                            )),
                      ])
                ]),
          ),
        ));
  }
}
