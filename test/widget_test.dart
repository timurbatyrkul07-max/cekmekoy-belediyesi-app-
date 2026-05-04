import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cekmekoy_app/main.dart';

void main() {
  testWidgets('App boots without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: CekmekoyApp()));
    await tester.pump();
    expect(find.text('Hızlı İşlemler'), findsOneWidget);
  });
}
