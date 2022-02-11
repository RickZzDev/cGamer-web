import 'package:cGamer/app/controllers/marketplace/marketplace_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarMarketplaceComponent extends StatelessWidget {
  const SearchBarMarketplaceComponent(
      {Key? key, required MarketplaceController marketplaceController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        child: Column(children: [
          InkWell(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 48, right: 48, top: 8),
                        child: CustomTextField(
                          labelText: "Pesquisar",
                          autoFocus: false,
                          darkMode: true,
                          labelStyle: textStyle.copyWith(
                              fontSize: 14, color: secondaryColor),
                          sufixIcon: Icon(Icons.search, color: secondaryColor),
                        )),
                  ],
                )),
          ),
        ]),
      ),
      // child:
    );
  }
}
