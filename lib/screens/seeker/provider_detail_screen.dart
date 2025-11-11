import 'package:flutter/material.dart';
import 'package:service_sphere/utils/colors.dart';

class ProviderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> provider;

  const ProviderDetailScreen({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Provider Details'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Provider Header
            _buildProviderHeader(),
            SizedBox(height: 24),
            
            // Skills Section
            _buildSkillsSection(),
            SizedBox(height: 24),
            
            // About Section
            _buildAboutSection(),
            SizedBox(height: 24),
            
            // Reviews Section
            _buildReviewsSection(),
            SizedBox(height: 24),
            
            // Book Button
            _buildBookButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderHeader() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primaryVariant,
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
                  Row(
                    children: [
                      Text(
                        provider['name'] ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onBackground,
                        ),
                      ),
                      SizedBox(width: 8),
                      if (provider['isVerified'] == true)
                        Icon(Icons.verified, color: Colors.blue, size: 20),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    provider['profession'] ?? 'Service Provider',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '${provider['rating']} (${provider['totalJobs']} jobs)',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.onBackground,
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.location_on, color: AppColors.secondary, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${provider['distance']} km away',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.secondary,
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

  Widget _buildSkillsSection() {
    final skills = provider['skills'] as List<dynamic>? ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills & Services',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) {
            return Chip(
              label: Text(
                skill.toString(),
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: AppColors.primaryVariant,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Experienced ${provider['profession']?.toString().toLowerCase() ?? 'service provider'} '
          'with ${provider['totalJobs']} completed jobs. '
          'Specialized in ${(provider['skills'] as List<dynamic>?).toString().replaceAll('[', '').replaceAll(']', '')}.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.onBackground,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pricing',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
        ),
        SizedBox(height: 12),
        ListTile(
          leading: Icon(Icons.attach_money, color: AppColors.primary),
          title: Text('Hourly Rate'),
          subtitle: Text('Starting price'),
          trailing: Text(
            'Rs ${provider['hourlyRate']}/hr',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          _showBookingDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Book Now',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book Service'),
        content: Text('Booking functionality will be implemented with backend integration.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}