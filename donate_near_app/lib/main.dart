import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/donation_details_screen.dart';
// CHANGES
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  // CHANGE
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const DonateNearApp());
}

class DonateNearApp extends StatelessWidget {
  const DonateNearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DonateNear',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      // Start with splash screen
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/details': (context) => const DonationDetailsScreen(),
      },
    );
  }
}
