import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/complaints/create_complaint_screen.dart';
import 'package:frontend/screens/complaints/my_complaints_screen.dart';
import 'package:frontend/services/storage_service.dart';
import 'package:frontend/widgets/home/complaint_categories_section.dart';

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
      ),
    );
  });

  group('Complaint Categories Click & Navigation Tests', () {
    testWidgets('Direct CreateComplaintScreen has unselected category and is editable', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: CreateComplaintScreen(),
        ),
      );

      // Verify category hint is shown and value is null initially
      expect(find.text('Select category'), findsOneWidget);

      // Tap dropdown to select a category
      await tester.tap(find.text('Select category'));
      await tester.pumpAndSettle();

      // Tap 'Hostel' from dropdown list
      await tester.tap(find.text('Hostel').last);
      await tester.pumpAndSettle();

      // Verify 'Hostel' is selected
      expect(find.text('Hostel'), findsWidgets);
    });

    testWidgets('Opening CreateComplaintScreen with selectedCategory auto-populates field and is editable', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: CreateComplaintScreen(selectedCategory: 'Hostel'),
        ),
      );

      // Verify 'Hostel' is pre-populated
      expect(find.text('Hostel'), findsWidgets);
      expect(find.text('Select category'), findsNothing);

      // Change category to 'Library'
      await tester.tap(find.text('Hostel').first);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Library').last);
      await tester.pumpAndSettle();

      // Verify changed to 'Library'
      expect(find.text('Library'), findsWidgets);
    });

    const testCategories = [
      'Hostel',
      'Library',
      'Transport',
      'Classroom',
      'Laboratory',
      'Academic',
      'Electricity',
      'Water',
      'Canteen',
      'Cleanliness',
      'Sports',
      'Internet',
      'Infrastructure',
      'Others',
    ];

    for (final cat in testCategories) {
      testWidgets('Clicking category "$cat" in ComplaintCategoriesSection opens CreateComplaintScreen with "$cat"', (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: ComplaintCategoriesSection(),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Scroll and tap the category card
        final categoryFinder = find.widgetWithText(InkWell, cat);
        await tester.ensureVisible(categoryFinder);
        await tester.tap(categoryFinder);
        await tester.pumpAndSettle();

        // Verify CreateComplaintScreen opened with $cat selected
        expect(find.byType(CreateComplaintScreen), findsOneWidget);
        expect(find.text(cat), findsWidgets);
      });
    }

    testWidgets('Tapping category from MyComplaintsScreen navigates with selected category', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: MyComplaintsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Tap 'Hostel' category card on MyComplaintsScreen
      final hostelCard = find.widgetWithText(InkWell, 'Hostel');
      await tester.ensureVisible(hostelCard);
      await tester.tap(hostelCard);
      await tester.pumpAndSettle();

      // Verify CreateComplaintScreen opened with 'Hostel' preselected
      expect(find.byType(CreateComplaintScreen), findsOneWidget);
      expect(find.text('Hostel'), findsWidgets);
    });
  });
}
