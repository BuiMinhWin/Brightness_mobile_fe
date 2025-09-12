import 'package:flutter/material.dart' hide SearchBar;
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/video_app_bar.dart';
import '../../../../core/widgets/category_tabs.dart';
import '../../../../core/widgets/search_bar.dart';
import '../../../../core/widgets/video_feed.dart';
import '../../../../core/widgets/video_card.dart';
import '../../../../shared/services/first_aid_data_service.dart';
import '../controllers/navigation_controller.dart';

class FirstAidVideosPage extends StatefulWidget {
  const FirstAidVideosPage({super.key});

  @override
  State<FirstAidVideosPage> createState() => _FirstAidVideosPageState();
}

class _FirstAidVideosPageState extends State<FirstAidVideosPage> {
  String _selectedCategory = 'all';
  String _searchQuery = '';
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;

  // Categories loaded from JSON
  List<CategoryData> _categories = [];

  // Sample videos data
  List<FirstAidVideo> _videos = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: VideoAppBar(
        onFilterPressed: _showFilterOptions,
      ),
      body: Column(
        children: [
          // Category Tabs
          CategoryTabs(
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategorySelected: _onCategorySelected,
          ),
          
          // Search Bar
          SearchBar(
            onSearchChanged: _onSearchChanged,
            onSearchSubmitted: _onSearchSubmitted,
            showVoiceSearch: true,
            onVoiceSearch: _onVoiceSearch,
          ),
          
          // Video Feed
          Expanded(
            child: VideoFeed(
              videos: _videos,
              isLoading: _isLoading,
              hasMore: _hasMore,
              onLoadMore: _loadMoreVideos,
              onRefresh: _refreshVideos,
              onVideoTap: _onVideoTap,
              onVideoShare: _onVideoShare,
            ),
          ),
        ],
      ),
    );
  }

  void _loadCategories() async {
    final categories = await FirstAidDataService.getFirstAidCategories();
    if (mounted) {
      setState(() {
        _categories = categories;
      });
    }
  }

  void _loadVideos() {
    setState(() {
      _isLoading = true;
    });

    // Load videos from JSON data service
    FirstAidDataService.getFirstAidVideosPaginated(
      page: 1,
      pageSize: 4,
      category: _selectedCategory,
      searchQuery: _searchQuery,
    ).then((videos) {
      if (mounted) {
        setState(() {
          _videos = videos;
          _isLoading = false;
        });
      }
    });
  }

  void _loadMoreVideos() {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
      _currentPage++;
    });

    // Load more videos from JSON data service
    FirstAidDataService.getFirstAidVideosPaginated(
      page: _currentPage,
      pageSize: 4,
      category: _selectedCategory,
      searchQuery: _searchQuery,
    ).then((moreVideos) {
      if (mounted) {
        setState(() {
          _videos.addAll(moreVideos);
          _isLoading = false;
          if (moreVideos.isEmpty) {
            _hasMore = false;
          }
        });
      }
    });
  }

  Future<void> _refreshVideos() async {
    setState(() {
      _currentPage = 1;
      _hasMore = true;
    });
    
    // Refresh videos from JSON data service
    final videos = await FirstAidDataService.getFirstAidVideosPaginated(
      page: 1,
      pageSize: 4,
      category: _selectedCategory,
      searchQuery: _searchQuery,
    );
    
    if (mounted) {
      setState(() {
        _videos = videos;
      });
    }
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
    _filterVideos();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onSearchSubmitted(String query) {
    setState(() {
      _searchQuery = query;
    });
    _filterVideos();
  }

  void _onVoiceSearch() {
    // Implement voice search functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Voice search feature coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _filterVideos() {
    // Filter videos based on category and search query
    // This would typically involve API calls
    _loadVideos();
  }

  void _onVideoTap(FirstAidVideo video) {
    // Navigate to watch video page using NavigationController
    context.read<NavigationController>().navigateToWatchVideo(
      videoId: video.id,
      videoUrl: 'https://example.com/videos/${video.id}.mp4', // Placeholder URL
      videoData: {
        'title': video.title,
        'description': video.description,
        'duration': video.duration,
        'authorName': video.authorName,
        'viewCount': video.viewCount,
        'timestamp': video.timestamp,
        'category': video.category,
      },
      context: context,
    );
  }


  void _onVideoShare(FirstAidVideo video) {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing: ${video.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Filter Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            _buildFilterOption('Sort by Date', Icons.calendar_today),
            _buildFilterOption('Sort by Views', Icons.visibility),
            _buildFilterOption('Sort by Duration', Icons.access_time),
            _buildFilterOption('Sort by Rating', Icons.star),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Filtered by: $title'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }

}
