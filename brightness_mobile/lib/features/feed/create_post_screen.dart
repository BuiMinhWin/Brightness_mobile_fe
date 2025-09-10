import 'package:flutter/material.dart';
import 'create_post/widgets/create_post_header.dart';
import 'create_post/widgets/post_title_input.dart';
import 'create_post/widgets/media_upload_section.dart';
import 'create_post/widgets/rich_text_editor.dart';
import 'create_post/widgets/formatting_toolbar.dart';
import 'create_post/widgets/tag_selector.dart';
import 'create_post/widgets/visibility_settings.dart';
import 'create_post/widgets/action_buttons.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<String> _selectedMedia = [];
  List<String> _selectedTags = [];
  bool _isPublic = true;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isBulletList = false;
  bool _isNumberedList = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleMediaSelected(List<String> media) {
    setState(() {
      _selectedMedia = media;
    });
  }

  void _handleTagsChanged(List<String> tags) {
    setState(() {
      _selectedTags = tags;
    });
  }

  void _handleVisibilityChanged(bool isPublic) {
    setState(() {
      _isPublic = isPublic;
    });
  }

  void _handleFormattingChanged({
    bool? bold,
    bool? italic,
    bool? bulletList,
    bool? numberedList,
  }) {
    setState(() {
      if (bold != null) _isBold = bold;
      if (italic != null) _isItalic = italic;
      if (bulletList != null) _isBulletList = bulletList;
      if (numberedList != null) _isNumberedList = numberedList;
    });
  }

  void _handleSaveDraft() {
    // TODO: Implement save draft functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Draft saved successfully'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _handlePublish() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a title'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some content'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: Implement publish functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post published successfully!'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CreatePostHeader(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostTitleInput(
                    controller: _titleController,
                  ),
                  const SizedBox(height: 24),
                  MediaUploadSection(
                    selectedMedia: _selectedMedia,
                    onMediaSelected: _handleMediaSelected,
                  ),
                  const SizedBox(height: 24),
                  RichTextEditor(
                    controller: _contentController,
                    isBold: _isBold,
                    isItalic: _isItalic,
                    isBulletList: _isBulletList,
                    isNumberedList: _isNumberedList,
                  ),
                  const SizedBox(height: 16),
                  FormattingToolbar(
                    isBold: _isBold,
                    isItalic: _isItalic,
                    isBulletList: _isBulletList,
                    isNumberedList: _isNumberedList,
                    onFormattingChanged: _handleFormattingChanged,
                  ),
                  const SizedBox(height: 24),
                  TagSelector(
                    selectedTags: _selectedTags,
                    onTagsChanged: _handleTagsChanged,
                  ),
                  const SizedBox(height: 24),
                  VisibilitySettings(
                    isPublic: _isPublic,
                    onVisibilityChanged: _handleVisibilityChanged,
                  ),
                  const SizedBox(height: 100), // Space for action buttons
                ],
              ),
            ),
          ),
          ActionButtons(
            onSaveDraft: _handleSaveDraft,
            onPublish: _handlePublish,
          ),
        ],
      ),
    );
  }
}
