import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  final Function(String)? onSearchChanged;
  final Function(String)? onSearchSubmitted;
  final VoidCallback? onVoiceSearch;
  final bool showVoiceSearch;

  const SearchBar({
    super.key,
    this.hintText = 'Search for workout first aid tips',
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onVoiceSearch,
    this.showVoiceSearch = false,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.textHint.withAlpha(26), // Light gray background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: widget.onSearchChanged,
        onSubmitted: widget.onSearchSubmitted,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AppTheme.textHint,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppTheme.textSecondary,
            size: 20,
          ),
          suffixIcon: widget.showVoiceSearch
              ? IconButton(
                  icon: const Icon(
                    Icons.mic,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                  onPressed: widget.onVoiceSearch,
                )
              : _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                      onPressed: _clearSearch,
                    )
                  : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        style: const TextStyle(
          fontSize: 14,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
    });
    widget.onSearchChanged?.call('');
  }
}
