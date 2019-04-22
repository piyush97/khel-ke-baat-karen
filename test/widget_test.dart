import 'package:flutter_test/flutter_test.dart';

import 'package:khel_ke_baat_karen/main.dart';

void main() {
  testWidgets('K2BK Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
  });
}
