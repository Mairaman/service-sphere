import 'package:flutter/material.dart';
import 'package:service_sphere/screens/seeker/chats_screen.dart';
import 'package:service_sphere/screens/seeker/profile_screen.dart';
import 'package:service_sphere/screens/seeker/service_seeker_home.dart';
import '../screens/seeker/service_categories_screen.dart';
import '../utils/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.secondary,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        _navigateToPage(context, index);
      },
    );
  }

  void _navigateToPage(BuildContext context, int index) {
    // Avoid rebuilding the same page
    if (index == currentIndex) {
      return;
    }

    Widget page;
    switch (index) {
      case 0:
        page = const ServiceSeekerHome();
        break;
      case 1:
        page = const ServiceCategoriesScreen();
        break;
      case 2:
        page = const ChatsScreen();
        break;
      case 3:
        page = const ProfileScreen();
        break;
      default:
        page = const ServiceSeekerHome();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
