import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:convert';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weatherModel = WeatherModel();
  double temperature=0;
  String weatherIcon='';
  String message='';
  String cityname='';
  int temp=0;
  @override
  void initState()
  {
    super.initState();
    updateUiI(widget.locationWeather);
  }

  void updateUiI(Map<String, dynamic>  weatherData)
  {
    setState(() {
      if(weatherData==null)
        {
          temp=0;
          temperature=0;
          weatherIcon='Error';
          message='Unable to get weather data';
          return;
        }

      // map = jsonDecode(weatherData); // import 'dart:convert';


      temperature = weatherData["main"]["temp"];
      temp = temperature.toInt();
      var condition =  weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      cityname = weatherData['name'];
      message = weatherModel.getMessage(temp);
      //print(cityname);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      //var weatherData =
                      Map<String, dynamic> map=await weatherModel.getLocationWeather();
                      updateUiI(map);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                     var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                       return CityScreen();
                        },
                       ),
                      );
                     if(typedName != null && typedName != '')
                        {
                         var weatherData = await weatherModel.getCityWeather(typedName);
                         updateUiI(weatherData);
                        }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityname",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//
