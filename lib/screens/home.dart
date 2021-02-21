import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Appuser {
  String name;
  Image img;
  Appuser() {
    this.name = "Unknown user";
    this.img = Image.asset('assets/shared-file.jpg');
  }
}

Appuser appuser = new Appuser();

class Home extends StatelessWidget {
  final String texto;

  Home(this.texto);

  Widget build(BuildContext context) {
    return ListView(children: [
      Image.asset(
        'assets/shared-file.jpg',
        width: 600,
        height: 240,
        fit: BoxFit.cover,
      ),
      titleSection,
      buttonSection,
      textSection,
      Divider(
        color: Colors.grey[400],
        height: 35,
        thickness: 0.25,
        indent: 30,
        endIndent: 30,
      )
    ]);
  }

  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[600]),
                ),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        /*3*/
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.grey[200],
            backgroundImage: appuser.img.image,
            child: Text('JG',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.grey[400])),
          ),
          label: Text(
            'João Gomes',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500]),
          ),
          backgroundColor: Colors.grey[100],
        ),
      ],
    ),
  );

  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: RichText(
        text: TextSpan(
      text: 'Things that we will cover in this App:\n ',
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500]),
      children: <TextSpan>[
        TextSpan(
            text: '\nHow to connect your BLE device with a flutter app.',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500])),
        TextSpan(
            text:
                '\nHow to discover the services that your BLE device provides.',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500])),
        TextSpan(
            text: '\nHow to get data from these services/characteristics.',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500])),
        TextSpan(
            text: '\nHow to send commands to the BLE device.',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500])),
        TextSpan(
            text: '\nAnd finally practice Flutter Programming.',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500])),
        TextSpan(
            text: '\n\n Flutter Libraries:',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500])),
        TextSpan(
            text: '\n',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500])),
        TextSpan(
            text:
                '\ncupertino_icons: ^1.0.0http: ^0.12.2\nflutter_blue: ^0.7.3\ntransparent_image: ^1.0.0\nshare: ^0.6.5+4\nsplashscreen: ^1.3.5\nurl_launcher: ^5.7.10\npath_provider: ^1.6.27.',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500])),
      ],
    )),
  );

  Widget buttonSection = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(
            Colors.grey, Icons.call, 'CALL', 'tel:+351964575619'),
        _buildButtonColumn(
            Colors.grey, Icons.textsms, 'SMS', 'sms:+351964575619'),
        _buildButtonColumn(Colors.grey, Icons.email, 'EMAIL',
            'mailto:joaosilgo96@gmail.com?subject=Example+Subject+%26+Symbols+are+allowed%21'),
        _buildButtonColumn(Colors.grey, Icons.wifi_calling_sharp, 'WHATSAPP',
            'https://wa.me/+351964575619')
      ],
    ),
  );
}

FlatButton _buildButtonColumn(Color color, IconData icon, String label, url) {
  return FlatButton(
      onPressed: () {
        _launchURL(url);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      ));
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
