import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoxAccountLogin extends StatelessWidget {
  const BoxAccountLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: Colors.white),
        // color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Olá, apelido",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Agência",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "0001",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  width: 2,
                  color: Colors.white,
                  endIndent: 4,
                  indent: 4,
                  thickness: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Conta",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "1234567-8",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
