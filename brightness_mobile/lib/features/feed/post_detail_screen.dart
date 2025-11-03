import 'package:flutter/material.dart';
import '../../../shared/services/social_feed_data_service.dart';
import 'post_detail/widgets/post_detail_header.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;
  final SocialPost? postData;

  const PostDetailScreen({super.key, required this.postId, this.postData});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;
  SocialPost? _post;
  List<SocialPost> _morePosts = [];

  @override
  void initState() {
    super.initState();
    // Initialize with passed data or load from API
    _initializePostData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _initializePostData() {
    print('PostDetailScreen initialized with postId: ${widget.postId}');
    print('PostData: ${widget.postData}');

    if (widget.postData != null) {
      // Use passed data
      _post = widget.postData;
      print('Using passed post data');
    } else {
      // Load from service using postId
      print('Loading post data from service');
      _loadPostData();
    }
  }

  Future<void> _loadPostData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Load post from service
      _post = await SocialFeedDataService.getPostById(widget.postId);

      if (_post == null) {
        throw Exception('Post not found');
      }

      // Load more posts from the same user
      _morePosts = await _getMorePostsFromUser();
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load post: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleFollow() async {
    if (_post == null) return;

    try {
      final success = await SocialFeedDataService.toggleFollow(_post!.userId);

      if (success && mounted) {
        setState(() {
          _post = _post!.copyWith(isFollowing: !_post!.isFollowing);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _post!.isFollowing ? 'Following user' : 'Unfollowed user',
            ),
            backgroundColor: const Color(0xFF4CAF50),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to follow user: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleLike() async {
    if (_post == null) return;

    try {
      final updatedPost = await SocialFeedDataService.toggleLike(_post!.id);

      if (updatedPost != null && mounted) {
        setState(() {
          _post = updatedPost;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to like post: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleBookmark() async {
    if (_post == null) return;

    try {
      final updatedPost = await SocialFeedDataService.toggleBookmark(_post!.id);

      if (updatedPost != null && mounted) {
        setState(() {
          _post = updatedPost;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _post!.isBookmarked
                  ? 'Post bookmarked'
                  : 'Post removed from bookmarks',
            ),
            backgroundColor: const Color(0xFF4CAF50),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to bookmark post: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleComment() async {
    final comment = _commentController.text.trim();
    if (comment.isEmpty || _post == null) return;

    try {
      // TODO: Replace with actual API call
      // await CommentService.postComment(widget.postId, comment);

      _commentController.clear();
      setState(() {
        _post = _post!.copyWith(comments: _post!.comments + 1);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comment posted successfully'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to post comment: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PostDetailHeader(),
        body: const Center(
          child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
        ),
      );
    }

    if (_post == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PostDetailHeader(),
        body: const Center(
          child: Text(
            'Post not found',
            style: TextStyle(fontSize: 18, color: Color(0xFF6B7280)),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PostDetailHeader(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author Info Section
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey[300],
                    child: _post!.userAvatar != null
                        ? ClipOval(
                            child: Image.network(
                              _post!.userAvatar!,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 28,
                                );
                              },
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 28,
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _post!.username,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        Text(
                          'Marathon Runner',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _handleFollow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _post!.isFollowing
                          ? Colors.grey[300]
                          : const Color(0xFF4CAF50),
                      foregroundColor: _post!.isFollowing
                          ? Colors.black
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      minimumSize: const Size(0, 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _post!.isFollowing ? 'Following' : 'Follow',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Post Title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _post!.content.split('\n').first, // Use first line as title
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _post!.timestamp,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),

            // Post Content
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    _post!.content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1F2937),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Post Media
            if (_post!.imageUrls.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildImageGrid(_post!.imageUrls),
              ),
            ],
            // Hashtags
            if (_post!.tags.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  children: _post!.tags
                      .map(
                        (tag) => _buildHashtagChip('#$tag', _getTagColor(tag)),
                      )
                      .toList(),
                ),
              ),
            ],

            // Post Interactions
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInteractionButton(
                    icon: _post!.isLiked
                        ? Icons.favorite
                        : Icons.favorite_border,
                    label: '${_post!.likes}',
                    color: _post!.isLiked ? Colors.red : Colors.grey,
                    onTap: _handleLike,
                  ),
                  _buildInteractionButton(
                    icon: Icons.comment_outlined,
                    label: '${_post!.comments}',
                    color: Colors.grey,
                    onTap: _handleComment,
                  ),
                  _buildInteractionButton(
                    icon: Icons.share_outlined,
                    label: '${_post!.shares}',
                    color: Colors.grey,
                    onTap: () => _handleShare(),
                  ),
                  _buildInteractionButton(
                    icon: _post!.isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    label: '',
                    color: _post!.isBookmarked ? Colors.blue : Colors.grey,
                    onTap: _handleBookmark,
                  ),
                ],
              ),
            ),

            const Divider(),

            // Comments Section
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comments (${_post!.comments})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_post!.commentsList.isNotEmpty) ...[
                    ..._post!.commentsList.map(
                      (comment) => _buildCommentBubble(comment),
                    ),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.comment_outlined,
                            size: 48,
                            color: Color(0xFF6B7280),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'No comments yet',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Be the first to comment!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // More from User Section
            if (_morePosts.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'More from ${_post!.username}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _morePosts.length,
                        itemBuilder: (context, index) {
                          final post = _morePosts[index];
                          return Container(
                            width: 200,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Post Image
                                Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    child: post.imageUrls.isNotEmpty
                                        ? Image.network(
                                            post.imageUrls.first,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    color: Colors.grey[300],
                                                    child: const Icon(
                                                      Icons.image,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                          )
                                        : Container(
                                            color: Colors.grey[300],
                                            child: const Icon(
                                              Icons.image,
                                              color: Colors.grey,
                                            ),
                                          ),
                                  ),
                                ),
                                // Post Content Preview
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post.content.length > 50
                                              ? '${post.content.substring(0, 50)}...'
                                              : post.content,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF374151),
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              size: 12,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${post.likes}',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Icon(
                                              Icons.comment,
                                              size: 12,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${post.comments}',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 100), // Space for comment input
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(51),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  hintText: 'Write a comment...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _handleComment,
              icon: const Icon(Icons.send, color: Color(0xFF4CAF50)),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageGallery(List<String> imageUrls, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              '${initialIndex + 1} of ${imageUrls.length}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: PageView.builder(
            itemCount: imageUrls.length,
            controller: PageController(initialPage: initialIndex),
            itemBuilder: (context, index) {
              return Center(
                child: InteractiveViewer(
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.error, color: Colors.white, size: 64),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleShare() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sharing post...'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  Widget _buildImageGrid(List<String> imageUrls) {
    if (imageUrls.length == 1) {
      return GestureDetector(
        onTap: () => _showImageGallery(imageUrls, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrls[0],
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: const Icon(Icons.error, size: 48, color: Colors.grey),
              );
            },
          ),
        ),
      );
    } else if (imageUrls.length == 2) {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _showImageGallery(imageUrls, 0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Image.network(
                  imageUrls[0],
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.error,
                        size: 48,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: GestureDetector(
              onTap: () => _showImageGallery(imageUrls, 1),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: Image.network(
                  imageUrls[1],
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.error,
                        size: 48,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _showImageGallery(imageUrls, 0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                    ),
                    child: Image.network(
                      imageUrls[0],
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 100,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.error,
                            size: 32,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GestureDetector(
                  onTap: () => _showImageGallery(imageUrls, 1),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                    ),
                    child: Image.network(
                      imageUrls[1],
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 100,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.error,
                            size: 32,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          GestureDetector(
            onTap: () => _showImageGallery(imageUrls, 2),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Stack(
                children: [
                  Image.network(
                    imageUrls[2],
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.error,
                          size: 32,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                  if (imageUrls.length > 3)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(128),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '+${imageUrls.length - 3}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHashtagChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(77)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getTagColor(String tag) {
    // Assign different colors based on tag content
    final tagLower = tag.toLowerCase();
    if (tagLower.contains('running') || tagLower.contains('run')) {
      return const Color(0xFFFF6B35);
    } else if (tagLower.contains('fitness') || tagLower.contains('workout')) {
      return const Color(0xFF4CAF50);
    } else if (tagLower.contains('nutrition') || tagLower.contains('diet')) {
      return const Color(0xFF2196F3);
    } else if (tagLower.contains('yoga') || tagLower.contains('meditation')) {
      return const Color(0xFF9C27B0);
    } else if (tagLower.contains('motivation') ||
        tagLower.contains('inspiration')) {
      return const Color(0xFFFF9800);
    } else {
      return const Color(0xFF6B7280);
    }
  }

  Widget _buildCommentBubble(Comment comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Comment
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[300],
                child: comment.userAvatar != null
                    ? ClipOval(
                        child: Image.network(
                          comment.userAvatar!,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 16,
                            );
                          },
                        ),
                      )
                    : const Icon(Icons.person, color: Colors.grey, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${comment.username} ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F2937),
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: comment.content,
                              style: const TextStyle(
                                color: Color(0xFF374151),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            comment.timestamp,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => _handleCommentLike(comment),
                            child: Text(
                              comment.likes > 0
                                  ? '${comment.likes} like${comment.likes > 1 ? 's' : ''}'
                                  : 'Like',
                              style: TextStyle(
                                fontSize: 12,
                                color: comment.isLiked
                                    ? const Color(0xFF4CAF50)
                                    : Colors.grey[600],
                                fontWeight: comment.isLiked
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => _handleReply(comment),
                            child: Text(
                              'Reply',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Replies
          if (comment.replies.isNotEmpty) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Column(
                children: comment.replies
                    .map((reply) => _buildReplyBubble(reply))
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReplyBubble(Comment reply) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.grey[300],
            child: reply.userAvatar != null
                ? ClipOval(
                    child: Image.network(
                      reply.userAvatar!,
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 14,
                        );
                      },
                    ),
                  )
                : const Icon(Icons.person, color: Colors.grey, size: 14),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${reply.username} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                            fontSize: 13,
                          ),
                        ),
                        TextSpan(
                          text: reply.content,
                          style: const TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        reply.timestamp,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => _handleCommentLike(reply),
                        child: Text(
                          reply.likes > 0
                              ? '${reply.likes} like${reply.likes > 1 ? 's' : ''}'
                              : 'Like',
                          style: TextStyle(
                            fontSize: 11,
                            color: reply.isLiked
                                ? const Color(0xFF4CAF50)
                                : Colors.grey[600],
                            fontWeight: reply.isLiked
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCommentLike(Comment comment) {
    // TODO: Implement comment like functionality
    print('Liked comment: ${comment.id}');
  }

  void _handleReply(Comment comment) {
    // TODO: Implement reply functionality
    print('Reply to comment: ${comment.id}');
  }

  Future<List<SocialPost>> _getMorePostsFromUser() async {
    if (_post == null) return [];

    final allPosts = await SocialFeedDataService.getAllPosts();
    return allPosts
        .where((post) => post.userId == _post!.userId && post.id != _post!.id)
        .take(3) // Show only 3 more posts
        .toList();
  }
}
