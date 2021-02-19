import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AboutScreen extends StatelessWidget {
  final String texto;

  AboutScreen(this.texto);

  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      Center(child: CircularProgressIndicator()),
      Center(
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image:
              'https://images.unsplash.com/photo-1592754099136-4b447d9bfd15?ixid=MXwxOTkyMTB8MHwxfGNvbGxlY3Rpb258NHw1OTE3MTgzMnx8fHx8Mnw&ixlib=rb-1.2.1', //NetworkImage("https://images.unsplash.com/photo-1548032885-b5e38734688a?ixid=MXwxOTkyMTB8MHwxfGNvbGxlY3Rpb258MXwxODM2NjgwNHx8fHx8Mnw&ixlib=rb-1.2.1"),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          //if you use a larger image, you can set where in the image you like most
          //width alignment.centerRight, bottomCenter, topRight, etc...
          alignment: Alignment.center,
        ),
      ),
     
      _HomepageWords(
          context), /*    
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
Widget _HomepageWords(BuildContext context) {
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
                "Disclaimer information...",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        onTap: () {
          //to another screen / page or action
        },
      ),
    ],
  );
}


