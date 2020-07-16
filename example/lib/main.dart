import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SelectFormField Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter SelectFormField Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Form(
          child: Column(
            children: <Widget>[
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
      ),
    );
  }
}
