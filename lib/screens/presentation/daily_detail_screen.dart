import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:Weatherly/screens/widgets/hourly_forecast_card.dart';

class DailyDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DailyDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> hourlyData =
        (data['hourly'] as List<Map<String, String>>?) ??
        [
          {'time': '10:00', 'icon': '☀️', 'temperature': '22°C'},
          {'time': '11:00', 'icon': '🌤️', 'temperature': '23°C'},
          {'time': '12:00', 'icon': '☁️', 'temperature': '24°C'},
          {'time': '13:00', 'icon': '🌧️', 'temperature': '21°C'},
          {'time': '14:00', 'icon': '⛈️', 'temperature': '20°C'},
        ];

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "${data["day"] ?? "Day"} Forecast",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: screenWidth * 0.9,
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          width: 2,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            data["icon"] ?? "❓",
                            style: const TextStyle(fontSize: 60),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data["temp"] ?? "--°C",
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Hourly Forecast section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Hourly Forecast',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 120,
                        child: Center(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: hourlyData.length,
                            separatorBuilder:
                                (_, __) => const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final hour = hourlyData[index];
                              return HourlyForecastCard(
                                time: hour['time']!,
                                icon: hour['icon']!,
                                temperature: hour['temperature']!,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 6),
              Text(
                "$label: $value",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
