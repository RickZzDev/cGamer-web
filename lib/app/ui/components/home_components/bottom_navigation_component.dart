import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int index;
  final Function changeIndex;
  const CustomBottomNavigation(
      {Key? key, required this.index, required this.changeIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      backgroundColor: Theme.of(context).accentColor,

      iconSize: 24,
      // elevation: 12,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: (value) => changeIndex(value),
      items: [
        BottomNavigationBarItem(
          icon: Container(
            width: 35,
            height: 25,
            // color: Colors.red,
            child: SvgPicture.asset(
              "assets/images/tab_bar_icons/Inicio.svg",
              color: index == 0 ? Theme.of(context).primaryColor : Colors.grey,
            ),
          ),
          label: "Início",
        ),
        BottomNavigationBarItem(
            icon: Container(
              width: 35,
              height: 25,
              // color: Colors.red,
              child: SvgPicture.asset(
                // "assets/images/home_images/Gamer_Store.svg",
                "assets/images/tab_bar_icons/mafa_logo_white.svg",
                color:
                    index == 1 ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
            label: "\$MAFA"),
        BottomNavigationBarItem(
            icon: Container(
              width: 32,
              height: 25,
              // color: Colors.red,
              child: SvgPicture.asset(
                "assets/images/tab_bar_icons/Cristais.svg",
                color:
                    index == 2 ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
            label: "Rubis"),
        BottomNavigationBarItem(
            icon: Container(
              width: 35,
              height: 25,
              // color: Colors.red,
              child: SvgPicture.asset(
                "assets/images/tab_bar_icons/Bank.svg",
                color:
                    index == 3 ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
            label: "Bank"),
        BottomNavigationBarItem(
            icon: Container(
              width: 35,
              height: 25,
              // color: Colors.red,
              child: SvgPicture.asset(
                "assets/images/tab_bar_icons/Perfil.svg",
                color:
                    index == 4 ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
            label: "Perfil"),
      ],
    );
  }
}
