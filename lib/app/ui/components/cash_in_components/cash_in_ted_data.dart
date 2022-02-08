import 'package:cGamer/app/controllers/cash_actions_controllers/cash_ted/ted_cash_in_controller.dart';
import 'package:cGamer/app/data/models/models_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CashInTedDataHeader extends StatelessWidget {
  const CashInTedDataHeader(
      {Key? key,
      required CashInTedController controller,
      required ProfileModel profileStats})
      : _controller = controller,
        _profileStats = profileStats,
        super(key: key);

  final CashInTedController _controller;
  final ProfileModel _profileStats;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Banco',
                  style:
                      textStyle.copyWith(fontSize: 14, color: Colors.white54),
                ),
                Text(
                  '${_profileStats.customerAccount?.bankNumber} - ${_profileStats.customerAccount?.bank}',
                  style: textStyle.copyWith(fontSize: 16, color: Colors.white),
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(
                  color: Colors.white54,
                  height: 2,
                ),
                SizedBox(height: 12),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Agência',
                            style: textStyle.copyWith(
                                fontSize: 14, color: Colors.white54),
                          ),
                          Text(
                            '${_profileStats.customerAccount?.agency}',
                            style: textStyle.copyWith(
                                fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            _controller.copyAgency();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Agência copiada com sucesso.")));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/profile_images/copy.svg',
                                fit: BoxFit.contain,
                                color: Theme.of(context).primaryColor,
                                height: 24,
                                width: 24,
                              ),
                              Text(
                                'Copiar',
                                style: textStyle.copyWith(
                                    fontSize: 11,
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          )),
                    ]),
                Divider(
                  color: Colors.white54,
                  height: 2,
                ),
                SizedBox(height: 12),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Conta',
                            style: textStyle.copyWith(
                                fontSize: 14, color: Colors.white54),
                          ),
                          Text(
                            '${_profileStats.customerAccount?.account}',
                            style: textStyle.copyWith(
                                fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            _controller.copyAccountNumber();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Conta copiada com sucesso.")));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/profile_images/copy.svg',
                                fit: BoxFit.contain,
                                color: Theme.of(context).primaryColor,
                                height: 24,
                                width: 24,
                              ),
                              Text(
                                'Copiar',
                                style: textStyle.copyWith(
                                    fontSize: 11,
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          )),
                    ]),
                Divider(
                  color: Colors.white54,
                  height: 2,
                ),
                SizedBox(height: 12),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CPF',
                            style: textStyle.copyWith(
                                fontSize: 14, color: Colors.white54),
                          ),
                          Text(
                            '${_profileStats.customerCPF}',
                            style: textStyle.copyWith(
                                fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            _controller.copyCPF();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("CPF copiado com sucesso.")));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/profile_images/copy.svg',
                                fit: BoxFit.contain,
                                color: Theme.of(context).primaryColor,
                                height: 24,
                                width: 24,
                              ),
                              Text(
                                'Copiar',
                                style: textStyle.copyWith(
                                    fontSize: 11,
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          )),
                    ]),
                Divider(
                  color: Colors.white54,
                  height: 2,
                ),
                Container(
                    margin: EdgeInsets.only(top: 12),
                    padding: EdgeInsets.only(top: 12, bottom: 8),
                    child: InkWell(
                        onTap: () {
                          _controller.shareBankAccount();
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Compartilhar dados',
                                style: textStyle.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              SvgPicture.asset(
                                'assets/images/profile_images/share.svg',
                                fit: BoxFit.contain,
                                color: Theme.of(context).primaryColor,
                                height: 24,
                                width: 24,
                              ),
                            ])))
              ],
            )));
  }
}
