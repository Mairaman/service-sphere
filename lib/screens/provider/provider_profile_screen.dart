import 'package:flutter/material.dart';
import 'package:service_sphere/services/mock_data_services.dart';
import 'package:service_sphere/utils/colors.dart';

class ProviderProfileScreen extends StatefulWidget {
  const ProviderProfileScreen({Key? key}) : super(key: key);

  @override
  _ProviderProfileScreenState createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  final Map<String, dynamic> _providerData = {
    ...MockDataService.currentProvider,
    'workingHours': {
      'monday': {'start': '09:00', 'end': '17:00', 'enabled': true},
      'tuesday': {'start': '09:00', 'end': '17:00', 'enabled': true},
      'wednesday': {'start': '09:00', 'end': '17:00', 'enabled': true},
      'thursday': {'start': '09:00', 'end': '17:00', 'enabled': true},
      'friday': {'start': '09:00', 'end': '17:00', 'enabled': true},
      'saturday': {'start': '10:00', 'end': '14:00', 'enabled': false},
      'sunday': {'start': '10:00', 'end': '14:00', 'enabled': false},
    },
    'portfolioImages': [
      'https://picsum.photos/300/200?random=1',
      'https://picsum.photos/300/200?random=2',
      'https://picsum.photos/300/200?random=3',
    ],
  };

  bool _isEditing = false;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _hourlyRateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _serviceAreaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProviderData();
  }

  void _loadProviderData() {
    _nameController.text = _providerData['fullName'];
    _phoneController.text = _providerData['phone'];
    _hourlyRateController.text = _providerData['hourlyRate'].toString();
    _descriptionController.text = _providerData['description'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Provider Profile'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveProfile : _startEditing,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(),
            SizedBox(height: 24),

            // Availability Status
            _buildAvailabilityCard(),
            SizedBox(height: 16),

            // Personal Information
            _buildPersonalInfoCard(),
            SizedBox(height: 16),

            // Service Information
            _buildServiceInfoCard(),
            SizedBox(height: 16),

            // Working Hours
            _buildWorkingHoursCard(),
            SizedBox(height: 16),

            // Portfolio
            _buildPortfolioCard(),
            SizedBox(height: 16),

            // Documents
            _buildDocumentsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Icon(Icons.person, size: 40, color: AppColors.primary),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _providerData['fullName'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onBackground,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _providerData['profession'],
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${_providerData['rating']} (${_providerData['totalJobs']} jobs)',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.onBackground,
                        ),
                      ),
                      SizedBox(width: 16),
                      if (_providerData['isVerified'])
                        Row(
                          children: [
                            Icon(Icons.verified, color: Colors.blue, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Verified',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ],
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

  Widget _buildAvailabilityCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Availability Status',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.onBackground,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _providerData['isAvailable'] 
                        ? 'Available for new jobs' 
                        : 'Not available',
                    style: TextStyle(
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _providerData['isAvailable'],
              onChanged: _isEditing ? (value) {
                setState(() {
                  _providerData['isAvailable'] = value;
                });
              } : null,
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: AppColors.primary, size: 20),
                SizedBox(width: 8),
                Text(
                  'Personal Information',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onBackground,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildEditableField(
              label: 'Full Name',
              controller: _nameController,
              icon: Icons.person,
            ),
            SizedBox(height: 12),
            _buildEditableField(
              label: 'Phone Number',
              controller: _phoneController,
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 12),
            _buildReadOnlyField(
              label: 'Email',
              value: _providerData['email'],
              icon: Icons.email,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceInfoCard() {
    final services = _providerData['services'] as List<dynamic>? ?? [];
    final serviceAreas = _providerData['serviceAreas'] as List<dynamic>? ?? [];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.work, color: AppColors.primary, size: 20),
                SizedBox(width: 8),
                Text(
                  'Service Information',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onBackground,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Hourly Rate
            _buildEditableField(
              label: 'Hourly Rate (PKR)',
              controller: _hourlyRateController,
              icon: Icons.attach_money,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),

            // Experience Level
            _buildReadOnlyField(
              label: 'Experience Level',
              value: _providerData['experience'],
              icon: Icons.timeline,
            ),
            SizedBox(height: 12),

            // Services
            Text(
              'Services Offered',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: services.map((service) {
                return Chip(
                  label: Text(service.toString()),
                  backgroundColor: AppColors.primaryVariant,
                );
              }).toList(),
            ),
            SizedBox(height: 12),

            // Service Areas
            Text(
              'Service Areas',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: serviceAreas.map((area) {
                return Chip(
                  label: Text(area.toString()),
                  onDeleted: _isEditing ? () {
                    setState(() {
                      serviceAreas.remove(area);
                    });
                  } : null,
                );
              }).toList(),
            ),
            SizedBox(height: 8),
            if (_isEditing) ...[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _serviceAreaController,
                      decoration: InputDecoration(
                        hintText: 'Add service area...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_serviceAreaController.text.isNotEmpty) {
                        setState(() {
                          serviceAreas.add(_serviceAreaController.text);
                          _serviceAreaController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
            ],

            // Service Description
            SizedBox(height: 12),
            Text(
              'Service Description',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              enabled: _isEditing,
              decoration: InputDecoration(
                hintText: 'Describe your services...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHoursCard() {
    final workingHours = _providerData['workingHours'] as Map<String, dynamic>;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: AppColors.primary, size: 20),
                SizedBox(width: 8),
                Text(
                  'Working Hours',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onBackground,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ..._buildWorkingHoursList(workingHours),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildWorkingHoursList(Map<String, dynamic> workingHours) {
    final days = [
      {'key': 'monday', 'label': 'Monday'},
      {'key': 'tuesday', 'label': 'Tuesday'},
      {'key': 'wednesday', 'label': 'Wednesday'},
      {'key': 'thursday', 'label': 'Thursday'},
      {'key': 'friday', 'label': 'Friday'},
      {'key': 'saturday', 'label': 'Saturday'},
      {'key': 'sunday', 'label': 'Sunday'},
    ];

    return days.map((day) {
      final dayData = workingHours[day['key']] as Map<String, dynamic>;
      return Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                day['label']!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.onBackground,
                ),
              ),
            ),
            Switch(
              value: dayData['enabled'],
              onChanged: _isEditing ? (value) {
                setState(() {
                  dayData['enabled'] = value;
                });
              } : null,
              activeColor: AppColors.primary,
            ),
            SizedBox(width: 16),
            if (dayData['enabled']) ...[
              Expanded(
                child: Text(
                  '${dayData['start']} - ${dayData['end']}',
                  style: TextStyle(color: AppColors.secondary),
                ),
              ),
              if (_isEditing)
                IconButton(
                  icon: Icon(Icons.edit, size: 18),
                  onPressed: () => _editWorkingHours(day['key']!, dayData),
                ),
            ] else ...[
              Expanded(
                child: Text(
                  'Not working',
                  style: TextStyle(color: AppColors.hint),
                ),
              ),
            ],
          ],
        ),
      );
    }).toList();
  }

  Widget _buildPortfolioCard() {
    final portfolioImages = _providerData['portfolioImages'] as List<dynamic>;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.photo_library, color: AppColors.primary, size: 20),
                SizedBox(width: 8),
                Text(
                  'Portfolio',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onBackground,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Showcase your work with photos',
              style: TextStyle(color: AppColors.secondary),
            ),
            SizedBox(height: 12),
            portfolioImages.isEmpty
                ? _buildEmptyPortfolio()
                : _buildPortfolioGrid(portfolioImages),
            SizedBox(height: 12),
            if (_isEditing)
              ElevatedButton.icon(
                onPressed: _addPortfolioImage,
                icon: Icon(Icons.add_photo_alternate),
                label: Text('Add Portfolio Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyPortfolio() {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(Icons.photo_library, size: 48, color: AppColors.secondary),
          SizedBox(height: 8),
          Text(
            'No portfolio images',
            style: TextStyle(color: AppColors.secondary),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioGrid(List<dynamic> images) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(images[index].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (_isEditing)
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => _removePortfolioImage(index),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 16, color: Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildDocumentsCard() {
    final documents = _providerData['documents'] as List<dynamic>? ?? [];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.folder, color: AppColors.primary, size: 20),
                SizedBox(width: 8),
                Text(
                  'Documents',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onBackground,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Verification documents for your profile',
              style: TextStyle(color: AppColors.secondary),
            ),
            SizedBox(height: 12),
            ...documents.map((doc) => _buildDocumentItem(doc.toString())).toList(),
            SizedBox(height: 8),
            if (_isEditing)
              ElevatedButton.icon(
                onPressed: _addDocument,
                icon: Icon(Icons.upload_file),
                label: Text('Upload Document'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentItem(String document) {
    return ListTile(
      leading: Icon(Icons.description, color: AppColors.primary),
      title: Text(document),
      trailing: _isEditing ? IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () => _removeDocument(document),
      ) : _providerData['isVerified'] 
          ? Icon(Icons.verified, color: Colors.green)
          : Icon(Icons.pending, color: Colors.orange),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      enabled: _isEditing,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return TextField(
      controller: TextEditingController(text: value),
      enabled: false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }

  // Action Methods
  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _saveProfile() {
    // Validate and save data
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    if (_hourlyRateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter hourly rate')),
      );
      return;
    }

    // Update provider data
    setState(() {
      _providerData['fullName'] = _nameController.text;
      _providerData['phone'] = _phoneController.text;
      _providerData['hourlyRate'] = int.tryParse(_hourlyRateController.text) ?? 500;
      _providerData['description'] = _descriptionController.text;
      _isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _editWorkingHours(String day, Map<String, dynamic> dayData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Working Hours for ${day.capitalize()}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: dayData['start']),
              decoration: InputDecoration(labelText: 'Start Time (HH:MM)'),
              onChanged: (value) => dayData['start'] = value,
            ),
            SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: dayData['end']),
              decoration: InputDecoration(labelText: 'End Time (HH:MM)'),
              onChanged: (value) => dayData['end'] = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _addPortfolioImage() {
    // In real app, this would open image picker
    setState(() {
      final portfolioImages = _providerData['portfolioImages'] as List<dynamic>;
      portfolioImages.add('https://picsum.photos/300/200?random=${portfolioImages.length + 1}');
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Portfolio image added (mock)')),
    );
  }

  void _removePortfolioImage(int index) {
    setState(() {
      final portfolioImages = _providerData['portfolioImages'] as List<dynamic>;
      portfolioImages.removeAt(index);
    });
  }

  void _addDocument() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Document'),
        content: Text('Document upload functionality will be implemented with backend integration.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _removeDocument(String document) {
    setState(() {
      final documents = _providerData['documents'] as List<dynamic>;
      documents.remove(document);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _hourlyRateController.dispose();
    _descriptionController.dispose();
    _serviceAreaController.dispose();
    super.dispose();
  }
}

// Extension for string capitalization
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}