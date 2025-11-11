import 'package:flutter/material.dart';
import 'package:service_sphere/utils/colors.dart';

class JobManagementScreen extends StatefulWidget {
  const JobManagementScreen({Key? key}) : super(key: key);

  @override
  _JobManagementScreenState createState() => _JobManagementScreenState();
}

class _JobManagementScreenState extends State<JobManagementScreen> {
  int _selectedTab = 0; // 0: Pending, 1: Accepted, 2: Completed, 3: All

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Job Management'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tab Bar
          _buildTabBar(),
          // Job List
          Expanded(
            child: _buildJobList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildTab('Pending', 0, Icons.pending_actions),
            _buildTab('Accepted', 1, Icons.check_circle),
            _buildTab('Completed', 2, Icons.done_all),
            _buildTab('All Jobs', 3, Icons.list),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index, IconData icon) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppColors.primary : AppColors.secondary,
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.secondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobList() {
    final jobs = _getFilteredJobs();
    
    if (jobs.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return _buildJobCard(job, context);
      },
    );
  }

  Widget _buildEmptyState() {
    String message = '';
    String icon = '📋';
    
    switch (_selectedTab) {
      case 0:
        message = 'No pending job requests';
        icon = '⏳';
        break;
      case 1:
        message = 'No accepted jobs';
        icon = '✅';
        break;
      case 2:
        message = 'No completed jobs';
        icon = '🎉';
        break;
      case 3:
        message = 'No jobs yet';
        icon = '📝';
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            icon,
            style: TextStyle(fontSize: 64),
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.onBackground,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'New job requests will appear here',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job, BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job['service'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onBackground,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${job['customerName']} • ${job['customerPhone']}',
                        style: TextStyle(
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(job['status']),
              ],
            ),
            
            SizedBox(height: 12),
            
            // Job Details
            _buildDetailRow(Icons.calendar_today, '${job['date']} at ${job['time']}'),
            SizedBox(height: 8),
            _buildDetailRow(Icons.access_time, '${job['duration']} hours'),
            SizedBox(height: 8),
            _buildDetailRow(Icons.attach_money, 'Rs ${job['price']}'),
            
            if (job['description'].isNotEmpty) ...[
              SizedBox(height: 8),
              _buildDetailRow(Icons.description, job['description']),
            ],
            
            SizedBox(height: 12),
            
            // Action Buttons
            _buildActionButtons(job, context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.secondary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.onBackground,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        displayText = 'Pending';
        break;
      case 'accepted':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        displayText = 'Accepted';
        break;
      case 'completed':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        displayText = 'Completed';
        break;
      case 'declined':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        displayText = 'Declined';
        break;
      default:
        backgroundColor = AppColors.secondary;
        textColor = AppColors.onPrimary;
        displayText = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> job, BuildContext context) {
    final status = job['status'].toLowerCase();

    switch (status) {
      case 'pending':
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _declineJob(job, context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Decline'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _acceptJob(job, context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Accept'),
              ),
            ),
          ],
        );
      
      case 'accepted':
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _viewJobDetails(job, context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('View Details'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _markAsCompleted(job, context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Complete'),
              ),
            ),
          ],
        );
      
      case 'completed':
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _viewJobDetails(job, context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('View Details'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _contactCustomer(job, context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Message'),
              ),
            ),
          ],
        );
      
      default:
        return SizedBox.shrink();
    }
  }

  // Job Actions
  void _acceptJob(Map<String, dynamic> job, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Accept Job'),
        content: Text('Are you sure you want to accept this job?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                job['status'] = 'accepted';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Job accepted successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Accept'),
          ),
        ],
      ),
    );
  }

  void _declineJob(Map<String, dynamic> job, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Decline Job'),
        content: Text('Are you sure you want to decline this job?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                job['status'] = 'declined';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Job declined'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Decline'),
          ),
        ],
      ),
    );
  }

  void _markAsCompleted(Map<String, dynamic> job, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Mark as Completed'),
        content: Text('Mark this job as completed?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                job['status'] = 'completed';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Job marked as completed!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Complete'),
          ),
        ],
      ),
    );
  }

  void _viewJobDetails(Map<String, dynamic> job, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Job Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailItem('Service', job['service']),
              _buildDetailItem('Customer', job['customerName']),
              _buildDetailItem('Phone', job['customerPhone']),
              _buildDetailItem('Date & Time', '${job['date']} at ${job['time']}'),
              _buildDetailItem('Duration', '${job['duration']} hours'),
              _buildDetailItem('Price', 'Rs ${job['price']}'),
              if (job['description'].isNotEmpty)
                _buildDetailItem('Description', job['description']),
              _buildDetailItem('Status', job['status']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _contactCustomer(Map<String, dynamic> job, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening chat with ${job['customerName']}'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  // Data Methods
  List<Map<String, dynamic>> _getFilteredJobs() {
    final allJobs = _getMockJobs();
    
    switch (_selectedTab) {
      case 0: // Pending
        return allJobs.where((job) => job['status'].toLowerCase() == 'pending').toList();
      case 1: // Accepted
        return allJobs.where((job) => job['status'].toLowerCase() == 'accepted').toList();
      case 2: // Completed
        return allJobs.where((job) => job['status'].toLowerCase() == 'completed').toList();
      case 3: // All
        return allJobs;
      default:
        return allJobs;
    }
  }

  List<Map<String, dynamic>> _getMockJobs() {
    return [
      {
        'id': '1',
        'service': 'Pipe Repair',
        'customerName': 'Ali Ahmed',
        'customerPhone': '+923001234567',
        'date': '2024-01-20',
        'time': '10:00 AM',
        'duration': 2,
        'price': 1000,
        'description': 'Kitchen sink pipe is leaking',
        'status': 'pending',
      },
      {
        'id': '2',
        'service': 'Tap Installation',
        'customerName': 'Fatima Khan',
        'customerPhone': '+923001234568',
        'date': '2024-01-19',
        'time': '2:00 PM',
        'duration': 1,
        'price': 500,
        'description': 'Need new tap installed in bathroom',
        'status': 'accepted',
      },
      {
        'id': '3',
        'service': 'Drain Cleaning',
        'customerName': 'Usman Raza',
        'customerPhone': '+923001234569',
        'date': '2024-01-18',
        'time': '11:00 AM',
        'duration': 3,
        'price': 1500,
        'description': 'Main drain pipe is clogged',
        'status': 'completed',
      },
      {
        'id': '4',
        'service': 'Water Heater Repair',
        'customerName': 'Sara Javed',
        'customerPhone': '+923001234570',
        'date': '2024-01-22',
        'time': '3:00 PM',
        'duration': 2,
        'price': 1200,
        'description': 'Water heater not working properly',
        'status': 'pending',
      },
    ];
  }
}