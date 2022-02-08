import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DotsComponent extends StatelessWidget {
  const DotsComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: Color(0xFFE1E1E1),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: Color(0xFFE1E1E1),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: Color(0xFFE1E1E1),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: Color(0xFFE1E1E1),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: Color(0xFFE1E1E1),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        )
      ],
    );
  }
}
