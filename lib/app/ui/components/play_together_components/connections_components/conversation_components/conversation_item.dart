import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class ConversationItem extends StatelessWidget {
  final String userName;
  final String message;
  final String urlImage;

  ConversationItem(
      {Key? key,
      required this.userName,
      required this.message,
      required this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      this.urlImage,
                      height: 48,
                      width: 48,
                      fit: BoxFit.fill,
                    ),
                    VerticalDivider(
                      color: Colors.transparent,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                        SizedBox(height: 4),
                        Container(
                            width: screenWidthhSize - 152,
                            child: Text(
                              message,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: textStyle.copyWith(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: primaryColor,
                    ))
              ],
            ),
          ),
          Divider(
            color: primaryColor,
          )
        ],
      ),
    );
  }
}
