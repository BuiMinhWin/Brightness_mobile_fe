import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSendMessage;
  final VoidCallback? onAttachment;
  final VoidCallback? onCalendar;
  final VoidCallback? onVoiceInput;

  const ChatInput({
    super.key,
    required this.controller,
    required this.onSendMessage,
    this.onAttachment,
    this.onCalendar,
    this.onVoiceInput,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = widget.controller.text.trim().isNotEmpty;
    });
  }

  void _handleSend() {
    final text = widget.controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Attachment Button
            GestureDetector(
              onTap: widget.onAttachment,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.attach_file,
                  color: Color(0xFF6B7280),
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Text Input
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
                child: TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    hintText: 'Type message...',
                    hintStyle: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  onSubmitted: _hasText ? (_) => _handleSend() : null,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Calendar Button
            GestureDetector(
              onTap: widget.onCalendar,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF6B7280),
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Voice/Send Button
            GestureDetector(
              onTap: _hasText ? _handleSend : widget.onVoiceInput,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _hasText ? const Color(0xFF4CAF50) : const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  _hasText ? Icons.send : Icons.mic,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
