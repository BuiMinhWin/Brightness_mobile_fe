import 'package:flutter/material.dart';
import 'post_detail/widgets/post_detail_header.dart';
import 'post_detail/widgets/post_author_info.dart';
import 'post_detail/widgets/post_content_detail.dart';
import 'post_detail/widgets/post_media.dart';
import 'post_detail/widgets/post_interactions.dart';
import 'post_detail/widgets/comments_section.dart';
import 'post_detail/widgets/user_posts_preview.dart';
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
  bool _isFollowing = false;
  bool _isLiked = false;
  bool _isBookmarked = false;
  int _likesCount = 127;
  int _commentsCount = 23;

  @override
  void initState() {
    super.initState();
    // Load post data based on postId
    _loadPostData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _loadPostData() {
    // TODO: Load post data from API using postId
    // For now, using sample data
  }

  void _handleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
    // TODO: Implement follow/unfollow API call
  }

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likesCount += _isLiked ? 1 : -1;
    });
    // TODO: Implement like/unlike API call
  }

  void _handleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    // TODO: Implement bookmark API call
  }

  void _handleComment() {
    final comment = _commentController.text.trim();
    if (comment.isNotEmpty) {
      // TODO: Implement comment posting API call
      _commentController.clear();
      setState(() {
        _commentsCount++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PostDetailHeader(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostAuthorInfo(
                    isFollowing: _isFollowing,
                    onFollowPressed: _handleFollow,
                  ),
                  PostContentDetail(),
                  PostMedia(),
                  PostInteractions(
                    isLiked: _isLiked,
                    isBookmarked: _isBookmarked,
                    likesCount: _likesCount,
                    commentsCount: _commentsCount,
                    onLikePressed: _handleLike,
                    onBookmarkPressed: _handleBookmark,
                  ),
                  const CommentsSection(),
                  const UserPostsPreview(),
                  const SizedBox(height: 100), // Space for comment input
                ],
              ),
            ),
          ),
          CommentInput(
            controller: _commentController,
            onCommentSubmitted: _handleComment,
          ),
        ],
      ),
    );
  }
}
