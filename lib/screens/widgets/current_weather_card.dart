import 'dart:ui';

import 'package:flutter/material.dart';

class CurrentWeatherCard extends StatelessWidget {
  final String temperature;
  final String weatherDescription;
  final String location;
  final IconData icon;

  const CurrentWeatherCard({
    super.key,
    required this.temperature,
    required this.weatherDescription,
    required this.location,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(20),
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
              children: [
                Icon(icon, size: 60, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  temperature,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  weatherDescription,
                  style: const TextStyle(fontSize: 20, color: Colors.white70),
                ),
                const SizedBox(height: 10),
                Text(
                  location,
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
