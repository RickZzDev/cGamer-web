import 'package:cGamer/app/controllers/cash_actions_controllers//ticket_list_view/ticket_list_controller.dart';
import 'package:cGamer/app/ui/components/cash_in_components/ticket_list_status.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/shimmers/cash_in_shimmers/ticket_item_shimmer.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class TicketsListView extends StatelessWidget {
  final TicketListController _controller = Get.find<TicketListController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: utils.secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Depósito",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRichText(
                  normalText: "Confira abaixo", customText: "seus boletos"),
              SizedBox(
                height: 18,
              ),
              Container(
                height: utils.screenHeigthSize,
                child: Obx(
                  () => FutureBuilder(
                    future: _controller.call.value,
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.done
                          ? ListView.separated(
                              itemBuilder: (context, index) => TicketItem(
                                ticketInfo:
                                    _controller.tickets.bankslips?[index],
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 8,
                              ),
                              itemCount:
                                  _controller.tickets.bankslips?.length ?? 0,
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) => ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                child: Shimmer.fromColors(
                                  baseColor: Theme.of(context).accentColor,
                                  highlightColor: Colors.blueGrey[400],
                                  child: TicketItemShimer(),
                                ),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 8,
                              ),
                              itemCount: 10,
                            );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
