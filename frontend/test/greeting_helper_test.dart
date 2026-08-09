import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/home/home_screen.dart';
import 'package:frontend/services/storage_service.dart';
import 'package:frontend/utils/greeting_helper.dart';

void main() {
  group('GreetingHelper Unit Tests', () {
    test('Returns "Good Morning" between 5:00 AM and 11:59 AM', () {
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 5, 0),
        ),
        'Good Morning',
      );
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 10, 30),
        ),
        'Good Morning',
      );
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 11, 59),
        ),
        'Good Morning',
      );
    });

    test('Returns "Good Afternoon" between 12:00 PM and 4:59 PM', () {
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 12, 0),
        ),
        'Good Afternoon',
      );
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 14, 0),
        ),
        'Good Afternoon',
      );
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 16, 59),
        ),
        'Good Afternoon',
      );
    });

    test('Returns "Good Evening" between 5:00 PM and 8:59 PM', () {
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 17, 0),
        ),
        'Good Evening',
      );
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 19, 0),
        ),
        'Good Evening',
      );
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 20, 59),
        ),
        'Good Evening',
      );
    });

    test('Returns "Good Night" between 9:00 PM and 4:59 AM', () {
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 21, 0),
        ),
        'Good Night',
      );
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 22, 0),
        ),
        'Good Night',
      );
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 23, 59),
        ),
        'Good Night',
      );
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 0, 0),
        ),
        'Good Night',
      );
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 3, 30),
        ),
        'Good Night',
      );
      expect(
        GreetingHelper.getGreetingPrefix(
          dateTime: DateTime(2026, 8, 9, 4, 59),
        ),
        'Good Night',
      );
    });

    test('getFullGreeting formats correctly with provided name and fallback', () {
      expect(
        GreetingHelper.getFullGreeting(
          name: 'Ameen',
          dateTime: DateTime(2026, 8, 9, 10, 30),
        ),
        'Good Morning, Ameen',
      );
      expect(
        GreetingHelper.getFullGreeting(
          name: 'Ameen',
          dateTime: DateTime(2026, 8, 9, 14, 0),
        ),
        'Good Afternoon, Ameen',
      );
      expect(
        GreetingHelper.getFullGreeting(
          name: 'Ameen',
          dateTime: DateTime(2026, 8, 9, 19, 0),
        ),
        'Good Evening, Ameen',
      );
      expect(
        GreetingHelper.getFullGreeting(
          name: 'Ameen',
          dateTime: DateTime(2026, 8, 9, 22, 0),
        ),
        'Good Night, Ameen',
      );
      expect(
        GreetingHelper.getFullGreeting(
          name: null,
          dateTime: DateTime(2026, 8, 9, 10, 0),
        ),
        'Good Morning, Student',
      );
    });
  });

  group('HomeScreen Dynamic Greeting Widget Tests', () {
    testWidgets('Renders registered user name dynamically in HomeScreen', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final storage = StorageService();
      await storage.saveLoggedInUser(
        UserModel(
          id: 'u-101',
          fullName: 'Ziyan',
          email: 'ziyan@campus.edu',
          password: 'Password123',
          department: 'Computer Science',
        ),
      );

      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify the user name "Ziyan" is rendered
      expect(find.text('Ziyan'), findsOneWidget);

      // Verify time-based greeting prefix is rendered
      final expectedGreeting = GreetingHelper.getGreetingPrefix();
      expect(find.text('$expectedGreeting 👋'), findsOneWidget);
    });

    testWidgets('Falls back to "Student" if user is not logged in', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Student'), findsOneWidget);
      final expectedGreeting = GreetingHelper.getGreetingPrefix();
      expect(find.text('$expectedGreeting 👋'), findsOneWidget);
    });
  });
}
