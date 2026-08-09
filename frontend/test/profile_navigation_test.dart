import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/config/app_routes.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/profile/about_koode_screen.dart';
import 'package:frontend/screens/profile/privacy_policy_screen.dart';
import 'package:frontend/screens/profile/profile_screen.dart';
import 'package:frontend/services/storage_service.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final storage = StorageService();
    await storage.saveLoggedInUser(
      UserModel(
        id: 'u1',
        fullName: 'Test Student',
        email: 'student@campus.edu',
        password: 'Password123',
        department: 'Computer Science',
        yearSemester: 'Year 3 / Semester 5',
        studentId: 'STU12345',
      ),
    );
  });

  testWidgets('Privacy Policy screen renders all core sections', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PrivacyPolicyScreen(),
      ),
    );

    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Koode Privacy Policy'), findsOneWidget);
    expect(find.text('1. Introduction'), findsOneWidget);
    expect(find.text('2. Information We Collect'), findsOneWidget);
    expect(find.text('12. Contact Us'), findsOneWidget);
  });

  testWidgets('About Koode screen renders branding and purpose', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutKoodeScreen(),
      ),
    );

    expect(find.text('About Koode'), findsOneWidget);
    expect(find.text('Koode'), findsOneWidget);
    expect(find.text('What is Koode?'), findsOneWidget);
    expect(find.text('Our Purpose'), findsOneWidget);
    expect(find.text('App Ownership & Credits'), findsOneWidget);
    expect(find.text('Version 1.0.0 (Build 1)'), findsOneWidget);
  });

  testWidgets('Profile screen navigates to Privacy Policy and About Koode', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.home,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.privacyPolicy) {
            return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
          }
          if (settings.name == AppRoutes.aboutKoode) {
            return MaterialPageRoute(builder: (_) => const AboutKoodeScreen());
          }
          return MaterialPageRoute(builder: (_) => const ProfileScreen());
        },
      ),
    );

    await tester.pumpAndSettle();

    // Verify Profile loaded
    expect(find.text('Test Student'), findsOneWidget);

    // Tap Privacy Policy
    await tester.ensureVisible(find.text('Privacy Policy'));
    await tester.tap(find.text('Privacy Policy'));
    await tester.pumpAndSettle();

    expect(find.text('Koode Privacy Policy'), findsOneWidget);

    // Pop back to Profile
    await tester.tap(find.byTooltip('Back to Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Test Student'), findsOneWidget);

    // Tap About Koode
    await tester.ensureVisible(find.text('About Koode'));
    await tester.tap(find.text('About Koode'));
    await tester.pumpAndSettle();

    expect(find.text('What is Koode?'), findsOneWidget);
  });
}
