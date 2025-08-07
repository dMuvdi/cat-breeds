// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cats_app/app/domain/entities/cat.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Cat entity test', (WidgetTester tester) async {
    // Test that we can create a Cat entity
    final cat = Cat(
      id: 'test-id',
      name: 'Test Cat',
      origin: 'Test Origin',
      description: 'Test Description',
    );

    expect(cat.id, 'test-id');
    expect(cat.name, 'Test Cat');
    expect(cat.origin, 'Test Origin');
    expect(cat.description, 'Test Description');
  });
}
