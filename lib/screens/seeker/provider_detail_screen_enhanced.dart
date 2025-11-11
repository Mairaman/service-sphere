import 'package:flutter/material.dart';
import 'package:service_sphere/utils/colors.dart';
import 'package:service_sphere/screens/seeker/chat_detail_screen.dart';
import 'package:service_sphere/screens/seeker/booking_confirmation_screen.dart';
import 'package:service_sphere/widgets/bottom_nav_bar.dart';

class ProviderDetailScreen extends StatefulWidget {
  final Map<String, dynamic> provider;

  const ProviderDetailScreen({Key? key, required this.provider}) : super(key: key);

  @override
  _ProviderDetailScreenState createState() => _ProviderDetailScreenState();
}

class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(provider['name']),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        actions: [
          IconButton(
            icon: Icon(_isBookmarked ? Icons.favorite : Icons.favorite_border),
            color: _isBookmarked ? Colors.red : AppColors.onBackground,
            onPressed: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });

              // Show confirmation
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isBookmarked ? 'Added to favorites' : 'Removed from favorites'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Provider Header Card
            _buildProviderHeader(provider),
            const SizedBox(height: 24),

            // Service Portfolio
            _buildServicePortfolio(provider),
            const SizedBox(height: 24),

            // Service Pricing Breakdown
            _buildPricingBreakdown(provider),
            const SizedBox(height: 24),

            // About Section
            _buildAboutSection(provider),
            const SizedBox(height: 24),

            // Skills Section
            _buildSkillsSection(provider),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(provider: provider),
                ),
              );
            },
            backgroundColor: AppColors.secondary,
            child: const Icon(Icons.chat),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 60,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingConfirmationScreen(provider: provider),
                  ),
                );
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.calendar_today),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderHeader(Map<String, dynamic> provider) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Avatar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryVariant,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.person, size: 60, color: AppColors.primary),
            ),
            const SizedBox(height: 16),

            // Name and Profession
            Text(
              provider['name'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              provider['profession'],
              style: TextStyle(
                fontSize: 16,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 12),

            // Rating and Reviews
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '${provider['rating']}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 16),
                Text(
                  '${provider['totalJobs']} Jobs',
                  style: TextStyle(color: AppColors.secondary),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Verification Badge
            if (provider['isVerified'] == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, color: AppColors.primary, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Verified Professional',
                      style: TextStyle(color: AppColors.primary, fontSize: 12),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicePortfolio(Map<String, dynamic> provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Portfolio',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(4, (index) {
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryVariant,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(
                  Icons.image,
                  color: AppColors.primary,
                  size: 40,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildPricingBreakdown(Map<String, dynamic> provider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service Pricing',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildPricingRow('Hourly Rate', 'Rs ${provider['hourlyRate']}/hr'),
            const Divider(height: 20),
            _buildPricingRow('Estimated Project', 'Rs ${(provider['hourlyRate'] as int) * 4}'),
            const Divider(height: 20),
            _buildPricingRow('Service Fee', 'Rs 100'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total (4 hours)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Rs ${(provider['hourlyRate'] as int) * 4 + 100}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: AppColors.secondary)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildAboutSection(Map<String, dynamic> provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          'Professional ${provider['profession'].toLowerCase()} with ${provider['totalJobs']} completed projects. Specializing in ${provider['skills'][0].toString().toLowerCase()}.',
          style: TextStyle(
            color: AppColors.onBackground,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(Map<String, dynamic> provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills & Expertise',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: (provider['skills'] as List<dynamic>).map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                skill.toString(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
