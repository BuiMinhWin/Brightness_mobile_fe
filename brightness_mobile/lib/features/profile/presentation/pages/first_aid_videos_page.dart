import 'package:flutter/material.dart' hide SearchBar;
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/video_app_bar.dart';
import '../../../../core/widgets/category_tabs.dart';
import '../../../../core/widgets/search_bar.dart';
import '../../../../core/widgets/video_feed.dart';
import '../../../../core/widgets/video_card.dart';

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

  // Sample categories
  final List<CategoryData> _categories = const [
    CategoryData(id: 'all', name: 'All'),
    CategoryData(id: 'muscle_injury', name: 'Muscle Injury'),
    CategoryData(id: 'heat_exhaustion', name: 'Heat Exhaustion'),
    CategoryData(id: 'recovery', name: 'Recovery'),
    CategoryData(id: 'sprains', name: 'Sprains'),
    CategoryData(id: 'emergency', name: 'Emergency'),
  ];

  // Sample videos data
  List<FirstAidVideo> _videos = [];

  @override
  void initState() {
    super.initState();
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
              onVideoPlay: _onVideoPlay,
              onVideoShare: _onVideoShare,
            ),
          ),
        ],
      ),
    );
  }

  void _loadVideos() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _videos = _getSampleVideos();
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

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _videos.addAll(_getMoreVideos());
          _isLoading = false;
          if (_currentPage >= 3) {
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
    
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      setState(() {
        _videos = _getSampleVideos();
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
    // Navigate to video detail page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on: ${video.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onVideoPlay(FirstAidVideo video) {
    // Track video play analytics
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Playing: ${video.title}'),
        duration: const Duration(seconds: 1),
      ),
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

  List<FirstAidVideo> _getSampleVideos() {
    return [
      FirstAidVideo(
        id: '1',
        title: 'How to treat a pulled hamstring',
        description: 'Learn basic first aid for muscle strain during leg day and prevent further injury',
        duration: '7:50',
        category: 'Muscle Injury',
        categoryColor: Colors.blue,
        authorName: 'Dr. Sarah Mitchell',
        viewCount: 12500,
        timestamp: '2 days ago',
        hashtags: const [
          HashtagData(text: 'Stretching', color: Colors.blue),
          HashtagData(text: 'InjuryCare', color: Colors.blue),
          HashtagData(text: 'FirstAid', color: Colors.blue),
        ],
      ),
      FirstAidVideo(
        id: '2',
        title: 'RICE Method for Ankle Sprains',
        description: 'Complete guide to Rest, Ice, Compression, and Elevation for treating ankle sprains',
        duration: '5:30',
        category: 'Sprains',
        categoryColor: Colors.blue,
        authorName: 'Coach Mike Johnson',
        viewCount: 8900,
        timestamp: '1 week ago',
        hashtags: const [
          HashtagData(text: 'Sprains', color: Colors.blue),
          HashtagData(text: 'InjuryCare', color: Colors.blue),
          HashtagData(text: 'RICE', color: Colors.blue),
        ],
      ),
      FirstAidVideo(
        id: '3',
        title: 'Heat Exhaustion Emergency Care',
        description: 'Recognize and treat heat exhaustion during outdoor workouts and sports',
        duration: '6:15',
        category: 'Heat Exhaustion',
        categoryColor: Colors.orange,
        authorName: 'Dr. Lisa Chen',
        viewCount: 15600,
        timestamp: '3 days ago',
        hashtags: const [
          HashtagData(text: 'HeatExhaustion', color: Colors.orange),
          HashtagData(text: 'Emergency', color: Colors.orange),
          HashtagData(text: 'Prevention', color: Colors.orange),
        ],
      ),
      FirstAidVideo(
        id: '4',
        title: 'Shoulder Injury Stabilization',
        description: 'Proper techniques for stabilizing shoulder injuries during recovery',
        duration: '8:20',
        category: 'Recovery',
        categoryColor: Colors.purple,
        authorName: 'Alex Rodriguez, PT',
        viewCount: 7200,
        timestamp: '5 days ago',
        hashtags: const [
          HashtagData(text: 'Shoulder', color: Colors.purple),
          HashtagData(text: 'InjuryCare', color: Colors.purple),
          HashtagData(text: 'Stabilization', color: Colors.purple),
        ],
      ),
    ];
  }

  List<FirstAidVideo> _getMoreVideos() {
    return [
      FirstAidVideo(
        id: '5',
        title: 'Knee Pain Management Techniques',
        description: 'Effective methods to manage and prevent knee pain during exercise',
        duration: '9:10',
        category: 'Recovery',
        categoryColor: Colors.purple,
        authorName: 'Dr. Maria Santos',
        viewCount: 9800,
        timestamp: '1 week ago',
        hashtags: const [
          HashtagData(text: 'KneePain', color: Colors.purple),
          HashtagData(text: 'Recovery', color: Colors.purple),
          HashtagData(text: 'Prevention', color: Colors.purple),
        ],
      ),
      FirstAidVideo(
        id: '6',
        title: 'Emergency CPR for Athletes',
        description: 'Basic CPR techniques specifically for sports-related emergencies',
        duration: '12:30',
        category: 'Emergency',
        categoryColor: Colors.red,
        authorName: 'Dr. James Wilson',
        viewCount: 23400,
        timestamp: '2 weeks ago',
        hashtags: const [
          HashtagData(text: 'CPR', color: Colors.red),
          HashtagData(text: 'Emergency', color: Colors.red),
          HashtagData(text: 'Athletes', color: Colors.red),
        ],
      ),
    ];
  }
}
