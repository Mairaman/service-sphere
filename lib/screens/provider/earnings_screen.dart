import 'package:flutter/material.dart';
import 'package:service_sphere/utils/colors.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  String _selectedTimeFrame = 'This Week'; // This Week, This Month, All Time
  List<Map<String, dynamic>> _paymentHistory = [];

  @override
  void initState() {
    super.initState();
    _loadPaymentHistory();
  }

  void _loadPaymentHistory() {
    // Mock payment data - in real app, this would come from API
    setState(() {
      _paymentHistory = [
        {
          'id': '1',
          'customerName': 'Ali Ahmed',
          'service': 'Pipe Repair',
          'date': '2024-01-15',
          'amount': 1000,
          'status': 'completed',
          'paymentMethod': 'cash',
          'jobDuration': '2 hours',
        },
        {
          'id': '2',
          'customerName': 'Fatima Khan',
          'service': 'Tap Installation',
          'date': '2024-01-14',
          'amount': 500,
          'status': 'completed',
          'paymentMethod': 'cash',
          'jobDuration': '1 hour',
        },
        {
          'id': '3',
          'customerName': 'Usman Raza',
          'service': 'Drain Cleaning',
          'date': '2024-01-13',
          'amount': 1500,
          'status': 'pending',
          'paymentMethod': 'cash',
          'jobDuration': '3 hours',
        },
        {
          'id': '4',
          'customerName': 'Sara Javed',
          'service': 'Water Heater Repair',
          'date': '2024-01-12',
          'amount': 1200,
          'status': 'completed',
          'paymentMethod': 'cash',
          'jobDuration': '2 hours',
        },
        {
          'id': '5',
          'customerName': 'Bilal Mahmood',
          'service': 'Pipe Replacement',
          'date': '2024-01-11',
          'amount': 800,
          'status': 'completed',
          'paymentMethod': 'cash',
          'jobDuration': '1.5 hours',
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final earningsData = _calculateEarnings();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Earnings & Payments'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedTimeFrame = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'This Week', child: Text('This Week')),
              PopupMenuItem(value: 'This Month', child: Text('This Month')),
              PopupMenuItem(value: 'All Time', child: Text('All Time')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Earnings Overview Cards
            _buildEarningsOverview(earningsData),
            SizedBox(height: 24),
            
            // Payment History
            _buildPaymentHistory(),
            SizedBox(height: 24),
            
            // Quick Stats
            _buildQuickStats(earningsData),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsOverview(Map<String, dynamic> earningsData) {
    return Column(
      children: [
        // Total Earnings Card
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryVariant],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  'Total Earnings',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.onPrimary.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Rs ${earningsData['totalEarnings']}',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${earningsData['completedJobs']} Completed Jobs',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.onPrimary.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        
        // Weekly/Monthly Earnings
        Row(
          children: [
            Expanded(
              child: _buildEarningStatCard(
                'This ${_selectedTimeFrame.contains('Week') ? 'Week' : 'Month'}',
                'Rs ${earningsData['periodEarnings']}',
                Icons.calendar_today,
                Colors.blue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildEarningStatCard(
                'Pending Payments',
                'Rs ${earningsData['pendingEarnings']}',
                Icons.pending_actions,
                Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEarningStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
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

  Widget _buildPaymentHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Payment History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            Text(
              '${_paymentHistory.length} Transactions',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        
        if (_paymentHistory.isEmpty)
          _buildEmptyPaymentHistory()
        else
          ..._paymentHistory.map((payment) => _buildPaymentItem(payment)).toList(),
      ],
    );
  }

  Widget _buildEmptyPaymentHistory() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(Icons.receipt_long, size: 64, color: AppColors.secondary),
            SizedBox(height: 16),
            Text(
              'No Payments Yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your payment history will appear here after completing jobs',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentItem(Map<String, dynamic> payment) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getPaymentStatusColor(payment['status']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            Icons.attach_money,
            color: _getPaymentStatusColor(payment['status']),
          ),
        ),
        title: Text(
          payment['customerName'],
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.onBackground,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(payment['service']),
            SizedBox(height: 4),
            Text(
              '${payment['date']} • ${payment['jobDuration']}',
              style: TextStyle(fontSize: 12, color: AppColors.secondary),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Rs ${payment['amount']}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _getPaymentStatusColor(payment['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                payment['status'].toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: _getPaymentStatusColor(payment['status']),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          _showPaymentDetails(payment);
        },
      ),
    );
  }

  Widget _buildQuickStats(Map<String, dynamic> earningsData) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Stats',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem('Avg. per Job', 'Rs ${earningsData['averagePerJob']}'),
                ),
                Container(width: 1, height: 40, color: AppColors.border),
                Expanded(
                  child: _buildStatItem('Jobs Completed', earningsData['completedJobs'].toString()),
                ),
                Container(width: 1, height: 40, color: AppColors.border),
                Expanded(
                  child: _buildStatItem('Pending', earningsData['pendingJobs'].toString()),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Method',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onBackground,
                  ),
                ),
                Chip(
                  label: Text('CASH PAYMENTS'),
                  backgroundColor: AppColors.primaryVariant,
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'All payments are collected in cash after service completion. '
              'Keep track of your earnings using this dashboard.',
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

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }

  Color _getPaymentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return AppColors.primary;
    }
  }

  void _showPaymentDetails(Map<String, dynamic> payment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Payment Details',
          style: TextStyle(
            color: AppColors.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Customer', payment['customerName']),
              _buildDetailRow('Service', payment['service']),
              _buildDetailRow('Date', payment['date']),
              _buildDetailRow('Time Spent', payment['jobDuration']),
              _buildDetailRow('Amount', 'Rs ${payment['amount']}'),
              _buildDetailRow('Payment Method', 'Cash'),
              _buildDetailRow('Status', payment['status'].toString().toUpperCase()),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: AppColors.secondary),
            ),
          ),
          if (payment['status'] == 'pending')
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _markAsReceived(payment);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: Text(
                'Mark as Received',
                style: TextStyle(color: AppColors.onPrimary),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.onBackground),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(value, style: TextStyle(color: AppColors.onBackground))),
        ],
      ),
    );
  }

  void _markAsReceived(Map<String, dynamic> payment) {
    setState(() {
      payment['status'] = 'completed';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment marked as received!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Calculate earnings data based on selected time frame
  Map<String, dynamic> _calculateEarnings() {
    int totalEarnings = 0;
    int periodEarnings = 0;
    int pendingEarnings = 0;
    int completedJobs = 0;
    int pendingJobs = 0;

    for (var payment in _paymentHistory) {
      totalEarnings += payment['amount'] as int;
      
      if (payment['status'] == 'completed') {
        completedJobs++;
        periodEarnings += payment['amount'] as int;
      } else if (payment['status'] == 'pending') {
        pendingJobs++;
        pendingEarnings += payment['amount'] as int;
      }
    }

    // For demo, we're using all payments as period earnings
    // In real app, you'd filter by date based on _selectedTimeFrame
    periodEarnings = totalEarnings - pendingEarnings;

    return {
      'totalEarnings': totalEarnings,
      'periodEarnings': periodEarnings,
      'pendingEarnings': pendingEarnings,
      'completedJobs': completedJobs,
      'pendingJobs': pendingJobs,
      'averagePerJob': completedJobs > 0 ? (periodEarnings ~/ completedJobs) : 0,
    };
  }
}