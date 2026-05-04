import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/weather_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class WeatherWidget extends ConsumerWidget {
  const WeatherWidget({super.key});

  IconData _iconFor(int code, bool isDay) {
    return switch (code) {
      0 => isDay ? Icons.wb_sunny : Icons.nightlight_round,
      1 || 2 => isDay ? Icons.wb_cloudy : Icons.nightlight_round,
      3 => Icons.cloud,
      45 || 48 => Icons.foggy,
      51 || 53 || 55 || 61 || 63 || 65 || 80 || 81 || 82 => Icons.umbrella,
      71 || 73 || 75 || 77 || 85 || 86 => Icons.ac_unit,
      95 || 96 || 99 => Icons.thunderstorm,
      _ => Icons.cloud,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncWeather = ref.watch(currentWeatherProvider);
    return asyncWeather.when(
      loading: () => Row(
        children: [
          const SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.textTertiary),
          ),
          const SizedBox(width: 8),
          Text('Çekmeköy hava durumu', style: AppTextStyles.caption),
        ],
      ),
      error: (_, __) => Row(
        children: [
          const Icon(Icons.location_city, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text('Çekmeköy', style: AppTextStyles.caption),
        ],
      ),
      data: (w) => Row(
        children: [
          Icon(_iconFor(w.weatherCode, w.isDay), color: AppColors.primary, size: 22),
          const SizedBox(width: 6),
          Text('${w.temperature.round()}°', style: AppTextStyles.bodyBold),
          const SizedBox(width: 8),
          Text(w.description, style: AppTextStyles.caption),
          const SizedBox(width: 6),
          Container(width: 3, height: 3, decoration: const BoxDecoration(color: AppColors.textTertiary, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text('Çekmeköy', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
