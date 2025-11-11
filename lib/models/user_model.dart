import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String fullName;
  final String phone;
  final String userType; // 'seeker' or 'provider'
  final String? cnic;
  final DateTime createdAt;
  final bool isVerified;
  final double rating;
  final int totalJobs;

  AppUser({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.userType,
    this.cnic,
    required this.createdAt,
    required this.isVerified,
    required this.rating,
    required this.totalJobs,
  });

  // Convert Firestore document to AppUser object
  factory AppUser.fromFirestore(Map<String, dynamic> data, String uid) {
    return AppUser(
      uid: uid,
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      phone: data['phone'] ?? '',
      userType: data['userType'] ?? 'seeker',
      cnic: data['cnic'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      isVerified: data['isVerified'] ?? false,
      rating: (data['rating'] ?? 0.0).toDouble(),
      totalJobs: data['totalJobs'] ?? 0,
    );
  }

  // Check if user is service provider
  bool get isProvider => userType == 'provider';

  // Check if user is service seeker
  bool get isSeeker => userType == 'seeker';
}