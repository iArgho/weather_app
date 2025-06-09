import 'package:Weatherly/screens/widgets/current_weather_card.dart';
import 'package:Weatherly/screens/widgets/daily_forecast_card.dart';
import 'package:Weatherly/screens/widgets/hourly_forecast_card.dart';
import 'package:Weatherly/screens/widgets/section_title.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> forecast = [
    {"day": "Sat", "temp": "21°C", "icon": "☁️"},
    {"day": "Sun", "temp": "24°C", "icon": "🌤"},
    {"day": "Mon", "temp": "26°C", "icon": "☀️"},
    {"day": "Tue", "temp": "28°C", "icon": "☀️"},
    {"day": "Wed", "temp": "25°C", "icon": "🌧"},
    {"day": "Thu", "temp": "23°C", "icon": "🌦"},
  ];

  final List<Map<String, String>> hourlyForecast = [
    {"time": "10:00", "temp": "23°C", "icon": "☁️"},
    {"time": "12:00", "temp": "24°C", "icon": "🌤"},
    {"time": "14:00", "temp": "25°C", "icon": "☀️"},
    {"time": "16:00", "temp": "24°C", "icon": "🌤"},
    {"time": "18:00", "temp": "23°C", "icon": "☁️"},
  ];

  void _showDayDetails(Map<String, String> dayData) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Weather for ${dayData["day"]}"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Temperature: ${dayData["temp"]}"),
                Text("Condition: ${dayData["icon"]}"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CurrentWeatherCard(
                  temperature: "24°C",
                  weatherDescription: "Sunny",
                  location: "Dhaka, Bangladesh",
                  icon: Icons.wb_sunny_outlined,
                ),
                const SizedBox(height: 40),
                const SectionTitle(title: "Today's Forecast"),
                const SizedBox(height: 10),
                SizedBox(
                  height: 115,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: hourlyForecast.length,
                    itemBuilder: (context, index) {
                      final hourData = hourlyForecast[index];
                      return HourlyForecastCard(
                        time: hourData["time"]!,
                        icon: hourData["icon"]!,
                        temperature: hourData["temp"]!,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                const SectionTitle(title: "7-Day Forecast"),
                const SizedBox(height: 10),
                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: forecast.length,
                    itemBuilder: (context, index) {
                      final dayData = forecast[index];
                      return GestureDetector(
                        onTap: () => _showDayDetails(dayData),
                        child: DailyForecastCard(data: dayData),
                      );
                    },
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
