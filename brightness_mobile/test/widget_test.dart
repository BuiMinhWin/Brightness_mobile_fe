// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brightness_mobile/features/profile/presentation/pages/profile_demo_page.dart';

void main() {
  testWidgets('Profile demo page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: ProfileDemoPage()));

    // Verify that the profile demo page loads.
    expect(find.text('Profile Management Demo'), findsOneWidget);
    expect(find.text('Open Edit Profile'), findsOneWidget);
  });
}
