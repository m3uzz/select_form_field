import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:select_form_field/select_form_field.dart';

void main() {
  testWidgets('Testing instantiate SelectFormField',
      (WidgetTester tester) async {
    var myWidget = MyWidget();
    await tester.pumpWidget(myWidget);

    expect(
      find.text('test'),
      findsOneWidget,
      reason: 'SelectFormField value not found!',
    );
    var selectField = find.byType(SelectFormField);
    expect(
      selectField,
      findsOneWidget,
      reason: 'SelectFormField not found!',
    );
    expect(
      find.text('Circle Label'),
      findsOneWidget,
      reason: 'SelectFormField initial label value not found!',
    );

    await tester.tap(selectField);
    await tester.pumpAndSettle();

    var boxLabel = find.text('Box Label');
    expect(
      boxLabel,
      findsOneWidget,
      reason: 'SelectFormField Box option not displayed on dialog!',
    );
    expect(
      find.text('Star Label'),
      findsOneWidget,
      reason: 'SelectFormField Star option not displayed on dialog!',
    );

    var item = find.ancestor(
      of: boxLabel,
      matching: find.byType(InkWell),
    );
    expect(
      item,
      findsOneWidget,
      reason: 'SelectFormField InkWell not found!',
    );

    await tester.tap(item);
    await tester.pumpAndSettle();

    expect(
      find.text('Box Label'),
      findsOneWidget,
      reason: 'SelectFormField Box not selected!',
    );
    expect(
      find.text('boxValue'),
      findsOneWidget,
      reason: 'SelectFormField value result not changed!',
    );
  });
}

class MyWidget extends StatefulWidget {
  MyWidget({Key key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String _value = 'test';

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'boxValue',
      'label': 'Box Label',
      'icon': Icon(Icons.stop),
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label',
      'icon': Icon(Icons.fiber_manual_record),
      'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'starValue',
      'label': 'Star Label',
      'enable': false,
      'icon': Icon(Icons.grade),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SelectFormField(
              initialValue: 'circleValue',
              icon: Icon(Icons.format_shapes),
              labelText: 'Shape',
              items: _items,
              onChanged: (val) => setState(() => _value = val),
            ),
            Text(_value),
          ],
        ),
      ),
    );
  }
}
