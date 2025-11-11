import 'package:flutter/material.dart';
import 'package:service_sphere/services/mock_data_services.dart';
import 'package:service_sphere/utils/colors.dart';
import 'package:service_sphere/widgets/bottom_nav_bar.dart';
import 'package:service_sphere/screens/seeker/service_categories_screen.dart';

class ServiceSeekerHome extends StatefulWidget {
  const ServiceSeekerHome({Key? key}) : super(key: key);

  @override
  _ServiceSeekerHomeState createState() => _ServiceSeekerHomeState();
}

class _ServiceSeekerHomeState extends State<ServiceSeekerHome> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time and Welcome Section - UPDATED COLOR SCHEME
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getCurrentTime(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onBackground,
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.surface,
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.secondary,
                ),
              ),
              Text(
                'to Service Sphere!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onBackground,
                ),
              ),
              const SizedBox(height: 24),

              // Search Bar - functional
              _buildSearchBar(),
              const SizedBox(height: 24),

              // Categories Header - UPDATED COLOR SCHEME
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onBackground,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ServiceCategoriesScreen()),
                      );
                    },
                    child: Text(
                      'Show All',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // First Row of Categories - UPDATED TO USE EMOJI ICONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryItem('Tailoring', '🧵', context),
                  _buildCategoryItem('Pest Control', '🐛', context),
                  _buildCategoryItem('Cleaning', '🧹', context),
                ],
              ),
              const SizedBox(height: 16),

              // Second Row of Categories - UPDATED TO USE EMOJI ICONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryItem('Baby Sitter', '👶', context),
                  _buildCategoryItem('Painting', '🎨', context),
                  _buildCategoryItem('AC Repair', '❄️', context),
                ],
              ),
              const SizedBox(height: 32),

              // Popular Services Header - UPDATED COLOR SCHEME
              Text(
                'Popular Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onBackground,
                ),
              ),
              const SizedBox(height: 16),

              // Service Provider Cards - filtered by search
              ..._filteredProviders.map((provider) {
                return Column(
                  children: [
                    _buildServiceProviderCard(provider, context),
                    const SizedBox(height: 12),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search service...',
          hintStyle: TextStyle(color: AppColors.hint),
          prefixIcon: Icon(Icons.search, color: AppColors.primary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> get _filteredProviders {
    if (_searchQuery.trim().isEmpty) {
      return MockDataService.serviceProviders.take(3).toList();
    }
    final q = _searchQuery.toLowerCase();
    return MockDataService.serviceProviders.where((provider) {
      final name = provider['name']?.toString().toLowerCase() ?? '';
      final profession = provider['profession']?.toString().toLowerCase() ?? '';
      final skills = (provider['skills'] as List<dynamic>?)?.join(' ').toLowerCase() ?? '';
      return name.contains(q) || profession.contains(q) || skills.contains(q);
    }).toList();
  }

  // Get current time in HH:mm format
  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  // Category Item - UPDATED TO USE EMOJI ICONS
  Widget _buildCategoryItem(String title, String emoji, BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            // Navigate to specific category
            final providers = _getProvidersForCategory(title);
            if (providers.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryProvidersScreen(
                    category: {
                      'name': title,
                      'icon': _getCategoryIcon(title),
                    },
                    providers: providers,
                  ),
                ),
              );
            } else {
              // Navigate to categories screen if no specific providers
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServiceCategoriesScreen()),
              );
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 8),
              Text(
                title,
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

  // Service Provider Card - UPDATED COLOR SCHEME
  Widget _buildServiceProviderCard(Map<String, dynamic> provider, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              Icons.person,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          
          // Name and Specialty
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      provider['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onBackground,
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (provider['isVerified'] == true)
                      Icon(Icons.verified, color: AppColors.primary, size: 16),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  provider['profession'],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${provider['rating']} (${provider['totalJobs']} reviews)',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Book Button
          SizedBox(
            width: 60,
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                _showBookingDialog(context, provider);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Book',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get providers for a category
  List<Map<String, dynamic>> _getProvidersForCategory(String categoryName) {
    return MockDataService.serviceProviders.where((provider) {
      final providerProfession = provider['profession']?.toString().toLowerCase() ?? '';
      final category = categoryName.toLowerCase();
      
      // Simple matching logic
      if (category == 'plumbing') return providerProfession.contains('plumb');
      if (category == 'electrical') return providerProfession.contains('electric');
      if (category == 'cleaning') return providerProfession.contains('clean');
      if (category == 'carpentry') return providerProfession.contains('carpent');
      if (category == 'tailoring') return providerProfession.contains('tailor');
      if (category == 'pest control') return providerProfession.contains('pest');
      if (category == 'baby sitter') return providerProfession.contains('baby');
      if (category == 'painting') return providerProfession.contains('paint');
      if (category == 'ac repair') return providerProfession.contains('ac') || providerProfession.contains('technician');
      if (category == 'moving') return providerProfession.contains('mover');
      if (category == 'beauty') return providerProfession.contains('beaut');
      if (category == 'gardening') return providerProfession.contains('garden');
      
      return providerProfession.contains(category);
    }).toList();
  }

  // Helper method to get category icon
  String _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'tailoring': return '🧵';
      case 'pest control': return '🐛';
      case 'cleaning': return '🧹';
      case 'baby sitter': return '👶';
      case 'painting': return '🎨';
      case 'ac repair': return '❄️';
      case 'electrical': return '💡';
      case 'plumbing': return '🚰';
      case 'carpentry': return '🪚';
      case 'gardening': return '🌿';
      case 'moving': return '🚚';
      case 'beauty': return '💄';
      default: return '🔧';
    }
  }

  // Show booking dialog
  void _showBookingDialog(BuildContext context, Map<String, dynamic> provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Book Service',
          style: TextStyle(
            color: AppColors.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Would you like to book ${provider['name']} for ${provider['profession']} services?',
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking request sent to ${provider['name']}'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Confirm',
              style: TextStyle(color: AppColors.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}