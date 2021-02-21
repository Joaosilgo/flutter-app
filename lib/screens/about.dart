import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

final String apiUrl = "https://joaosilgo.github.io/API/API/api.json";

Future<Data> fetchData() async {
  /*  vaar result = await http.get(apiUrl);
    var info = json.decode(result.body);
    print(info);
    return info;
*/
  final response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return Data.fromJson(jsonDecode(response.body));
    print(json.decode(response.body));
    return Data.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

class Data {
  final String name;
  final String first_name;
  final String last_name;
  final String middle_name;

  final String phone;
  final String mail;
  final String dob;

  final Map<String, dynamic> degree;

  Data(
      {this.name,
      this.first_name,
      this.last_name,
      this.middle_name,
      this.phone,
      this.mail,
      this.dob,
      this.degree});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      middle_name: json['middle_name'],
      phone: json['phone'],
      mail: json['mail'],
      dob: json['dob'],
      degree: json['ugcollege'],
    );
  }
}

class AboutScreen extends StatefulWidget {
  AboutScreen({Key key}) : super(key: key);

  @override
  _MyAboutScreenState createState() => _MyAboutScreenState();
}

class _MyAboutScreenState extends State<AboutScreen> {
  // final String texto;
  Future<Data> data;

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  // AboutScreen(this.texto);

  Widget build(BuildContext context) {
    return Container(
        child: Container(
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
      _HomepageWords(context),
      Center(
          child: Padding(
              padding: EdgeInsets.only(top: 200),
              child: FutureBuilder<Data>(
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: <Widget>[
                      Text(
                        snapshot.data.first_name.toString(),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        snapshot.data.first_name.toString(),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        snapshot.data.degree['degree'].toString(),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ]);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white));
                  }

                  // By default, show a loading spinner
                  return CircularProgressIndicator();
                },
              )))
      /*    
      Container(
          decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1548032885-b5e38734688a?ixid=MXwxOTkyMTB8MHwxfGNvbGxlY3Rpb258MXwxODM2NjgwNHx8fHx8Mnw&ixlib=rb-1.2.1'),
            fit: BoxFit.cover),
      )),*/
    ])));
  }
}

Widget textSection = Padding(
    padding: EdgeInsets.only(top: 135),
    child: Container(
      //height: 346.8,
      margin: EdgeInsets.only(left: 28.8, right: 28.8),
      // padding: const EdgeInsets.all(32),
      child: RichText(
          text: TextSpan(
        text: 'Things that we will cover in this App:\n ',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        children: <TextSpan>[
          TextSpan(
              text: '\nHow to connect your BLE device with a flutter app.',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          TextSpan(
              text:
                  '\nHow to discover the services that your BLE device provides.',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          TextSpan(
              text: '\nHow to get data from these services/characteristics.',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          TextSpan(
              text: '\nAnd finally how to send commands to the BLE device.',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        ],
      )),
    ));

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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "FLUTTER APP",
                style: TextStyle(
                    fontSize: 42,
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
