import 'package:flutter/material.dart';
import 'post_detail/widgets/post_detail_header.dart';
import 'post_detail/widgets/comment_input.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;
  final Map<String, dynamic>? postData;

  const PostDetailScreen({
    super.key,
    required this.postId,
    this.postData,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;
  bool _isFollowing = false;
  bool _isLiked = false;
  bool _isBookmarked = false;
  int _likesCount = 0;
  int _commentsCount = 0;
  Map<String, dynamic>? _postData;

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
      // Use passed data for demo
      _postData = widget.postData;
      _isFollowing = widget.postData!['isFollowing'] ?? false;
      _isLiked = widget.postData!['isLiked'] ?? false;
      _isBookmarked = widget.postData!['isBookmarked'] ?? false;
      _likesCount = widget.postData!['likes'] ?? 0;
      _commentsCount = widget.postData!['comments'] ?? 0;
      print('Using passed post data');
    } else {
      // Load from API using postId
      print('Loading post data from API');
      _loadPostData();
    }
  }

  Future<void> _loadPostData() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Replace with actual API call
      // final postData = await PostService.getPostById(widget.postId);
      
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, create sample data
      _postData = {
        'id': widget.postId,
        'userId': 'user_001',
        'username': 'Demo User',
        'userAvatar': null,
        'timestamp': '1h ago',
        'createdAt': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
        'content': 'This is a demo post loaded from API using postId: ${widget.postId}',
        'imageUrls': [],
        'likes': 50,
        'comments': 10,
        'shares': 5,
        'isLiked': false,
        'isBookmarked': false,
        'isFollowing': false,
        'tags': ['Demo', 'API'],
      };
      
      _isFollowing = _postData!['isFollowing'] ?? false;
      _isLiked = _postData!['isLiked'] ?? false;
      _isBookmarked = _postData!['isBookmarked'] ?? false;
      _likesCount = _postData!['likes'] ?? 0;
      _commentsCount = _postData!['comments'] ?? 0;
      
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
    try {
      // TODO: Replace with actual API call
      // await UserService.followUser(_postData!['userId']);
      
      setState(() {
        _isFollowing = !_isFollowing;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isFollowing ? 'Following user' : 'Unfollowed user'),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to follow user: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleLike() async {
    try {
      // TODO: Replace with actual API call
      // await PostService.likePost(widget.postId, !_isLiked);
      
      setState(() {
        _isLiked = !_isLiked;
        _likesCount += _isLiked ? 1 : -1;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to like post: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleBookmark() async {
    try {
      // TODO: Replace with actual API call
      // await PostService.bookmarkPost(widget.postId, !_isBookmarked);
      
      setState(() {
        _isBookmarked = !_isBookmarked;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isBookmarked ? 'Post bookmarked' : 'Post removed from bookmarks'),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to bookmark post: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleComment() async {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) return;
    
    try {
      // TODO: Replace with actual API call
      // await CommentService.postComment(widget.postId, comment);
      
      _commentController.clear();
      setState(() {
        _commentsCount++;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comment posted successfully'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to post comment: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PostDetailHeader(),
        body: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF4CAF50),
          ),
        ),
      );
    }

    if (_postData == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PostDetailHeader(),
        body: const Center(
          child: Text(
            'Post not found',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF6B7280),
            ),
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
            // Simple test content
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Post Detail Screen',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Post ID: ${widget.postId}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Content: ${_postData?['content'] ?? 'No content'}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _handleFollow,
                    child: Text(_isFollowing ? 'Following' : 'Follow'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100), // Space for comment input
          ],
        ),
      ),
      bottomNavigationBar: CommentInput(
        controller: _commentController,
        onCommentSubmitted: _handleComment,
      ),
    );
  }
}
