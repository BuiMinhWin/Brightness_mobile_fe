import 'package:flutter/material.dart';
import 'chat_message.dart';
import 'ai_avatar.dart';

class ChatConversation extends StatelessWidget {
  final List<Map<String, dynamic>> messages;
  final bool isTyping;
  final ScrollController scrollController;

  const ChatConversation({
    super.key,
    required this.messages,
    required this.isTyping,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: messages.length + (isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == messages.length && isTyping) {
          return _buildTypingIndicator();
        }

        final message = messages[index];
        return ChatMessage(
          text: message['text'],
          isAI: message['isAI'],
          timestamp: message['timestamp'],
          showAvatar: _shouldShowAvatar(index),
        );
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          const AiAvatar(size: 32),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        final delay = index * 0.2;
        final animationValue = (value - delay).clamp(0.0, 1.0);
        final opacity = (animationValue * 2 - 1).abs();
        
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFF6B7280).withOpacity(opacity),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  bool _shouldShowAvatar(int index) {
    if (index == 0) return true;
    
    final currentMessage = messages[index];
    final previousMessage = messages[index - 1];
    
    // Show avatar if it's a different sender or if it's been more than 5 minutes
    if (currentMessage['isAI'] != previousMessage['isAI']) return true;
    
    final currentTime = currentMessage['timestamp'] as DateTime;
    final previousTime = previousMessage['timestamp'] as DateTime;
    final timeDifference = currentTime.difference(previousTime);
    
    return timeDifference.inMinutes > 5;
  }
}
