import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/widgets/video_card.dart';
import '../../core/widgets/category_tabs.dart';
import '../../core/widgets/related_videos.dart';
import '../../features/profile/presentation/controllers/video_controller.dart';

class FirstAidDataService {
  static const String _videosPath = 'assets/temps/first_aid_videos.json';
  static const String _categoriesPath = 'assets/temps/first_aid_categories.json';

  /// Loads first aid videos from JSON file
  /// This function can be easily replaced with an API call later
  static Future<List<FirstAidVideo>> getFirstAidVideos() async {
    try {
      final String response = await rootBundle.loadString(_videosPath);
      final Map<String, dynamic> data = json.decode(response);
      
      final List<dynamic> videosJson = data['videos'];
      return videosJson.map((videoJson) => _parseVideoFromJson(videoJson)).toList();
    } catch (e) {
      print('Error loading first aid videos: $e');
      return [];
    }
  }

  /// Loads categories from JSON file
  /// This function can be easily replaced with an API call later
  static Future<List<CategoryData>> getFirstAidCategories() async {
    try {
      final String response = await rootBundle.loadString(_categoriesPath);
      final Map<String, dynamic> data = json.decode(response);
      
      final List<dynamic> categoriesJson = data['categories'];
      return categoriesJson.map((categoryJson) => CategoryData(
        id: categoryJson['id'],
        name: categoryJson['name'],
      )).toList();
    } catch (e) {
      print('Error loading first aid categories: $e');
      return [];
    }
  }

  /// Parses a video JSON object into FirstAidVideo model
  static FirstAidVideo _parseVideoFromJson(Map<String, dynamic> json) {
    return FirstAidVideo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      category: json['category'],
      categoryColor: _parseColor(json['categoryColor']),
      authorName: json['authorName'],
      viewCount: json['viewCount'],
      timestamp: json['timestamp'],
      hashtags: (json['hashtags'] as List<dynamic>)
          .map((hashtagJson) => HashtagData(
                text: hashtagJson['text'],
                color: _parseColor(hashtagJson['color']),
              ))
          .toList(),
    );
  }

  /// Converts color string to Color object
  static Color _parseColor(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.blue; // Default color
    }
  }

  /// Parses timestamp string to DateTime
  static DateTime _parseTimestamp(String timestamp) {
    final now = DateTime.now();
    if (timestamp.contains('day')) {
      final days = int.tryParse(timestamp.split(' ')[0]) ?? 1;
      return now.subtract(Duration(days: days));
    } else if (timestamp.contains('week')) {
      final weeks = int.tryParse(timestamp.split(' ')[0]) ?? 1;
      return now.subtract(Duration(days: weeks * 7));
    } else if (timestamp.contains('month')) {
      final months = int.tryParse(timestamp.split(' ')[0]) ?? 1;
      return now.subtract(Duration(days: months * 30));
    }
    return now.subtract(const Duration(days: 1)); // Default to 1 day ago
  }

  /// Simulates pagination by returning videos in chunks
  /// This can be replaced with actual API pagination later
  static Future<List<FirstAidVideo>> getFirstAidVideosPaginated({
    required int page,
    required int pageSize,
    String? category,
    String? searchQuery,
  }) async {
    try {
      final allVideos = await getFirstAidVideos();
      
      // Apply filters
      List<FirstAidVideo> filteredVideos = allVideos;
      
      if (category != null && category != 'all') {
        filteredVideos = filteredVideos.where((video) => 
          video.category.toLowerCase().replaceAll(' ', '_') == category
        ).toList();
      }
      
      if (searchQuery != null && searchQuery.isNotEmpty) {
        filteredVideos = filteredVideos.where((video) =>
          video.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          video.description.toLowerCase().contains(searchQuery.toLowerCase()) ||
          video.authorName.toLowerCase().contains(searchQuery.toLowerCase())
        ).toList();
      }
      
      // Apply pagination
      final startIndex = (page - 1) * pageSize;
      final endIndex = startIndex + pageSize;
      
      if (startIndex >= filteredVideos.length) {
        return [];
      }
      
      return filteredVideos.sublist(
        startIndex,
        endIndex > filteredVideos.length ? filteredVideos.length : endIndex,
      );
    } catch (e) {
      print('Error loading paginated first aid videos: $e');
      return [];
    }
  }

  /// Converts FirstAidVideo to VideoModel for the video controller
  static VideoModel convertToVideoModel(FirstAidVideo firstAidVideo) {
    return VideoModel(
      id: firstAidVideo.id,
      title: firstAidVideo.title,
      description: firstAidVideo.description,
      duration: firstAidVideo.duration,
      videoUrl: 'https://example.com/videos/${firstAidVideo.id}.mp4', // Placeholder URL
      thumbnailUrl: 'https://example.com/thumbnails/${firstAidVideo.id}.jpg', // Placeholder URL
      authorName: firstAidVideo.authorName,
      authorCredentials: 'Medical Professional', // Default credential
      authorAvatarUrl: 'https://example.com/avatars/${firstAidVideo.authorName.toLowerCase().replaceAll(' ', '_')}.jpg',
      viewCount: firstAidVideo.viewCount,
      likeCount: (firstAidVideo.viewCount * 0.1).round(), // Estimate likes as 10% of views
      uploadDate: firstAidVideo.timestamp,
      categories: [firstAidVideo.category],
      isBookmarked: false,
      isSavedOffline: false,
      isLiked: false,
      createdAt: _parseTimestamp(firstAidVideo.timestamp),
      updatedAt: DateTime.now(),
    );
  }

  /// Converts FirstAidVideo to RelatedVideoData for related videos widget
  static RelatedVideoData convertToRelatedVideoData(FirstAidVideo firstAidVideo) {
    return RelatedVideoData(
      id: firstAidVideo.id,
      title: firstAidVideo.title,
      description: firstAidVideo.description,
      duration: firstAidVideo.duration,
      thumbnailUrl: 'https://example.com/thumbnails/${firstAidVideo.id}.jpg', // Placeholder URL
      authorName: firstAidVideo.authorName,
      viewCount: firstAidVideo.viewCount,
      timestamp: firstAidVideo.timestamp,
      videoUrl: 'https://example.com/videos/${firstAidVideo.id}.mp4', // Placeholder URL
    );
  }

  /// Gets a specific video by ID
  static Future<VideoModel?> getVideoById(String videoId) async {
    try {
      final videos = await getFirstAidVideos();
      final video = videos.firstWhere(
        (v) => v.id == videoId,
        orElse: () => throw StateError('Video not found'),
      );
      return convertToVideoModel(video);
    } catch (e) {
      print('Error loading video by ID: $e');
      return null;
    }
  }

  /// Gets related videos (excluding the current video)
  static Future<List<RelatedVideoData>> getRelatedVideos(String currentVideoId, {int limit = 4}) async {
    try {
      final videos = await getFirstAidVideos();
      final relatedVideos = videos
          .where((video) => video.id != currentVideoId)
          .take(limit)
          .map((video) => convertToRelatedVideoData(video))
          .toList();
      return relatedVideos;
    } catch (e) {
      print('Error loading related videos: $e');
      return [];
    }
  }
}
