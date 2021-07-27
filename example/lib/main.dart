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
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController? _controller;
  //String _initialValue;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'boxValue',
      'label': 'Box Label',
      'icon': Icon(Icons.stop),
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label Loooooooooooooooooooong text',
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

  /*final List<Map<String, dynamic>> _items = [
    {'value': 1},
    {'value': 2},
    {'value': 3},
    {'value': 4},
    {'value': 5},
    {'value': 6},
    {'value': 7},
    {'value': 8},
    {'value': 9},
    {'value': 10},
    {'value': 11},
    {'value': 12},
    {'value': 13},
    {'value': 14},
    {'value': 15},
    {'value': 16},
    {'value': 17},
    {'value': 18},
    {'value': 19},
    {'value': 20},
    {'value': 21},
    {'value': 22},
    {'value': 23},
    {'value': 24},
    {'value': 25},
    {'value': 26},
    {'value': 27},
    {'value': 28},
    {'value': 29},
    {'value': 30},
    {'value': 31},
  ];*/

  @override
  void initState() {
    super.initState();

    //_initialValue = 'starValue';
    _controller = TextEditingController(text: '2');

    _getValue();
  }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = 'circleValue';
        _controller?.text = 'circleValue';
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
          key: _oFormKey,
          child: Column(
            children: <Widget>[
              SelectFormField(
                type: SelectFormFieldType.dialog,
                controller: _controller,
                //initialValue: _initialValue,
                icon: Icon(Icons.format_shapes),
                labelText: 'Shape',
                changeIcon: true,
                dialogTitle: 'Pick a item',
                dialogCancelBtn: 'CANCEL',
                enableSearch: true,
                dialogSearchHint: 'Search item',
                items: _items,
                onChanged: (val) => setState(() => _valueChanged = val),
                validator: (val) {
                  setState(() => _valueToValidate = val ?? '');
                  return null;
                },
                onSaved: (val) => setState(() => _valueSaved = val ?? ''),
              ),
              SizedBox(height: 30),
              Text(
                'SelectFormField data value onChanged:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SelectableText(_valueChanged),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final loForm = _oFormKey.currentState;

                  if (loForm?.validate() == true) {
                    loForm?.save();
                  }
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 30),
              Text(
                'SelectFormField data value validator:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SelectableText(_valueToValidate),
              SizedBox(height: 30),
              Text(
                'SelectFormField data value onSaved:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SelectableText(_valueSaved),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final loForm = _oFormKey.currentState;
                  loForm?.reset();

                  setState(() {
                    _valueChanged = '';
                    _valueToValidate = '';
                    _valueSaved = '';
                    _controller?.clear();
                  });
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
