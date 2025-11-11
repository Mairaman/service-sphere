import 'package:flutter/material.dart';
import 'package:service_sphere/utils/colors.dart';
import 'package:service_sphere/widgets/bottom_nav_bar.dart';

class ChatDetailScreen extends StatefulWidget {
  final Map<String, dynamic> provider;

  const ChatDetailScreen({Key? key, required this.provider}) : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late TextEditingController _messageController;
  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'provider',
      'message': 'Hi! I\'m interested in helping you with your project.',
      'timestamp': '10:30 AM',
      'isOnline': true,
    },
    {
      'sender': 'user',
      'message': 'Great! Can you tell me about your experience?',
      'timestamp': '10:32 AM',
      'isOnline': false,
    },
    {
      'sender': 'provider',
      'message': 'I have over 5 years of experience in this field with 200+ completed projects.',
      'timestamp': '10:35 AM',
      'isOnline': true,
    },
    {
      'sender': 'user',
      'message': 'That sounds perfect! When can you start?',
      'timestamp': '10:37 AM',
      'isOnline': false,
    },
    {
      'sender': 'provider',
      'message': 'I\'m available tomorrow morning. Does 9 AM work for you?',
      'timestamp': '10:40 AM',
      'isOnline': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.person, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(provider['name'], style: const TextStyle(fontSize: 16)),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message['sender'] == 'user';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: isUserMessage
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isUserMessage
                              ? AppColors.primary
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: isUserMessage
                              ? null
                              : Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          message['message'],
                          style: TextStyle(
                            color: isUserMessage
                                ? AppColors.onPrimary
                                : AppColors.onBackground,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message['timestamp'],
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Message Input Field
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: AppColors.hint),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      setState(() {
                        _messages.add({
                          'sender': 'user',
                          'message': _messageController.text,
                          'timestamp': 'Now',
                          'isOnline': false,
                        });
                        _messageController.clear();
                      });
                    }
                  },
                  backgroundColor: AppColors.primary,
                  mini: true,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
    );
  }
}
