import 'package:flutter/material.dart';

class VisibilitySettings extends StatelessWidget {
  final bool isPublic;
  final Function(bool) onVisibilityChanged;

  const VisibilitySettings({
    super.key,
    required this.isPublic,
    required this.onVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Globe icon on the left
        Icon(Icons.language, color: const Color(0xFF6B7280), size: 24),
        const SizedBox(width: 12),

        // Text content in the center
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Visibility',
                style: TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Who can see this post?',
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
              ),
            ],
          ),
        ),

        // Toggle button on the right
        Container(
          width: 120,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: const Color(0xFFE5E7EB),
          ),
          child: Stack(
            children: [
              // Background text labels
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Private',
                        style: TextStyle(
                          color: !isPublic
                              ? Colors.white
                              : const Color(0xFF9CA3AF),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Public',
                        style: TextStyle(
                          color: isPublic
                              ? Colors.white
                              : const Color(0xFF9CA3AF),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Sliding active section
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: isPublic
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => onVisibilityChanged(!isPublic),
                  child: Container(
                    width: 60,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: isPublic
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFF6B7280),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isPublic ? Icons.public : Icons.lock,
                          size: 12,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            isPublic ? 'Public' : 'Private',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
