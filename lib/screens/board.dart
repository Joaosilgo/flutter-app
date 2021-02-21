import 'package:flutter/material.dart';
//import 'package:transparent_image/transparent_image.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'dart:async';
//import 'dart:io';

class BoardScreen extends StatelessWidget {
  final String texto;

  BoardScreen(this.texto);

  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      Center(child: CircularProgressIndicator()),
      Center(
        child: /* FadeInImage.memoryNetwork( */ FadeInImage(
          /*  placeholder: kTransparentImage, */
          placeholder: AssetImage("assets/shared-file.jpg"),
          image: AssetImage("assets/shared-file.jpg"),
          /*'https://images.unsplash.com/photo-1530893609608-32a9af3aa95c?ixid=MXwxOTkyMTB8MHwxfGNvbGxlY3Rpb258MXwxODM2NjgwNHx8fHx8Mnw&ixlib=rb-1.2.1',*/
          //NetworkImage("https://images.unsplash.com/photo-1548032885-b5e38734688a?ixid=MXwxOTkyMTB8MHwxfGNvbGxlY3Rpb258MXwxODM2NjgwNHx8fHx8Mnw&ixlib=rb-1.2.1"),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          //if you use a larger image, you can set where in the image you like most
          //width alignment.centerRight, bottomCenter, topRight, etc...
          alignment: Alignment.center,
        ),
      ),
      _homepageWIcons(context),
      //  _HomepageWords(context),
      _homepageWContent(context)
      /*    
      Container(
          decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1548032885-b5e38734688a?ixid=MXwxOTkyMTB8MHwxfGNvbGxlY3Rpb258MXwxODM2NjgwNHx8fHx8Mnw&ixlib=rb-1.2.1'),
            fit: BoxFit.cover),
      )),*/
    ]));
  }
}

//example words and image to float over background
Widget _homepageWords(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      InkWell(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "JOÃO GOMES",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "FLUTTER APP",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "LILYGO TTGO LORA32 868 MHz ESP32 LoRa OLED 0,96 polegadas Blue Display bluetooth WIFI ESP-32",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "ESP32 BLE Server",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        /*  onTap: () {
          //to another screen / page or action
        },*/
      ),
    ],
  );
}

Widget _homepageWIcons(BuildContext context) {
  return Container(
    height: 57.6,
    margin: EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // Navigator.of(context).pop();
            // Share.share('check out my website https://example.com');

            Share.share(
                'check out my website https://github.com/Joaosilgo/flutter-app',
                subject: 'Look what I made!');

            //  Share.shareFiles(['assets/shared-file.jpg'], text: 'Great picture');
            //  Share.shareFiles(['assets/shared-file.jpg'], text: 'Great picture');
          },
          child: Container(
            height: 57.6,
            width: 57.6,
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.6),
              color: Color(0x10000000),
            ),
            child: Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _homepageWContent(BuildContext context) {
  return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 346.8,
        margin: EdgeInsets.only(left: 28.8, bottom: 48, right: 28.8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 19.2),
                child: Text(
                  'Flutter BLE',
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 42.6,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 19.2),
                child: Text(
                  'ESP32 Bluetooth Low Energy. This is highly recommended for the Internet of Things.\nThis is because its power consumption is miniscule, ESP32 will become a Bluetooth server. This will connect a smartphone application to send and receive data.\nThings that we will cover in this App: \n',
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 17.2,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Check GitHub',
                            style: TextStyle(
                                fontSize: 16.8,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        Text(':) -->',
                            style: TextStyle(
                                fontSize: 21.6,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ],
                    ),
                    Container(
                        height: 62.4,
                        /* decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.6),
                            color: Color(0x10000000)),*/
                        child: FlatButton(
                          color: Color(0x10000000),
                          onPressed: _launchURL,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 28.8, right: 28.8),
                              child: Text('Explore Now >>',
                                  style: TextStyle(
                                      fontSize: 19.2,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                            ),
                          ),
                        ))
                  ])
            ]),
      ));
}

_launchURL() async {
  const url = 'https://github.com/Joaosilgo/flutter-app';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
