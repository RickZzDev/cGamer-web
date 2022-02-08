import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscordItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final url = 'https://discord.gg/QWwnE4JAtw';
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      child: Container(
          child: Image.asset(
        'assets/images/home_images/Banner_Discord.png',
      )),
    );
  }
}
