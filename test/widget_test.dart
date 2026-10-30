import 'package:evently_app_c13_sun_7_pm/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App load test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}
