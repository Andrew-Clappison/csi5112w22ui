import 'package:csi5112w22ui/counterlec3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('counterlec3 ...', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.exposure_plus_1));
    await tester.pump();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNWidgets(1));

    Widget textWid =
        find.byKey(const Key('key_text_num')).evaluate().single.widget;
    textWid.toString();

    await tester.tap(find.byIcon(Icons.save));
    await tester.pump();

    String? data = (textWid as Text).data;
    expect(find.text(data ?? ''), findsNWidgets(2));
  });
}
