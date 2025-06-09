import 'dart:ui';
import 'package:Weatherly/screens/widgets/hourly_forecast_card.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      backgroundColor: Colors.transparent,
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
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          // Added to handle overflow
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 300,
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
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(height: 5),
                      // Optional: Add InfoChips for additional details
                      if (data['humidity'] != null ||
                          data['windSpeed'] != null ||
                          data['pressure'] != null)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (data['humidity'] != null)
                              _InfoChip(
                                icon: Icons.water_drop,
                                label: 'Humidity',
                                value: data['humidity'],
                              ),
                            if (data['windSpeed'] != null)
                              _InfoChip(
                                icon: Icons.air,
                                label: 'Wind',
                                value: data['windSpeed'],
                              ),
                            if (data['pressure'] != null)
                              _InfoChip(
                                icon: Icons.speed,
                                label: 'Pressure',
                                value: data['pressure'],
                              ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      // Hourly Forecast Section
                      const Text(
                        'Hourly Forecast',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 120, // Adjust height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hourlyData.length,
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
                    ],
                  ),
                ),
              ),
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                "$label: $value",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
