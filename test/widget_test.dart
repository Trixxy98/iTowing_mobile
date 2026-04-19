import 'package:flutter_test/flutter_test.dart';

import 'package:towing_apps/main.dart';

void main() {
  testWidgets('App shows splash branding', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    expect(find.text('TowingKu'), findsOneWidget);
    // SplashScreen schedules navigation after 3s — advance time so no timer is left pending.
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
  });
}
