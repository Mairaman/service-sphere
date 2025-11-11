import 'package:flutter/material.dart';
import 'package:service_sphere/services/mock_data_services.dart';
import 'package:service_sphere/utils/colors.dart';
import 'package:service_sphere/widgets/bottom_nav_bar.dart';
import 'package:service_sphere/screens/seeker/provider_detail_screen.dart';

class ServiceCategoriesScreen extends StatelessWidget {
  const ServiceCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Service Categories'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),
          
          // Categories List
          Expanded(
            child: _buildCategoriesList(context),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search services...',
            hintStyle: TextStyle(color: AppColors.hint),
            prefixIcon: Icon(Icons.search, color: AppColors.primary),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onChanged: (value) {
            // Implement search functionality
            print('Searching for: $value');
          },
        ),
      ),
    );
  }

  // Categories List - UPDATED: Added context parameter
  Widget _buildCategoriesList(BuildContext context) {
    final categories = MockDataService.serviceCategories;
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columns
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildCategoryGridItem(category, context);
      },
    );
  }

  // Category Grid Item - UPDATED: Added helper methods inside
  Widget _buildCategoryGridItem(Map<String, dynamic> category, BuildContext context) {
    // Get providers for this category
    final providers = _getProvidersForCategory(category['name']);
    
    return GestureDetector(
      onTap: () {
        _navigateToCategoryProviders(context, category, providers);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category['icon'],
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              category['name'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 4),
            Text(
              '${providers.length} providers',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get providers for a specific category - ADDED THIS METHOD
  List<Map<String, dynamic>> _getProvidersForCategory(String categoryName) {
    return MockDataService.serviceProviders.where((provider) {
      // Match provider profession with category name
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

  // Navigate to category providers - ADDED THIS METHOD
  void _navigateToCategoryProviders(
    BuildContext context, 
    Map<String, dynamic> category, 
    List<Map<String, dynamic>> providers
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryProvidersScreen(
          category: category,
          providers: providers,
        ),
      ),
    );
  }

  // Filter Dialog
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Filter Services',
            style: TextStyle(
              color: AppColors.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sort by:',
                style: TextStyle(
                  color: AppColors.onBackground,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _buildFilterOption('Most Popular', true),
              _buildFilterOption('Highest Rated', false),
              _buildFilterOption('Nearest First', false),
              _buildFilterOption('Price: Low to High', false),
            ],
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
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text(
                'Apply',
                style: TextStyle(color: AppColors.onPrimary),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterOption(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? AppColors.primary : AppColors.secondary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: AppColors.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}

// Screen for showing providers in a specific category
class CategoryProvidersScreen extends StatelessWidget {
  final Map<String, dynamic> category;
  final List<Map<String, dynamic>> providers;

  const CategoryProvidersScreen({
    Key? key,
    required this.category,
    required this.providers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(category['name']),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
      ),
      body: providers.isEmpty ? _buildEmptyState() : _buildProvidersList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.secondary,
          ),
          const SizedBox(height: 16),
          Text(
            'No providers available',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.onBackground,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for ${category['name']} services',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProvidersList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: providers.length,
      itemBuilder: (context, index) {
        final provider = providers[index];
        return _buildProviderCard(provider, context);
      },
    );
  }

  Widget _buildProviderCard(Map<String, dynamic> provider, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.primaryVariant,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(
              Icons.person,
              size: 30,
              color: AppColors.primary,
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              provider['name'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(width: 8),
            if (provider['isVerified'] == true)
              Icon(Icons.verified, color: AppColors.primary, size: 16),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              provider['profession'],
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: AppColors.secondary, size: 16),
                const SizedBox(width: 4),
                Text(
                  provider['rating'].toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${provider['totalJobs']} jobs)',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.hint,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.location_on, color: AppColors.secondary, size: 14),
                const SizedBox(width: 4),
                Text(
                  '${provider['distance']} km',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.hint,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: (provider['skills'] as List<dynamic>).take(3).map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    skill.toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.primary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rs ${provider['hourlyRate']}/hr',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Starting',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.hint,
              ),
            ),
          ],
        ),
        onTap: () {
          // Navigate to provider detail screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProviderDetailScreen(provider: provider),
            ),
          );
        },
      ),
    );
  }
}