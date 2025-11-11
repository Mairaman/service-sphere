import 'package:flutter/material.dart';
import 'package:service_sphere/screens/provider/earnings_screen.dart';
import 'package:service_sphere/screens/provider/job_management_screen.dart';
import 'package:service_sphere/screens/provider/provider_profile_screen.dart';
import 'package:service_sphere/screens/seeker/chats_screen.dart';
import 'package:service_sphere/screens/seeker/profile_screen.dart';
import 'package:service_sphere/screens/seeker/provider_detail_screen.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/seeker/service_categories_screen.dart';
import 'screens/seeker/service_seeker_home.dart';
import 'utils/colors.dart';

void main() {
  runApp(ServiceSphere());
}

class ServiceSphere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Sphere',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ServiceSeekerHome(),
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => ServiceSeekerHome(),
        '/categories': (context) => ServiceCategoriesScreen(),
        '/chats': (context) => ChatsScreen(),
        '/profile': (context) => ProfileScreen(),
        '/job-management': (context) => JobManagementScreen(),
        '/earnings': (context) => EarningsScreen(),
        '/provider-profile': (context) => ProviderProfileScreen(),

      },
      onGenerateRoute: (settings) {
        if (settings.name == '/provider-detail') {
          final provider = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ProviderDetailScreen(provider: provider),
          );
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}