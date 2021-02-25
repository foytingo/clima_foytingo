import 'package:clima_foytingo/screens/city_screen.dart';
import 'package:clima_foytingo/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class LocationScreen extends StatefulWidget {
  final weatherData;

  LocationScreen({this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherService weatherService = WeatherService();

  int temperature;
  String weatherIcon;
  String message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        message = 'Unable to get weather data';
        return;
      } else {
        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weatherService.getWeatherIcon(condition);
        double temp = weatherData['main']['temp'];
        temperature = (temp - 273).toInt();
        var cityName = weatherData['name'];
        message = '${weatherService.getMessage(temperature)} in $cityName';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                    onPressed: () async {
                      var weatherData =
                          await weatherService.getCurrentWeatherWithLocation();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 30.0,
                    )),
                FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData =
                            await weatherService.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 30.0,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text('$temperature°',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                  Text(
                    '$weatherIcon',
                    style: TextStyle(fontSize: 40.0),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '$message',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 60.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
