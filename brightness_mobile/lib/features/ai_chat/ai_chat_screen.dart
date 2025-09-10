import 'package:flutter/material.dart';
import 'ai_chat/widgets/ai_header.dart';
import 'ai_chat/widgets/workout_summary_card.dart';
import 'ai_chat/widgets/chat_conversation.dart';
import 'ai_chat/widgets/chat_input.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _loadInitialMessages() {
    // Load initial conversation
    setState(() {
      _messages.addAll([
        {
          'id': '1',
          'text': 'Hello! I\'m your Personal AI trainer. I can see you\'re currently on an outdoor cycling session. How are you feeling?',
          'isAI': true,
          'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
        },
        {
          'id': '2',
          'text': 'Great! I\'m feeling strong today. The weather is perfect for cycling.',
          'isAI': false,
          'timestamp': DateTime.now().subtract(const Duration(minutes: 4)),
        },
        {
          'id': '3',
          'text': 'That\'s wonderful! I can see your heart rate is in the optimal zone. Keep maintaining that steady pace. You\'re doing great!',
          'isAI': true,
          'timestamp': DateTime.now().subtract(const Duration(minutes: 3)),
        },
      ]);
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'text': text,
        'isAI': false,
        'timestamp': DateTime.now(),
      });
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    _simulateAIResponse();
  }

  void _simulateAIResponse() {
    setState(() {
      _isTyping = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'text': _getAIResponse(),
            'isAI': true,
            'timestamp': DateTime.now(),
          });
        });
        _scrollToBottom();
      }
    });
  }

  String _getAIResponse() {
    final responses = [
      'Excellent work! Your form is looking great. Keep it up!',
      'I notice your pace has increased. How are you feeling?',
      'Great job maintaining that heart rate zone!',
      'You\'re doing fantastic! Remember to stay hydrated.',
      'Your cycling technique is improving with each session!',
      'I can see you\'re pushing yourself. Listen to your body!',
    ];
    return responses[DateTime.now().millisecond % responses.length];
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleAttachment() {
    // TODO: Implement attachment functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Attachment feature coming soon!'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _handleCalendar() {
    // TODO: Implement calendar functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Calendar integration coming soon!'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _handleVoiceInput() {
    // TODO: Implement voice input functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Voice input feature coming soon!'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AiHeader(),
      body: Column(
        children: [
          const WorkoutSummaryCard(),
          Expanded(
            child: ChatConversation(
              messages: _messages,
              isTyping: _isTyping,
              scrollController: _scrollController,
            ),
          ),
          ChatInput(
            controller: _messageController,
            onSendMessage: _sendMessage,
            onAttachment: _handleAttachment,
            onCalendar: _handleCalendar,
            onVoiceInput: _handleVoiceInput,
          ),
        ],
      ),
    );
  }
}
