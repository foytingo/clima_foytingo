import 'network_service.dart';
import 'location_service.dart';

const apiKey = '648bd33afeb9a31505207c4b393f4fba';
const openWeatherMapsURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherService {
  Future<dynamic> getCurrentWeatherWithLocation() async {
    LocationService location = LocationService();
    await location.getCurrentLocation();

    NetworkService networkService = NetworkService(
        url:
            '$openWeatherMapsURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');

    var weatherData = await networkService.getData();

    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkService networkHelper =
        NetworkService(url: '$openWeatherMapsURL?q=$cityName&appid=$apiKey');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
