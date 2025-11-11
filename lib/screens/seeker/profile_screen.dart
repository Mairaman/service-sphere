import 'package:flutter/material.dart';
import 'package:service_sphere/services/mock_data_services.dart';
import 'package:service_sphere/utils/colors.dart';
import 'package:service_sphere/screens/seeker/provider_detail_screen_enhanced.dart';
import 'package:service_sphere/widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = MockDataService.currentUser;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(user),
            SizedBox(height: 24),
            
            // Quick Actions
            _buildQuickActions(),
            SizedBox(height: 16),

            // User Stats
            _buildStatsRow(),
            SizedBox(height: 12),

            // Favorites
            _buildFavoritesSection(context),
            SizedBox(height: 16),

            // My Bookings
            _buildBookingsSection(),
            SizedBox(height: 24),

            // Menu Items
            _buildMenuItems(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> user) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Icon(
                Icons.person,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['fullName'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onBackground,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    user['email'],
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${user['rating']} • ${user['totalJobs']} jobs',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.onBackground,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionItem(
            icon: Icons.history,
            title: 'Bookings',
            onTap: () {
              // Navigate to bookings
            },
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildActionItem(
            icon: Icons.favorite,
            title: 'Favorites',
            onTap: () {
              // Navigate to favorites
            },
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildActionItem(
            icon: Icons.payment,
            title: 'Payments',
            onTap: () {
              // Navigate to payments
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {
              _showComingSoon(context, 'Notifications');
            },
          ),
          _buildMenuItem(
            icon: Icons.security,
            title: 'Privacy & Security',
            onTap: () {
              _showComingSoon(context, 'Privacy & Security');
            },
          ),
          _buildMenuItem(
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () {
              _showComingSoon(context, 'Help & Support');
            },
          ),
          _buildMenuItem(
            icon: Icons.info,
            title: 'About',
            onTap: () {
              _showComingSoon(context, 'About');
            },
          ),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              _showLogoutDialog(context);
            },
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : AppColors.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : AppColors.onBackground,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isLogout ? Colors.red : AppColors.secondary,
      ),
      onTap: onTap,
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming Soon!'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Settings',
          style: TextStyle(
            color: AppColors.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'App settings will be available in the next update.',
          style: TextStyle(color: AppColors.onBackground),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Logout',
          style: TextStyle(
            color: AppColors.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: AppColors.onBackground),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.secondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context, 
                '/welcome', 
                (route) => false
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final bookings = MockDataService.userBookings;
    final totalBookings = bookings.length;
    final totalSpent = bookings.fold<int>(0, (sum, b) => sum + (b['price'] as int? ?? 0));
    final favoritesCount = MockDataService.userFavorites.length;

    return Row(
      children: [
        Expanded(child: _buildStatCard('Bookings', '$totalBookings', Icons.history, AppColors.primary)),
        SizedBox(width: 12),
        Expanded(child: _buildStatCard('Spent', 'Rs $totalSpent', Icons.attach_money, Colors.green)),
        SizedBox(width: 12),
        Expanded(child: _buildStatCard('Favorites', '$favoritesCount', Icons.favorite, Colors.red)),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: color, size: 20),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(label, style: TextStyle(color: AppColors.secondary, fontSize: 12)),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onBackground)),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesSection(BuildContext context) {
    final favIds = MockDataService.userFavorites;
    final favorites = favIds.map((id) => MockDataService.getProviderById(id)).where((p) => p != null).cast<Map<String, dynamic>>().toList();

    if (favorites.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text('No favorite providers yet', style: TextStyle(color: AppColors.secondary)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('Favorite Providers', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onBackground)),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final provider = favorites[index];
              return _buildFavoriteItem(context, provider);
            },
            separatorBuilder: (_, __) => SizedBox(width: 12),
            itemCount: favorites.length,
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteItem(BuildContext context, Map<String, dynamic> provider) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProviderDetailScreen(provider: provider)),
        );
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Icon(Icons.person, color: AppColors.primary),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider['name'], style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onBackground)),
                  SizedBox(height: 4),
                  Text(provider['profession'], style: TextStyle(color: AppColors.secondary, fontSize: 12)),
                  SizedBox(height: 6),
                  Row(children: [Icon(Icons.star, size: 12, color: Colors.amber), SizedBox(width: 4), Text('${provider['rating']}', style: TextStyle(fontSize: 12, color: AppColors.onBackground))]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsSection() {
    final bookings = MockDataService.userBookings;
    if (bookings.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          'No bookings yet',
          style: TextStyle(color: AppColors.secondary),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'My Bookings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.onBackground,
            ),
          ),
        ),
        ...bookings.map((booking) => _buildBookingItem(booking)).toList(),
      ],
    );
  }

  Widget _buildBookingItem(Map<String, dynamic> booking) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getStatusColor(booking['status']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            Icons.calendar_today,
            color: _getStatusColor(booking['status']),
          ),
        ),
        title: Text(booking['service']),
        subtitle: Text('${booking['providerName']} • ${booking['date']}'),
        trailing: Chip(
          label: Text(
            booking['status'],
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
          backgroundColor: _getStatusColor(booking['status']),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return AppColors.primary;
    }
  }
}