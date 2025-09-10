import 'package:flutter/material.dart';

class MediaUploadSection extends StatelessWidget {
  final List<String> selectedMedia;
  final Function(List<String>) onMediaSelected;

  const MediaUploadSection({
    super.key,
    required this.selectedMedia,
    required this.onMediaSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Media',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        if (selectedMedia.isEmpty) _buildUploadArea() else _buildMediaPreview(),
      ],
    );
  }

  Widget _buildUploadArea() {
    return GestureDetector(
      onTap: () {
        _showMediaOptions();
      },
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFD1D5DB),
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF9FAFB),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Add photos or videos',
              style: TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Share your workout clips or progress photos',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaPreview() {
    return Column(
      children: [
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: selectedMedia.length + 1,
            itemBuilder: (context, index) {
              if (index == selectedMedia.length) {
                return _buildAddMoreButton();
              }
              return _buildMediaThumbnail(selectedMedia[index], index);
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            TextButton.icon(
              onPressed: () {
                _showMediaOptions();
              },
              icon: const Icon(
                Icons.add_photo_alternate,
                color: Color(0xFF4CAF50),
                size: 20,
              ),
              label: const Text(
                'Add More',
                style: TextStyle(
                  color: Color(0xFF4CAF50),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                onMediaSelected([]);
              },
              child: const Text(
                'Remove All',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMediaThumbnail(String mediaPath, int index) {
    return Container(
      width: 120,
      height: 120,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF3F4F6),
      ),
      child: Stack(
        children: [
          // Placeholder for media
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF4CAF50).withOpacity(0.3),
                  const Color(0xFF2196F3).withOpacity(0.3),
                ],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.image,
                color: Color(0xFF6B7280),
                size: 32,
              ),
            ),
          ),
          // Remove button
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                final newMedia = List<String>.from(selectedMedia);
                newMedia.removeAt(index);
                onMediaSelected(newMedia);
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMoreButton() {
    return GestureDetector(
      onTap: () {
        _showMediaOptions();
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFD1D5DB),
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF9FAFB),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Color(0xFF6B7280),
            size: 32,
          ),
        ),
      ),
    );
  }

  void _showMediaOptions() {
    // TODO: Implement media selection from gallery or camera
    // For now, add sample media
    final newMedia = List<String>.from(selectedMedia);
    newMedia.add('sample_media_${newMedia.length + 1}');
    onMediaSelected(newMedia);
  }
}
