import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'YOUR-API-KEY';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async{
    Uri url = Uri.https('api.openweathermap.org', 'data/2.5/weather',
        {'q': '$cityName', 'appid': '$apiKey'});

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{
    double longitude;
    double latitude;
    Location location = Location();
    await location.getCurrentLocation();
    longitude = location.longitude;
    latitude = location.latitude;

    Uri url = Uri.https('api.openweathermap.org', 'data/2.5/weather',
        {'lat': '$latitude', 'lon': '$longitude', 'appid': '$apiKey'});

    NetworkHelper networkHelper = NetworkHelper(url);
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
