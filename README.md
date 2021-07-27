# select_form_field

[![pub package](https://img.shields.io/pub/v/select_form_field.svg)](https://pub.dartlang.org/packages/select_form_field)

<a href="https://www.buymeacoffee.com/hslbetto" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-blue.png" alt="Buy Me A Beer" style="width: 150px !important;"></a>

A Flutter select field widget. It shows a list of options in a dropdown menu.\
This widget extend TextField and has a similar behavior as TextFormField

## Usage

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  select_form_field: "^2.2.0"
```

In your library add the following import:

```dart
import 'package:select_form_field/select_form_field.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

## Example

Set items using a List map passing:
* `value`: [String], 
* `textStyle`: [TextStyle | null],
* `label`: [String | null], 
* `icon`: [Widget | null],
* `enable`: [bool | null],

``` dart
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
```

``` dart
SelectFormField(
  type: SelectFormFieldType.dropdown, // or can be dialog
  initialValue: 'circle',
  icon: Icon(Icons.format_shapes),
  labelText: 'Shape',
  items: _items,
  onChanged: (val) => print(val),
  onSaved: (val) => print(val),
);
```

The result of val in `onChanged`, `validator` and `onSaved` will be a String.\
So, if you tap on Box Label item on select menu the result will be `boxValue`.

## Preview
![Overview](https://raw.githubusercontent.com/m3uzz/select_form_field/master/doc/images/select_form_field.gif)
