import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:select_form_field/select_form_field.dart';

void main() {
  testWidgets('Instantiate SelectFormField', (WidgetTester tester) async {
    var myWidget = MyWidget();
    await tester.pumpWidget(myWidget);

    var selectField = find.byType(SelectFormField);
    expect(
      selectField,
      findsOneWidget,
      reason: 'SelectFormField not found!',
    );
    expect(
      find.text('Circle Label'),
      findsOneWidget,
      reason: 'Initial label value wrong!',
    );
    await tester.tap(selectField);
    await tester.pump();
    var boxLabel = find.text('Box Label');
    expect(
      boxLabel,
      findsOneWidget,
      reason: 'Box option wrong!',
    );
    expect(
      find.text('Star Label'),
      findsOneWidget,
      reason: 'Star option wrong!',
    );
    await tester.tap(boxLabel);
    expect(
      find.text('Box Label'),
      findsOneWidget,
      reason: 'Box not selected!',
    );
  });
}

class MyWidget extends StatefulWidget {
  MyWidget({Key key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String _value = '';

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
              onSaved: (val) => setState(() => _value = val),
            ),
            Text(_value),
          ],
        ),
      ),
    );
  }
}
