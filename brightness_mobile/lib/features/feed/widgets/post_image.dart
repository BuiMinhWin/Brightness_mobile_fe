import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  final List<String> imageUrls;
  final VoidCallback? onImageTap;

  const PostImage({
    super.key,
    required this.imageUrls,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: onImageTap,
        child: _buildImageLayout(),
      ),
    );
  }

  Widget _buildImageLayout() {
    if (imageUrls.length == 1) {
      return _buildSingleImage(imageUrls[0]);
    } else if (imageUrls.length == 2) {
      return _buildTwoImages();
    } else if (imageUrls.length >= 3) {
      return _buildMultipleImages();
    }
    return const SizedBox.shrink();
  }

  Widget _buildSingleImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            color: const Color(0xFFF3F4F6),
            child: const Center(
              child: Icon(
                Icons.image_not_supported,
                color: Color(0xFF9CA3AF),
                size: 48,
              ),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 200,
            color: const Color(0xFFF3F4F6),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4CAF50),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTwoImages() {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              imageUrls[0],
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
            ),
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Image.network(
              imageUrls[1],
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultipleImages() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                ),
                child: Image.network(
                  imageUrls[0],
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _buildErrorWidget(height: 100),
                ),
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  imageUrls[1],
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _buildErrorWidget(height: 100),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: Stack(
            children: [
              Image.network(
                imageUrls[2],
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildErrorWidget(height: 100),
              ),
              if (imageUrls.length > 3)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '+${imageUrls.length - 3}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildErrorWidget({double height = 200}) {
    return Container(
      height: height,
      color: const Color(0xFFF3F4F6),
      child: const Center(
        child: Icon(
          Icons.image_not_supported,
          color: Color(0xFF9CA3AF),
          size: 48,
        ),
      ),
    );
  }
}
