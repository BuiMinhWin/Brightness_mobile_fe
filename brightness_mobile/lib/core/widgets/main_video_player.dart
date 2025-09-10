import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class MainVideoPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnailUrl;
  final String title;
  final VoidCallback? onFullscreen;
  final Function(double)? onProgressChanged;
  final Function(bool)? onPlayPause;

  const MainVideoPlayer({
    super.key,
    this.videoUrl,
    this.thumbnailUrl,
    required this.title,
    this.onFullscreen,
    this.onProgressChanged,
    this.onPlayPause,
  });

  @override
  State<MainVideoPlayer> createState() => _MainVideoPlayerState();
}

class _MainVideoPlayerState extends State<MainVideoPlayer> {
  bool _isPlaying = false;
  bool _isLoading = false;
  bool _showControls = true;
  double _progress = 0.0;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = const Duration(minutes: 3, seconds: 45);

  @override
  void initState() {
    super.initState();
    _hideControlsAfterDelay();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleControls,
      child: Container(
        width: double.infinity,
        height: 250,
        color: Colors.black,
        child: Stack(
          children: [
            // Video Player Area
            _buildVideoPlayer(),
            
            // Loading Overlay
            if (_isLoading) _buildLoadingOverlay(),
            
            // Controls Overlay
            if (_showControls) _buildControlsOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.black,
      child: widget.videoUrl != null && widget.videoUrl!.isNotEmpty
          ? _buildVideoContent()
          : _buildPlaceholderContent(),
    );
  }

  Widget _buildVideoContent() {
    // In a real app, you would use a proper video player like video_player package
    // For now, we'll show a placeholder with the video URL
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.black,
        image: widget.thumbnailUrl != null
            ? DecorationImage(
                image: NetworkImage(widget.thumbnailUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              color: Colors.white,
              size: 64,
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Video Player Placeholder',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderContent() {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.black,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_filled,
              color: Colors.white,
              size: 64,
            ),
            SizedBox(height: 8),
            Text(
              'Video Player',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Tap to play video',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.black.withOpacity(0.7),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildControlsOverlay() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.transparent,
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        children: [
          // Top Controls
          _buildTopControls(),
          
          // Center Play Button
          Expanded(
            child: Center(
              child: _buildCenterPlayButton(),
            ),
          ),
          
          // Bottom Controls
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildTopControls() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button (if needed)
          const SizedBox(width: 40),
          
          // Fullscreen button
          IconButton(
            icon: const Icon(
              Icons.fullscreen,
              color: Colors.white,
              size: 24,
            ),
            onPressed: widget.onFullscreen ?? _toggleFullscreen,
          ),
        ],
      ),
    );
  }

  Widget _buildCenterPlayButton() {
    return GestureDetector(
      onTap: _togglePlayPause,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Progress Bar
          _buildProgressBar(),
          
          const SizedBox(height: 8),
          
          // Bottom Row Controls
          Row(
            children: [
              // Play/Pause Button
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: _togglePlayPause,
              ),
              
              // Current Time
              Text(
                _formatDuration(_currentPosition),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              
              const Spacer(),
              
              // Total Duration
              Text(
                _formatDuration(_totalDuration),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Volume Button
              IconButton(
                icon: const Icon(
                  Icons.volume_up,
                  color: Colors.white,
                ),
                onPressed: _toggleVolume,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: AppTheme.primaryColor,
        inactiveTrackColor: Colors.white.withOpacity(0.3),
        thumbColor: AppTheme.primaryColor,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
        trackHeight: 3,
      ),
      child: Slider(
        value: _progress,
        onChanged: _onProgressChanged,
        min: 0.0,
        max: 1.0,
      ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    
    widget.onPlayPause?.call(_isPlaying);
    _hideControlsAfterDelay();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    
    if (_showControls) {
      _hideControlsAfterDelay();
    }
  }

  void _hideControlsAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _onProgressChanged(double value) {
    setState(() {
      _progress = value;
      _currentPosition = Duration(
        milliseconds: (_totalDuration.inMilliseconds * value).round(),
      );
    });
    
    widget.onProgressChanged?.call(value);
  }

  void _toggleFullscreen() {
    widget.onFullscreen?.call();
    
    // Simulate fullscreen toggle
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }

  void _toggleVolume() {
    // Implement volume toggle
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Volume control'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
