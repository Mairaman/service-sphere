import 'package:flutter/material.dart';
import 'package:service_sphere/screens/provider/earnings_screen.dart';
import 'package:service_sphere/screens/provider/job_management_screen.dart';
import 'package:service_sphere/screens/provider/provider_profile_screen.dart';
import 'package:service_sphere/utils/colors.dart';

class ProviderDashboard extends StatefulWidget {
  const ProviderDashboard({Key? key}) : super(key: key);

  @override
  _ProviderDashboardState createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Provider Dashboard'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              _showNotifications(context);
            },
          ),
        ],
      ),
      body: _buildCurrentTab(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _currentTab == 0 ? _buildQuickActionButton() : null,
    );
  }

  Widget _buildCurrentTab() {
    switch (_currentTab) {
      case 0: return _buildDashboardTab();
      case 1: return _buildJobsTab();
      case 2: return _buildEarningsTab();
      case 3: return _buildProfileTab();
      default: return _buildDashboardTab();
    }
  }

  Widget _buildDashboardTab() {
    final stats = _getDashboardStats();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Welcome Section
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(Icons.person, color: AppColors.primary, size: 30),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onBackground,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Ready to take on new jobs?',
                          style: TextStyle(
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: Text('Online', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Stats Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildStatCard(
                'Pending Requests',
                stats['pendingRequests'].toString(),
                Icons.pending_actions,
                Colors.orange,
              ),
              _buildStatCard(
                'Active Jobs',
                stats['activeJobs'].toString(),
                Icons.work,
                Colors.blue,
              ),
              _buildStatCard(
                'Earnings (Today)',
                'Rs ${stats['todayEarnings']}',
                Icons.attach_money,
                Colors.green,
              ),
              _buildStatCard(
                'Rating',
                stats['rating'].toString(),
                Icons.star,
                Colors.amber,
              ),
            ],
          ),

          SizedBox(height: 24),

          // Quick Actions
          _buildQuickActions(),

          SizedBox(height: 24),

          // Recent Activity
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Update Availability',
                Icons.calendar_today,
                () {
                  _updateAvailability(context);
                },
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                'Add Service',
                Icons.add_circle,
                () {
                  _addNewService(context);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'View Portfolio',
                Icons.photo_library,
                () {
                  _viewPortfolio(context);
                },
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                'Quick Responses',
                Icons.quickreply,
                () {
                  _manageQuickResponses(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary, size: 24),
              SizedBox(height: 8),
              Text(
                text,
                textAlign: TextAlign.center,
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

  Widget _buildRecentActivity() {
    final activities = _getRecentActivities();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
        ),
        SizedBox(height: 12),
        ...activities.map((activity) => _buildActivityItem(activity)).toList(),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getActivityColor(activity['type']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            _getActivityIcon(activity['type']),
            color: _getActivityColor(activity['type']),
            size: 20,
          ),
        ),
        title: Text(activity['title']),
        subtitle: Text(activity['time']),
        trailing: Text(
          activity['status'],
          style: TextStyle(
            color: _getStatusColor(activity['status']),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // Helper methods for dashboard
  Map<String, dynamic> _getDashboardStats() {
    return {
      'pendingRequests': 3,
      'activeJobs': 2,
      'todayEarnings': 2500,
      'rating': 4.8,
    };
  }

  List<Map<String, dynamic>> _getRecentActivities() {
    return [
      {
        'type': 'booking',
        'title': 'New booking request - Plumbing',
        'time': '10 minutes ago',
        'status': 'Pending'
      },
      {
        'type': 'message',
        'title': 'Message from Sarah Ahmed',
        'time': '25 minutes ago',
        'status': 'Unread'
      },
      {
        'type': 'payment',
        'title': 'Payment received - Rs 1,500',
        'time': '2 hours ago',
        'status': 'Completed'
      },
      {
        'type': 'review',
        'title': 'New 5-star review',
        'time': '5 hours ago',
        'status': 'Rated'
      },
    ];
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'booking': return Colors.blue;
      case 'message': return Colors.green;
      case 'payment': return Colors.orange;
      case 'review': return Colors.purple;
      default: return AppColors.primary;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'booking': return Icons.book_online;
      case 'message': return Icons.chat;
      case 'payment': return Icons.payment;
      case 'review': return Icons.star;
      default: return Icons.notifications;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return Colors.orange;
      case 'unread': return Colors.blue;
      case 'completed': return Colors.green;
      case 'rated': return Colors.purple;
      default: return AppColors.secondary;
    }
  }

  Widget _buildQuickActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _showQuickActions(context);
      },
      backgroundColor: AppColors.primary,
      child: Icon(Icons.bolt, color: AppColors.onPrimary),
    );
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.work, color: AppColors.primary),
              title: Text('Mark as Available'),
              onTap: () {
                Navigator.pop(context);
                _updateAvailability(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule, color: AppColors.primary),
              title: Text('Set Working Hours'),
              onTap: () {
                Navigator.pop(context);
                _setWorkingHours(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_photo_alternate, color: AppColors.primary),
              title: Text('Add Portfolio Image'),
              onTap: () {
                Navigator.pop(context);
                _addPortfolioImage(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Placeholder methods for actions
  void _updateAvailability(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Availability updated successfully!')),
    );
  }

  void _addNewService(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Add new service feature coming soon!')),
    );
  }

  void _viewPortfolio(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Portfolio view feature coming soon!')),
    );
  }

  void _manageQuickResponses(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Quick responses feature coming soon!')),
    );
  }

  void _showNotifications(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notifications feature coming soon!')),
    );
  }

  void _setWorkingHours(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Working hours feature coming soon!')),
    );
  }

  void _addPortfolioImage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Portfolio image feature coming soon!')),
    );
  }

  // Other tabs (simplified for now)
  Widget _buildJobsTab() {
  return JobManagementScreen();
}


  // Replace the _buildEarningsTab method with:
Widget _buildEarningsTab() {
  return EarningsScreen();
}

Widget _buildProfileTab() {
  return ProviderProfileScreen();
}

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.secondary,
      currentIndex: _currentTab,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _currentTab = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'Jobs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Earnings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}