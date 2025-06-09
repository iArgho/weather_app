import 'package:Weatherly/screens/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

class Weatherly extends StatelessWidget {
  const Weatherly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weatherly',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF2193b0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2193b0),
          brightness: Brightness.light,
        ),
      ),

      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(gradient: kAppGradient),
          child: child,
        );
      },

      home: const SplashScreen(),
    );
  }
}

const LinearGradient kAppGradient = LinearGradient(
  colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
