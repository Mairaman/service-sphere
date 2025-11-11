import 'package:flutter/material.dart';
import 'package:service_sphere/screens/seeker/home_screen.dart';
import 'package:service_sphere/services/mock_data_services.dart';
import '../../utils/colors.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _cnicController = TextEditingController();
  final _serviceDescriptionController = TextEditingController();
  final _hourlyRateController = TextEditingController();
  final _serviceAreaController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _userType = 'seeker'; // 'seeker' or 'provider'
  
  // Provider-specific fields
  List<String> _selectedServices = [];
  String _experienceLevel = 'Beginner (0-2 years)';
  List<String> _serviceAreas = [];
  List<String> _availableDocuments = ['CNIC', 'License', 'Certification', 'Portfolio'];
  List<String> _selectedDocuments = [];
  bool _isAvailable = true;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Validate provider-specific fields
      if (_userType == 'provider') {
        if (_selectedServices.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please select at least one service category'),
              backgroundColor: AppColors.error,
            ),
          );
          setState(() { _isLoading = false; });
          return;
        }
        if (_hourlyRateController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please enter your hourly rate'),
              backgroundColor: AppColors.error,
            ),
          );
          setState(() { _isLoading = false; });
          return;
        }
      }

      // Simulate API call delay
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Mock successful registration
      print('✅ MOCK: Registration successful for ${_emailController.text}');
      print('User Type: $_userType');
      if (_userType == 'provider') {
        print('Selected Services: $_selectedServices');
        print('Experience: $_experienceLevel');
        print('Hourly Rate: ${_hourlyRateController.text}');
        print('Service Areas: $_serviceAreas');
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration successful!'),
          backgroundColor: AppColors.primary,
        ),
      );

      // Navigate to home screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    }
  }

  Widget _buildProviderSpecificFields() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Service Provider Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
        ),
        SizedBox(height: 16),

        // Service Categories Selection
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service Categories *',
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.onBackground),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: MockDataService.serviceCategories.map((category) {
                    final isSelected = _selectedServices.contains(category['name']);
                    return FilterChip(
                      label: Text(category['name']),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedServices.add(category['name']);
                          } else {
                            _selectedServices.remove(category['name']);
                          }
                        });
                      },
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.onPrimary : AppColors.onBackground,
                      ),
                    );
                  }).toList(),
                ),
                if (_selectedServices.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Please select at least one service category',
                      style: TextStyle(fontSize: 12, color: AppColors.error),
                    ),
                  ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Experience Level
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Experience Level',
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.onBackground),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _experienceLevel,
                  items: [
                    'Beginner (0-2 years)',
                    'Intermediate (2-5 years)',
                    'Expert (5+ years)',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _experienceLevel = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Hourly Rate
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hourly Rate (PKR) *',
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.onBackground),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _hourlyRateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'e.g., 500',
                    prefixText: 'Rs ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (_userType == 'provider' && (value == null || value.isEmpty)) {
                      return 'Please enter your hourly rate';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Service Areas
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service Areas',
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.onBackground),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _serviceAreaController,
                  decoration: InputDecoration(
                    hintText: 'Enter area (e.g., G-11, F-10)',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (_serviceAreaController.text.isNotEmpty) {
                          setState(() {
                            _serviceAreas.add(_serviceAreaController.text);
                            _serviceAreaController.clear();
                          });
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _serviceAreas.map((area) {
                    return Chip(
                      label: Text(area),
                      onDeleted: () {
                        setState(() {
                          _serviceAreas.remove(area);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Service Description
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service Description',
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.onBackground),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _serviceDescriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Describe your services, expertise, and what makes you unique...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Document Upload
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Documents (Upload Later)',
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.onBackground),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _availableDocuments.map((doc) {
                    final isSelected = _selectedDocuments.contains(doc);
                    return FilterChip(
                      label: Text(doc),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedDocuments.add(doc);
                          } else {
                            _selectedDocuments.remove(doc);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 8),
                Text(
                  'You will be asked to upload these documents during verification',
                  style: TextStyle(fontSize: 12, color: AppColors.hint),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Availability
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Available for Work',
                    style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.onBackground),
                  ),
                ),
                Switch(
                  value: _isAvailable,
                  onChanged: (value) {
                    setState(() {
                      _isAvailable = value;
                    });
                  },
                  activeColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header
              Text(
                'Join Service Sphere',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onBackground,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Create your account to get started',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: 40),

              // User Type Selection
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'I want to:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.onBackground,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ChoiceChip(
                              label: Text('Find Services'),
                              selected: _userType == 'seeker',
                              onSelected: (selected) {
                                setState(() {
                                  _userType = 'seeker';
                                });
                              },
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: _userType == 'seeker' ? AppColors.onPrimary : AppColors.onBackground,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ChoiceChip(
                              label: Text('Provide Services'),
                              selected: _userType == 'provider',
                              onSelected: (selected) {
                                setState(() {
                                  _userType = 'provider';
                                });
                              },
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: _userType == 'provider' ? AppColors.onPrimary : AppColors.onBackground,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Name field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: AppColors.onBackground),
                  prefixIcon: Icon(Icons.person, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Email field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: AppColors.onBackground),
                  prefixIcon: Icon(Icons.email, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Phone field
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: AppColors.onBackground),
                  prefixIcon: Icon(Icons.phone, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // CNIC field (only for providers)
              if (_userType == 'provider') ...[
                TextFormField(
                  controller: _cnicController,
                  decoration: InputDecoration(
                    labelText: 'CNIC Number',
                    labelStyle: TextStyle(color: AppColors.onBackground),
                    prefixIcon: Icon(Icons.badge, color: AppColors.primary),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    hintText: 'XXXXX-XXXXXXX-X',
                    hintStyle: TextStyle(color: AppColors.hint),
                  ),
                  validator: (value) {
                    if (_userType == 'provider' && (value == null || value.isEmpty)) {
                      return 'CNIC is required for service providers';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
              ],

              // Provider-specific fields
              if (_userType == 'provider') ...[
                _buildProviderSpecificFields(),
                SizedBox(height: 16),
              ],

              // Password field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: AppColors.onBackground),
                  prefixIcon: Icon(Icons.lock, color: AppColors.primary),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.secondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Confirm Password field
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: AppColors.onBackground),
                  prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.secondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                obscureText: _obscureConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Register button
              _isLoading
                  ? CircularProgressIndicator(color: AppColors.primary)
                  : SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
              SizedBox(height: 20),

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: AppColors.secondary),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _cnicController.dispose();
    _serviceDescriptionController.dispose();
    _hourlyRateController.dispose();
    _serviceAreaController.dispose();
    super.dispose();
  }
}