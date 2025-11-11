// lib/services/mock_data_service.dart
class MockDataService {
  // Simple runtime flags for demo login flow
  static bool isLoggedIn = false;
  static String currentUserType = 'seeker';

  // Mock provider data (for provider accounts / previews)
  static Map<String, dynamic> get currentProvider {
    return {
      'uid': 'provider_123',
      'email': 'provider@example.com',
      'fullName': 'Ahmed Khan',
      'phone': '+923001234567',
      'userType': 'provider',
      'profession': 'Plumber',
      'rating': 4.8,
      'totalJobs': 127,
      'isVerified': true,
      'isAvailable': true,
      'hourlyRate': 500,
      'experience': 'Expert (5+ years)',
      'serviceAreas': ['G-11', 'F-10', 'I-8'],
      'services': ['Plumbing', 'Pipe Repair', 'Drain Cleaning'],
      'documents': ['CNIC', 'License'],
      'description': 'Experienced plumber with 8 years of experience in residential and commercial plumbing.',
    };
  }
  // Mock user data
  static Map<String, dynamic> get currentUser {
    return {
      'uid': 'user_123',
      'email': 'user@example.com',
      'fullName': 'John Doe',
      'phone': '+1234567890',
      'userType': 'seeker', // or 'provider'
      'rating': 4.5,
      'totalJobs': 15,
      'isVerified': true,
    };
  }

  // Mock service categories - UPDATED WITH ALL SERVICES
  static List<Map<String, dynamic>> get serviceCategories {
    return [
      {
        'id': '1',
        'name': 'Plumbing',
        'icon': '🚰',
        'color': 0xFF059669, // Forest Green
      },
      {
        'id': '2', 
        'name': 'Electrical',
        'icon': '💡',
        'color': 0xFF059669, // Forest Green
      },
      {
        'id': '3',
        'name': 'Cleaning',
        'icon': '🧹',
        'color': 0xFF059669, // Forest Green
      },
      {
        'id': '4',
        'name': 'Carpentry',
        'icon': '🪚',
        'color': 0xFF059669, // Forest Green
      },
      {
        'id': '5',
        'name': 'Tailoring',
        'icon': '🧵',
        'color': 0xFF059669, // Forest Green
      },
      {
        'id': '6',
        'name': 'Pest Control',
        'icon': '🐛',
        'color': 0xFF059669, // Forest Green
      },
      {
        'id': '7',
        'name': 'Baby Sitter',
        'icon': '👶',
        'color': 0xFF059669, // Forest Green
      },
      {
        'id': '8',
        'name': 'Painting',
        'icon': '🎨',
        'color': 0xFF059669, // Forest Green
      },
      {
        'id': '9',
        'name': 'AC Repair',
        'icon': '❄️',
        'color': 0xFF059669, // Forest Green
      },
      {
        'id': '10',
        'name': 'Moving',
        'icon': '🚚',
        'color': 0xFF059669, // Forest Green
      },
      {
        'id': '11',
        'name': 'Beauty',
        'icon': '💄',
        'color': 0xFF059669, // Forest Green
      },
      {
        'id': '12',
        'name': 'Gardening',
        'icon': '🌿',
        'color': 0xFF059669, // Forest Green
      },
    ];
  }

  // Mock service providers - SINGLE DEFINITION
  static List<Map<String, dynamic>> get serviceProviders {
    return [
      {
        'id': '1',
        'name': 'Ahmed Khan',
        'profession': 'Plumber',
        'rating': 4.8,
        'totalJobs': 127,
        'distance': 2.5,
        'hourlyRate': 500,
        'image': '',
        'isVerified': true,
        'skills': ['Pipe Fixing', 'Drain Cleaning', 'Tap Installation'],
      },
      {
        'id': '2',
        'name': 'Fatima Ali',
        'profession': 'Tailor',
        'rating': 4.9,
        'totalJobs': 89,
        'distance': 1.2,
        'hourlyRate': 300,
        'image': '',
        'isVerified': true,
        'skills': ['Dress Making', 'Alterations', 'Embroidery'],
      },
      {
        'id': '3',
        'name': 'Usman Ahmed',
        'profession': 'Electrician',
        'rating': 4.6,
        'totalJobs': 203,
        'distance': 3.1,
        'hourlyRate': 600,
        'image': '',
        'isVerified': true,
        'skills': ['Wiring', 'Switch Repair', 'Panel Installation'],
      },
      {
        'id': '4',
        'name': 'Zara Khan',
        'profession': 'Cleaner',
        'rating': 4.7,
        'totalJobs': 156,
        'distance': 0.8,
        'hourlyRate': 400,
        'image': '',
        'isVerified': true,
        'skills': ['Deep Cleaning', 'Office Cleaning', 'Carpet Cleaning'],
      },
      {
        'id': '5',
        'name': 'Bilal Raza',
        'profession': 'Carpenter',
        'rating': 4.5,
        'totalJobs': 98,
        'distance': 2.2,
        'hourlyRate': 550,
        'image': '',
        'isVerified': true,
        'skills': ['Furniture Making', 'Repairs', 'Installation'],
      },
      {
        'id': '6',
        'name': 'Sara Javed',
        'profession': 'Beautician',
        'rating': 4.9,
        'totalJobs': 67,
        'distance': 1.5,
        'hourlyRate': 800,
        'image': '',
        'isVerified': true,
        'skills': ['Makeup', 'Skincare', 'Hair Styling'],
      },
      {
        'id': '7',
        'name': 'Rashid Mahmood',
        'profession': 'Pest Control',
        'rating': 4.4,
        'totalJobs': 112,
        'distance': 3.5,
        'hourlyRate': 700,
        'image': '',
        'isVerified': true,
        'skills': ['Insect Control', 'Rodent Control', 'Fumigation'],
      },
      {
        'id': '8',
        'name': 'Ayesha Malik',
        'profession': 'Baby Sitter',
        'rating': 4.8,
        'totalJobs': 45,
        'distance': 1.8,
        'hourlyRate': 350,
        'image': '',
        'isVerified': true,
        'skills': ['Child Care', 'First Aid', 'Educational Activities'],
      },
      {
        'id': '9',
        'name': 'Kamran Ali',
        'profession': 'Painter',
        'rating': 4.3,
        'totalJobs': 78,
        'distance': 2.8,
        'hourlyRate': 450,
        'image': '',
        'isVerified': true,
        'skills': ['Wall Painting', 'Texture Work', 'Exterior Painting'],
      },
      {
        'id': '10',
        'name': 'Nadeem Shah',
        'profession': 'AC Technician',
        'rating': 4.6,
        'totalJobs': 134,
        'distance': 3.2,
        'hourlyRate': 650,
        'image': '',
        'isVerified': true,
        'skills': ['AC Repair', 'Gas Filling', 'Maintenance'],
      },
      {
        'id': '11',
        'name': 'Tariq Mehmood',
        'profession': 'Mover',
        'rating': 4.2,
        'totalJobs': 89,
        'distance': 4.1,
        'hourlyRate': 900,
        'image': '',
        'isVerified': true,
        'skills': ['Packing', 'Loading', 'Transportation'],
      },
      {
        'id': '12',
        'name': 'Asif Ali',
        'profession': 'Gardener',
        'rating': 4.7,
        'totalJobs': 67,
        'distance': 1.1,
        'hourlyRate': 300,
        'image': '',
        'isVerified': true,
        'skills': ['Lawn Care', 'Planting', 'Landscaping'],
      },
    ];
  }

  // Mock ongoing jobs
  static List<Map<String, dynamic>> get ongoingJobs {
    return [
      {
        'id': '1',
        'serviceName': 'Pipe Repair',
        'providerName': 'Ahmed Khan',
        'date': 'Today, 2:00 PM',
        'status': 'confirmed',
        'price': 800,
      },
      {
        'id': '2',
        'serviceName': 'Dress Alteration',
        'providerName': 'Fatima Ali', 
        'date': 'Tomorrow, 11:00 AM',
        'status': 'pending',
        'price': 450,
      },
    ];
  }

  // Mock user bookings
  static List<Map<String, dynamic>> get userBookings {
    return [
      {
        'id': 'b1',
        'service': 'Pipe Repair',
        'providerName': 'Ahmed Khan',
        'date': '2025-11-12 14:00',
        'status': 'confirmed',
        'price': 800,
      },
      {
        'id': 'b2',
        'service': 'Dress Alteration',
        'providerName': 'Fatima Ali',
        'date': '2025-11-15 11:00',
        'status': 'pending',
        'price': 450,
      },
    ];
  }

  // Mock user favorites (list of provider ids)
  static List<String> get userFavorites {
    return ['1', '2', '6'];
  }

  // Helper: get provider by id
  static Map<String, dynamic>? getProviderById(String id) {
    try {
      return serviceProviders.firstWhere((p) => p['id'] == id);
    } catch (_) {
      return null;
    }
  }

  // Simple mock login to demonstrate user/provider flows
  static Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    isLoggedIn = true;
    // For demo, if email contains 'provider', set as provider
    currentUserType = email.toLowerCase().contains('provider') ? 'provider' : 'seeker';
    return true;
  }

  // Helper method to get providers by category
  static List<Map<String, dynamic>> getProvidersByCategory(String category) {
    return serviceProviders.where((provider) {
      return provider['profession']?.toLowerCase().contains(category.toLowerCase()) ?? false;
    }).toList();
  }
}