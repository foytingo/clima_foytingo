import 'package:clima_foytingo/screens/location_screen.dart';
import 'package:clima_foytingo/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getWeatherDataWithCurrentPosition();
  }

  void getWeatherDataWithCurrentPosition() async {
    WeatherService weatherService = WeatherService();
    var weatherData = await weatherService.getCurrentWeatherWithLocation();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.green,
          size: 100.0,
        ),
      ),
    );
  }
}
