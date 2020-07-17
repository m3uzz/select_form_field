import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SelectFormField Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller;
  //String _initialValue;
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
  void initState() {
    super.initState();

    //_initialValue = 'starValue';
    _controller = TextEditingController(text: 'starValue');

    _getValue();
  }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = 'circleValue';
        _controller.text = 'circleValue';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter SelectFormField Demo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Form(
          child: Column(
            children: <Widget>[
              SelectFormField(
                controller: _controller,
                //initialValue: _initialValue,
                icon: Icon(Icons.format_shapes),
                labelText: 'Shape',
                items: _items,
                onChanged: (val) => setState(() => _value = val),
                onSaved: (val) => setState(() => _value = val),
              ),
              SizedBox(height: 30),
              Text(
                'SelectFormField data value:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(_value),
            ],
          ),
        ),
      ),
    );
  }
}
