import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final String BASE_URL = "http://api.openweathermap.org/data/2.5/weather?q=Lagos&units=metric&appid=38f556ee904eef3704f50e0f34d43cfe";

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async{
    http.Response response = await http.get(BASE_URL);
    var results = jsonDecode(response.body);

    setState(() {
        this.temp = results["main"]["temp"];
        this.description = results["weather"][0]["description"];
        this.currently = results["weather"][0]["main"];
        this.humidity = results["main"]["humidity"];
        this.windSpeed = results["wind"]["speed"];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Weather in Nigeria",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  )),
              Text(
                temp != null ? temp.toString()+"\u00B0 c": "Loading",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    description != null ? description.toString() : "Loading...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
        Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometer),
                    title: Text("Temperature"),
                    trailing: Text(temp != null ? temp.toString()+" \u00B0 c" : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null ? description.toString() : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(humidity != null ? humidity.toString() : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading..."),
                  ),
                ],
              ),
            )
        )
      ],
    ));
  }
}
