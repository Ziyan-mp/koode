import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/app/app.dart';

void main() {
  testWidgets('Koode app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const KoodeApp());

    // Verify that the tagline text is present.
    expect(find.text('Your Voice, Your Campus'), findsOneWidget);
  });
}
