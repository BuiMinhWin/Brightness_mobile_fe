import 'dart:convert';
import 'package:flutter/services.dart';

class Comment {
  final String id;
  final String userId;
  final String username;
  final String? userAvatar;
  final String content;
  final String timestamp;
  final int likes;
  final bool isLiked;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.userId,
    required this.username,
    this.userAvatar,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.isLiked,
    required this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    try {
      return Comment(
        id: json['id'] as String,
        userId: json['userId'] as String,
        username: json['username'] as String,
        userAvatar: json['userAvatar'] as String?,
        content: json['content'] as String,
        timestamp: json['timestamp'] as String,
        likes: json['likes'] as int,
        isLiked: json['isLiked'] as bool,
        replies:
            (json['replies'] as List<dynamic>?)
                ?.map(
                  (reply) => Comment.fromJson(reply as Map<String, dynamic>),
                )
                .toList() ??
            [],
      );
    } catch (e) {
      print('Error parsing comment: $e');
      print('Comment data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'userAvatar': userAvatar,
      'content': content,
      'timestamp': timestamp,
      'likes': likes,
      'isLiked': isLiked,
      'replies': replies.map((reply) => reply.toJson()).toList(),
    };
  }

  Comment copyWith({
    String? id,
    String? userId,
    String? username,
    String? userAvatar,
    String? content,
    String? timestamp,
    int? likes,
    bool? isLiked,
    List<Comment>? replies,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      userAvatar: userAvatar ?? this.userAvatar,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
      replies: replies ?? this.replies,
    );
  }
}

class SocialPost {
  final String id;
  final String userId;
  final String username;
  final String? userAvatar;
  final String timestamp;
  final String createdAt;
  final String content;
  final List<String> imageUrls;
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final bool isBookmarked;
  final bool isFollowing;
  final List<String> tags;
  final String category;
  final String? location;
  final String privacy;
  final List<Comment> commentsList;

  SocialPost({
    required this.id,
    required this.userId,
    required this.username,
    this.userAvatar,
    required this.timestamp,
    required this.createdAt,
    required this.content,
    required this.imageUrls,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.isLiked,
    required this.isBookmarked,
    required this.isFollowing,
    required this.tags,
    required this.category,
    this.location,
    required this.privacy,
    required this.commentsList,
  });

  factory SocialPost.fromJson(Map<String, dynamic> json) {
    try {
      return SocialPost(
        id: json['id'] as String,
        userId: json['userId'] as String,
        username: json['username'] as String,
        userAvatar: json['userAvatar'] as String?,
        timestamp: json['timestamp'] as String,
        createdAt: json['createdAt'] as String,
        content: json['content'] as String,
        imageUrls: List<String>.from(json['imageUrls'] ?? []),
        likes: json['likes'] as int,
        comments: json['comments'] as int,
        shares: json['shares'] as int,
        isLiked: json['isLiked'] as bool,
        isBookmarked: json['isBookmarked'] as bool,
        isFollowing: json['isFollowing'] as bool,
        tags: List<String>.from(json['tags'] ?? []),
        category: json['category'] as String,
        location: json['location'] as String?,
        privacy: json['privacy'] as String,
        commentsList: json['commentsList'] != null
            ? (json['commentsList'] as List<dynamic>)
                  .map(
                    (comment) =>
                        Comment.fromJson(comment as Map<String, dynamic>),
                  )
                  .toList()
            : [],
      );
    } catch (e) {
      print('Error parsing SocialPost: $e');
      print('Post data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'userAvatar': userAvatar,
      'timestamp': timestamp,
      'createdAt': createdAt,
      'content': content,
      'imageUrls': imageUrls,
      'likes': likes,
      'comments': comments,
      'shares': shares,
      'isLiked': isLiked,
      'isBookmarked': isBookmarked,
      'isFollowing': isFollowing,
      'tags': tags,
      'category': category,
      'location': location,
      'privacy': privacy,
      'commentsList': commentsList.map((comment) => comment.toJson()).toList(),
    };
  }

  SocialPost copyWith({
    String? id,
    String? userId,
    String? username,
    String? userAvatar,
    String? timestamp,
    String? createdAt,
    String? content,
    List<String>? imageUrls,
    int? likes,
    int? comments,
    int? shares,
    bool? isLiked,
    bool? isBookmarked,
    bool? isFollowing,
    List<String>? tags,
    String? category,
    String? location,
    String? privacy,
    List<Comment>? commentsList,
  }) {
    return SocialPost(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      userAvatar: userAvatar ?? this.userAvatar,
      timestamp: timestamp ?? this.timestamp,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      imageUrls: imageUrls ?? this.imageUrls,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isFollowing: isFollowing ?? this.isFollowing,
      tags: tags ?? this.tags,
      category: category ?? this.category,
      location: location ?? this.location,
      privacy: privacy ?? this.privacy,
      commentsList: commentsList ?? this.commentsList,
    );
  }
}

class SocialFeedDataService {
  static const String _dataPath = 'assets/temps/social_feed_data.json';

  static List<SocialPost> _cachedPosts = [];
  static List<String> _cachedCategories = [];
  static List<String> _cachedTrendingTags = [];
  static bool _isDataLoaded = false;

  /// Load social feed data from JSON file
  static Future<void> _loadData() async {
    if (_isDataLoaded) return;

    try {
      final String jsonString = await rootBundle.loadString(_dataPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      _cachedPosts = (jsonData['posts'] as List).map((postJson) {
        try {
          return SocialPost.fromJson(postJson as Map<String, dynamic>);
        } catch (e) {
          print('Error parsing post: $e');
          print('Post data: $postJson');
          rethrow;
        }
      }).toList();

      _cachedCategories = List<String>.from(jsonData['categories'] ?? []);
      _cachedTrendingTags = List<String>.from(jsonData['trendingTags'] ?? []);

      _isDataLoaded = true;
    } catch (e) {
      print('Error loading social feed data: $e');
      _cachedPosts = [];
      _cachedCategories = [];
      _cachedTrendingTags = [];
    }
  }

  /// Get all posts
  static Future<List<SocialPost>> getAllPosts() async {
    await _loadData();
    return List.from(_cachedPosts);
  }

  /// Get posts by category or tab
  static Future<List<SocialPost>> getPostsByCategory(String category) async {
    await _loadData();

    // Handle special tabs
    switch (category.toLowerCase()) {
      case 'following':
        return _cachedPosts.where((post) => post.isFollowing).toList();
      case 'trending':
        final sortedPosts = List<SocialPost>.from(_cachedPosts);
        sortedPosts.sort(
          (a, b) => (b.likes + b.comments).compareTo(a.likes + a.comments),
        );
        return sortedPosts;
      case 'newest':
        final sortedPosts = List<SocialPost>.from(_cachedPosts);
        sortedPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return sortedPosts;
      case 'all':
        return List.from(_cachedPosts);
      default:
        // Handle regular categories
        return _cachedPosts
            .where(
              (post) => post.category.toLowerCase() == category.toLowerCase(),
            )
            .toList();
    }
  }

  /// Get posts by user ID
  static Future<List<SocialPost>> getPostsByUser(String userId) async {
    await _loadData();
    return _cachedPosts.where((post) => post.userId == userId).toList();
  }

  /// Get trending posts (most liked/commented)
  static Future<List<SocialPost>> getTrendingPosts({int limit = 10}) async {
    await _loadData();
    final sortedPosts = List<SocialPost>.from(_cachedPosts);
    sortedPosts.sort(
      (a, b) => (b.likes + b.comments).compareTo(a.likes + a.comments),
    );
    return sortedPosts.take(limit).toList();
  }

  /// Get recent posts
  static Future<List<SocialPost>> getRecentPosts({int limit = 10}) async {
    await _loadData();
    final sortedPosts = List<SocialPost>.from(_cachedPosts);
    sortedPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedPosts.take(limit).toList();
  }

  /// Search posts by content or tags
  static Future<List<SocialPost>> searchPosts(String query) async {
    await _loadData();
    final lowercaseQuery = query.toLowerCase();
    return _cachedPosts.where((post) {
      return post.content.toLowerCase().contains(lowercaseQuery) ||
          post.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery)) ||
          post.username.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  /// Get all categories
  static Future<List<String>> getCategories() async {
    await _loadData();
    return List.from(_cachedCategories);
  }

  /// Get trending tags
  static Future<List<String>> getTrendingTags() async {
    await _loadData();
    return List.from(_cachedTrendingTags);
  }

  /// Like/Unlike a post
  static Future<SocialPost?> toggleLike(String postId) async {
    await _loadData();
    final postIndex = _cachedPosts.indexWhere((post) => post.id == postId);
    if (postIndex == -1) return null;

    final post = _cachedPosts[postIndex];
    final updatedPost = post.copyWith(
      isLiked: !post.isLiked,
      likes: post.isLiked ? post.likes - 1 : post.likes + 1,
    );

    _cachedPosts[postIndex] = updatedPost;
    return updatedPost;
  }

  /// Bookmark/Unbookmark a post
  static Future<SocialPost?> toggleBookmark(String postId) async {
    await _loadData();
    final postIndex = _cachedPosts.indexWhere((post) => post.id == postId);
    if (postIndex == -1) return null;

    final post = _cachedPosts[postIndex];
    final updatedPost = post.copyWith(isBookmarked: !post.isBookmarked);

    _cachedPosts[postIndex] = updatedPost;
    return updatedPost;
  }

  /// Follow/Unfollow a user
  static Future<bool> toggleFollow(String userId) async {
    await _loadData();
    bool hasChanges = false;

    for (int i = 0; i < _cachedPosts.length; i++) {
      if (_cachedPosts[i].userId == userId) {
        _cachedPosts[i] = _cachedPosts[i].copyWith(
          isFollowing: !_cachedPosts[i].isFollowing,
        );
        hasChanges = true;
      }
    }

    return hasChanges;
  }

  /// Get bookmarked posts
  static Future<List<SocialPost>> getBookmarkedPosts() async {
    await _loadData();
    return _cachedPosts.where((post) => post.isBookmarked).toList();
  }

  /// Get posts from followed users
  static Future<List<SocialPost>> getFollowingPosts() async {
    await _loadData();
    return _cachedPosts.where((post) => post.isFollowing).toList();
  }

  /// Add a new post (for future use with real API)
  static Future<SocialPost?> addPost(SocialPost newPost) async {
    await _loadData();
    _cachedPosts.insert(0, newPost);
    return newPost;
  }

  /// Get post by ID
  static Future<SocialPost?> getPostById(String postId) async {
    await _loadData();
    try {
      return _cachedPosts.firstWhere((post) => post.id == postId);
    } catch (e) {
      return null;
    }
  }

  /// Refresh data (reload from JSON)
  static Future<void> refreshData() async {
    _isDataLoaded = false;
    await _loadData();
  }

  /// Clear cached data
  static void clearCache() {
    _cachedPosts.clear();
    _cachedCategories.clear();
    _cachedTrendingTags.clear();
    _isDataLoaded = false;
  }
}
