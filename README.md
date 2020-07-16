# select_form_field

[![pub package](https://img.shields.io/pub/v/select_form_field.svg)](https://pub.dartlang.org/packages/select_form_field)

A Flutter select field widget. It shows a list of options in a dropdown menu.
This widget extend TextField and has a similar bihavior as TextFormField

## Usage

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  select_form_field: "^0.1.1"
```

In your library add the following import:

```dart
import 'package:select_form_field/select_form_field.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

### Exemple

Set items using a List map passing:
* `value`: [String], 
* `textStyle`: [TextStyle | null],
* `label`: [String | null], 
* `icon`: [Widget | null],
* `enable`: [bool | null],

``` dart
final List<Map<String, dynamic>> _items = [
  {
    'value': 'box',
    'label': 'Box',
    'icon': Icon(Icons.stop),
  },
  {
    'value': 'circle',
    'label': 'Circle',
    'icon': Icon(Icons.fiber_manual_record),
    'textStyle': TextStyle(color: Colors.red),
  },
  {
    'value': 'star',
    'label': 'Star',
    'enable': false,
    'icon': Icon(Icons.grade),
  },
];
```

``` dart
SelectFormField(
  initialValue: 'circle',
  icon: Icon(Icons.format_shapes),
  labelText: 'Shape',
  items: _items,
  onChanged: (val) => print(val),
  onSaved: (val) => print(val),
);
```

![Overview](https://raw.githubusercontent.com/m3uzz/select_form_field/master/doc/images/select_form_field.png)
