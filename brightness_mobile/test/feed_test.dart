import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:brightness_mobile/features/feed/feed_screen.dart';
import 'package:brightness_mobile/features/feed/widgets/feed_app_bar.dart';
import 'package:brightness_mobile/features/feed/widgets/feed_tabs.dart';
import 'package:brightness_mobile/features/feed/widgets/social_post_card.dart';
import 'package:brightness_mobile/features/feed/widgets/hashtag_text.dart';

void main() {
  group('Feed Components Tests', () {
    testWidgets('FeedScreen should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: FeedScreen(),
        ),
      );

      expect(find.text('FitNews'), findsOneWidget);
      expect(find.text('Following'), findsOneWidget);
      expect(find.text('Trending'), findsOneWidget);
      expect(find.text('Newest'), findsOneWidget);
    });

    testWidgets('FeedAppBar should have correct elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: FeedAppBar(),
            body: SizedBox(),
          ),
        ),
      );

      expect(find.text('FitNews'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
    });

    testWidgets('FeedTabs should switch tabs correctly', (WidgetTester tester) async {
      String selectedTab = 'Following';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedTabs(
              selectedTab: selectedTab,
              onTabChanged: (tab) {
                selectedTab = tab;
              },
            ),
          ),
        ),
      );

      expect(find.text('Following'), findsOneWidget);
      expect(find.text('Trending'), findsOneWidget);
      expect(find.text('Newest'), findsOneWidget);

      await tester.tap(find.text('Trending'));
      await tester.pump();
    });

    testWidgets('SocialPostCard should render with sample data', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: SocialPostCard(
                username: 'Test User',
                timestamp: '2h ago',
                content: 'This is a test post with #hashtag',
                likes: 10,
                comments: 5,
                shares: 2,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('2h ago'), findsOneWidget);
      // The content is rendered as RichText with HashtagText, so we need to find it differently
      expect(find.textContaining('This is a test post'), findsOneWidget);
    });

    testWidgets('HashtagText should render hashtags with colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HashtagText(
              text: 'This is a #Workout post with #Fitness hashtags',
            ),
          ),
        ),
      );

      expect(find.textContaining('This is a'), findsOneWidget);
      expect(find.textContaining('#Workout'), findsOneWidget);
      expect(find.textContaining('#Fitness'), findsOneWidget);
    });
  });
}
