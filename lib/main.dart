import 'package:flutter/material.dart';
import 'package:hotel/presentation/authentication/screens/signUp_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotel/presentation/authentication/widgets/bottom_nav.dart';
import 'package:hotel/presentation/home/home_screen.dart';
// import 'package:hotel/presentation/onboarding/onboarding_screen.dart';
import 'package:hotel/providers/bottom_navigation_provider.dart';
// import 'package:hotel/providers/navigation_provider.dart';
import 'core/theme/theme.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'presentation/authentication/screens/login_screen.dart';
import 'presentation/home/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider()),
        // Add more providers here if needed
      ],
      child: const Hotel(),
    ),
  );
}

class Hotel extends StatelessWidget {
  const Hotel({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Card',
      theme: AppTheme.theme,
      home: authProvider.isLoggedIn
          ? BottomBar()
          : const MyHomePage(title: 'Hotel Page'),
      //if user is logged in redirect to home page

      routes: {
        // '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const MyHomePage(title: 'Hotel Page'),
        '/signUp': (context) => const SignUpScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}