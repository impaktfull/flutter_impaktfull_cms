import 'package:flutter_test/flutter_test.dart';
import 'package:impaktfull_cms_example/app.dart';

void main() {
  testWidgets('Noop', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}
