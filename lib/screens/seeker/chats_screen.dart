import 'package:flutter/material.dart';
import 'package:service_sphere/utils/colors.dart';
import 'package:service_sphere/widgets/bottom_nav_bar.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Chats'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
      ),
      body: _buildChatsList(),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildChatsList() {
    final chats = [
      {
        'id': '1',
        'providerName': 'Ahmed Khan',
        'providerProfession': 'Plumber',
        'lastMessage': 'I can come tomorrow at 2 PM',
        'timestamp': '10:30 AM',
        'unreadCount': 2,
        'isOnline': true,
      },
      {
        'id': '2',
        'providerName': 'Fatima Ali',
        'providerProfession': 'Tailor',
        'lastMessage': 'The dress will be ready by Friday',
        'timestamp': 'Yesterday',
        'unreadCount': 0,
        'isOnline': false,
      },
      {
        'id': '3',
        'providerName': 'Usman Ahmed',
        'providerProfession': 'Electrician',
        'lastMessage': 'What type of switch do you need?',
        'timestamp': '12/15/2023',
        'unreadCount': 1,
        'isOnline': true,
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return _buildChatItem(chat, context);
      },
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat, BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Stack(
          children: [
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
            if (chat['isOnline'] == true)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Text(
              chat['providerName'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
            ),
            SizedBox(width: 8),
            if (chat['unreadCount'] > 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  chat['unreadCount'].toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              chat['providerProfession'],
              style: TextStyle(
                fontSize: 12,
                color: AppColors.secondary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              chat['lastMessage'],
              style: TextStyle(
                fontSize: 14,
                color: AppColors.onBackground,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat['timestamp'],
              style: TextStyle(
                fontSize: 12,
                color: AppColors.hint,
              ),
            ),
            if (chat['unreadCount'] > 0)
              Icon(
                Icons.mark_chat_unread,
                color: AppColors.primary,
                size: 16,
              ),
          ],
        ),
        onTap: () {
          _showChatDialog(context, chat);
        },
      ),
    );
  }

  void _showChatDialog(BuildContext context, Map<String, dynamic> chat) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Chat with ${chat['providerName']}',
          style: TextStyle(
            color: AppColors.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Real-time chat functionality will be implemented with backend integration.\n\n'
          'You will be able to:\n'
          '• Send messages in real-time\n'
          '• Share photos and location\n'
          '• Discuss service details\n'
          '• Negotiate pricing',
          style: TextStyle(color: AppColors.onBackground),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}