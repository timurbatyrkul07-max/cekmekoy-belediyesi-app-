import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherInfo {
  final double temperature;
  final int weatherCode;
  final double windSpeed;
  final bool isDay;

  const WeatherInfo({
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
    required this.isDay,
  });

  String get description {
    return switch (weatherCode) {
      0 => 'Açık',
      1 || 2 => 'Az Bulutlu',
      3 => 'Bulutlu',
      45 || 48 => 'Sisli',
      51 || 53 || 55 => 'Çiseliyor',
      61 || 63 || 65 => 'Yağmurlu',
      71 || 73 || 75 => 'Karlı',
      77 => 'Kar Tanesi',
      80 || 81 || 82 => 'Sağanak',
      85 || 86 => 'Kar Yağışı',
      95 => 'Gök Gürültülü',
      96 || 99 => 'Dolu',
      _ => 'Bilinmiyor',
    };
  }
}

class WeatherService {
  final _dio = Dio();
  static const _lat = 41.0356;
  static const _lon = 29.1842;

  Future<WeatherInfo> fetchCurrent() async {
    final res = await _dio.get(
      'https://api.open-meteo.com/v1/forecast',
      queryParameters: {
        'latitude': _lat,
        'longitude': _lon,
        'current': 'temperature_2m,weather_code,wind_speed_10m,is_day',
        'timezone': 'Europe/Istanbul',
      },
      options: Options(receiveTimeout: const Duration(seconds: 5)),
    );
    final current = res.data['current'] as Map<String, dynamic>;
    return WeatherInfo(
      temperature: (current['temperature_2m'] as num).toDouble(),
      weatherCode: (current['weather_code'] as num).toInt(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      isDay: (current['is_day'] as num) == 1,
    );
  }
}

final weatherServiceProvider = Provider<WeatherService>((ref) => WeatherService());

final currentWeatherProvider = FutureProvider<WeatherInfo>((ref) {
  return ref.read(weatherServiceProvider).fetchCurrent();
});
