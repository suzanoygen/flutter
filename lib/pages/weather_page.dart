import 'package:flutter/material.dart';
import 'package:flutter_app/models/weather_model.dart';
import 'package:flutter_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPagestate();
}

class _WeatherPagestate extends State<WeatherPage> {
  final _weatherService = WeatherService('90f31587b8bcd5bf17e3a186e40f803b');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city.."),

            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}
