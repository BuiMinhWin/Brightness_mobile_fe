import 'package:flutter/material.dart';
import '../../../../shared/services/first_aid_data_service.dart';

// Video Model
class VideoModel {
  final String id;
  final String title;
  final String description;
  final String duration;
  final String? videoUrl;
  final String? thumbnailUrl;
  final String authorName;
  final String authorCredentials;
  final String? authorAvatarUrl;
  final int viewCount;
  final int likeCount;
  final String uploadDate;
  final List<String> categories;
  final bool isBookmarked;
  final bool isSavedOffline;
  final bool isLiked;
  final DateTime createdAt;
  final DateTime updatedAt;

  const VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    this.videoUrl,
    this.thumbnailUrl,
    required this.authorName,
    required this.authorCredentials,
    this.authorAvatarUrl,
    required this.viewCount,
    required this.likeCount,
    required this.uploadDate,
    required this.categories,
    this.isBookmarked = false,
    this.isSavedOffline = false,
    this.isLiked = false,
    required this.createdAt,
    required this.updatedAt,
  });

  VideoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? duration,
    String? videoUrl,
    String? thumbnailUrl,
    String? authorName,
    String? authorCredentials,
    String? authorAvatarUrl,
    int? viewCount,
    int? likeCount,
    String? uploadDate,
    List<String>? categories,
    bool? isBookmarked,
    bool? isSavedOffline,
    bool? isLiked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      authorName: authorName ?? this.authorName,
      authorCredentials: authorCredentials ?? this.authorCredentials,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      uploadDate: uploadDate ?? this.uploadDate,
      categories: categories ?? this.categories,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isSavedOffline: isSavedOffline ?? this.isSavedOffline,
      isLiked: isLiked ?? this.isLiked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// Video Controller
class VideoController extends ChangeNotifier {
  // State
  VideoModel? _currentVideo;
  List<VideoModel> _relatedVideos = [];
  bool _isLoading = false;
  String? _error;
  
  // Getters
  VideoModel? get currentVideo => _currentVideo;
  List<VideoModel> get relatedVideos => List.unmodifiable(_relatedVideos);
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // Load video by ID (touches database)
  Future<void> loadVideo(String videoId) async {
    _setLoading(true);
    _clearError();
    
    try {
      // This is where your friend meant "controller với model thì nó đụng tới db"
      // The controller calls the repository/service which touches the database
      final video = await _videoRepository.getVideoById(videoId);
      final related = await _videoRepository.getRelatedVideos(videoId);
      
      _currentVideo = video;
      _relatedVideos = related;
      
      // Track video view (also touches database)
      // TODO: Implement video view tracking
      // await _trackVideoView(videoId);
      
    } catch (e) {
      _setError('Failed to load video: $e');
    } finally {
      _setLoading(false);
    }
  }
  
  // Bookmark video (touches database)
  Future<void> toggleBookmark(String videoId) async {
    if (_currentVideo == null) return;
    
    try {
      final newBookmarkState = !_currentVideo!.isBookmarked;
      
      // Update in database
      await _videoRepository.updateBookmarkStatus(videoId, newBookmarkState);
      
      // Update local state
      _currentVideo = _currentVideo!.copyWith(
        isBookmarked: newBookmarkState,
        updatedAt: DateTime.now(),
      );
      
      notifyListeners();
      
    } catch (e) {
      _setError('Failed to update bookmark: $e');
    }
  }
  
  // Save video offline (touches database)
  Future<void> toggleSaveOffline(String videoId) async {
    if (_currentVideo == null) return;
    
    try {
      final newOfflineState = !_currentVideo!.isSavedOffline;
      
      // Update in database
      await _videoRepository.updateOfflineStatus(videoId, newOfflineState);
      
      // Update local state
      _currentVideo = _currentVideo!.copyWith(
        isSavedOffline: newOfflineState,
        updatedAt: DateTime.now(),
      );
      
      notifyListeners();
      
    } catch (e) {
      _setError('Failed to update offline status: $e');
    }
  }
  
  // Like video (touches database)
  Future<void> toggleLike(String videoId) async {
    if (_currentVideo == null) return;
    
    try {
      final newLikeCount = _currentVideo!.isLiked 
          ? _currentVideo!.likeCount - 1 
          : _currentVideo!.likeCount + 1;
      
      // Update in database
      await _videoRepository.updateLikeStatus(videoId, !_currentVideo!.isLiked);
      
      // Update local state
      _currentVideo = _currentVideo!.copyWith(
        likeCount: newLikeCount,
        updatedAt: DateTime.now(),
      );
      
      notifyListeners();
      
    } catch (e) {
      _setError('Failed to update like: $e');
    }
  }
  
  // Track video progress (touches database)
  Future<void> updateVideoProgress(String videoId, double progress) async {
    try {
      await _videoRepository.updateVideoProgress(videoId, progress);
    } catch (e) {
      // Don't show error for progress updates
      print('Failed to update progress: $e');
    }
  }
  
  // Private methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void _setError(String error) {
    _error = error;
    notifyListeners();
  }
  
  void _clearError() {
    _error = null;
  }
  
  // Mock repository - in real app, this would be injected
  final _VideoRepository _videoRepository = _VideoRepository();
}

// Video Repository that uses FirstAidDataService (this is what touches the database)
class _VideoRepository {
  Future<VideoModel> getVideoById(String id) async {
    // Load video from JSON data service
    final video = await FirstAidDataService.getVideoById(id);
    if (video == null) {
      throw Exception('Video not found');
    }
    return video;
  }
  
  Future<List<VideoModel>> getRelatedVideos(String videoId) async {
    // Load related videos from JSON data service
    final relatedVideosData = await FirstAidDataService.getRelatedVideos(videoId, limit: 4);
    
    // Convert RelatedVideoData to VideoModel
    return relatedVideosData.map((relatedVideo) => VideoModel(
      id: relatedVideo.id,
      title: relatedVideo.title,
      description: relatedVideo.description,
      duration: relatedVideo.duration,
      videoUrl: relatedVideo.videoUrl,
      thumbnailUrl: relatedVideo.thumbnailUrl,
      authorName: relatedVideo.authorName,
      authorCredentials: 'Medical Professional', // Default credential
      authorAvatarUrl: 'https://example.com/avatars/${relatedVideo.authorName.toLowerCase().replaceAll(' ', '_')}.jpg',
      viewCount: relatedVideo.viewCount,
      likeCount: (relatedVideo.viewCount * 0.1).round(), // Estimate likes as 10% of views
      uploadDate: relatedVideo.timestamp,
      categories: ['First Aid'], // Default category
      isBookmarked: false,
      isSavedOffline: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now(),
    )).toList();
  }
  
  Future<void> updateBookmarkStatus(String videoId, bool isBookmarked) async {
    // Simulate database update
    await Future.delayed(const Duration(milliseconds: 300));
    print('Updated bookmark status for video $videoId: $isBookmarked');
  }
  
  Future<void> updateOfflineStatus(String videoId, bool isSavedOffline) async {
    // Simulate database update
    await Future.delayed(const Duration(milliseconds: 300));
    print('Updated offline status for video $videoId: $isSavedOffline');
  }
  
  Future<void> updateLikeStatus(String videoId, bool isLiked) async {
    // Simulate database update
    await Future.delayed(const Duration(milliseconds: 300));
    print('Updated like status for video $videoId: $isLiked');
  }
  
  Future<void> updateVideoProgress(String videoId, double progress) async {
    // Simulate database update
    await Future.delayed(const Duration(milliseconds: 100));
    print('Updated progress for video $videoId: ${(progress * 100).toStringAsFixed(1)}%');
  }
  
  Future<void> trackVideoView(String videoId) async {
    // Simulate database update
    await Future.delayed(const Duration(milliseconds: 200));
    print('Tracked view for video $videoId');
  }
}
