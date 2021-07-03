// Copyright 2014 The m3uzz Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library select_form_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum SelectFormFieldType { dropdown, dialog }

/// A [SelectFormField] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [SelectFormField].
///
/// A [Form] ancestor is not required. The [Form] simply makes it easier to
/// save, reset, or validate multiple fields at once. To use without a [Form],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the form field.
///
/// When a [controller] is specified, its [TextEditingController.text]
/// defines the [initialValue]. If this [FormField] is part of a scrolling
/// container that lazily constructs its children, like a [ListView] or a
/// [CustomScrollView], then a [controller] should be specified.
/// The controller's lifetime should be managed by a stateful widget ancestor
/// of the scrolling container.
///
/// If a [controller] is not specified, [initialValue] can be used to give
/// the automatically generated controller an initial value.
///
/// Remember to [dispose] of the [TextEditingController] when it is no longer needed.
/// This will ensure we discard any resources used by the object.
///
/// For a documentation about the various parameters, see [TextField].
///
/// {@tool snippet}
///
/// Creates a [SelectFormField] with an [InputDecoration] and validator function.
///
/// ![If the user enters valid text, the TextField appears normally without any warnings to the user](https://flutter.github.io/assets-for-api-docs/assets/material/text_form_field.png)
///
/// ![If the user enters invalid text, the error message returned from the validator function is displayed in dark red underneath the input](https://flutter.github.io/assets-for-api-docs/assets/material/text_form_field_error.png)
///
/// ```dart
/// SelectFormField(
///   decoration: const InputDecoration(
///     icon: Icon(Icons.person),
///     hintText: 'What do people call you?',
///     labelText: 'Name *',
///   ),
///   onSaved: (String value) {
///     // This optional block of code can be used to run
///     // code when the user saves the form.
///   },
///   validator: (String value) {
///     return value.contains('@') ? 'Do not use the @ char.' : null;
///   },
/// )
/// ```
/// {@end-tool}
///
/// {@tool dartpad --template=stateful_widget_material}
/// This example shows how to move the focus to the next field when the user
/// presses the ENTER key.
///
/// ```dart imports
/// import 'package:flutter/services.dart';
/// ```
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Material(
///     child: Center(
///       child: Shortcuts(
///         shortcuts: <LogicalKeySet, Intent>{
///           // Pressing enter on the field will now move to the next field.
///           LogicalKeySet(LogicalKeyboardKey.enter):
///               Intent(NextFocusAction.key),
///         },
///         child: FocusTraversalGroup(
///           child: Form(
///             autovalidate: true,
///             onChanged: () {
///               Form.of(primaryFocus.context).save();
///             },
///             child: Wrap(
///               children: List<Widget>.generate(5, (int index) {
///                 return Padding(
///                   padding: const EdgeInsets.all(8.0),
///                   child: ConstrainedBox(
///                     constraints: BoxConstraints.tight(Size(200, 50)),
///                     child: SelectFormField(
///                       onSaved: (String value) {
///                         print('Value for field $index saved as "$value"');
///                       },
///                     ),
///                   ),
///                 );
///               }),
///             ),
///           ),
///         ),
///       ),
///     ),
///   );
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * <https://material.io/design/components/text-fields.html>
///  * [TextField], which is the underlying text field without the [Form]
///    integration.
///  * [InputDecorator], which shows the labels and other visual elements that
///    surround the actual text editing widget.
///  * Learn how to use a [TextEditingController] in one of our [cookbook recipe]s.(https://flutter.dev/docs/cookbook/forms/text-field-changes#2-use-a-texteditingcontroller)
class SelectFormField extends FormField<String> {
  /// Creates a [SelectFormField] that contains a [TextField].
  ///
  /// When a [controller] is specified, [initialValue] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initialValue] or the empty string.
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [new TextField], the constructor.
  SelectFormField({
    Key? key,
    this.type = SelectFormFieldType.dropdown,
    this.controller,
    this.icon,
    this.changeIcon = false,
    this.labelText,
    this.hintText,
    this.dialogTitle,
    this.dialogSearchHint,
    this.dialogCancelBtn,
    this.enableSearch = false,
    this.items,
    String? initialValue,
    FocusNode? focusNode,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    bool autovalidate = false,
    bool maxLengthEnforced = true,
    int maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    this.onChanged,
    //GestureTapCallback onTap,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    double cursorWidth = 2.0,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
  })  : assert(initialValue == null || controller == null),
        assert(maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || minLines == null,
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(
          !obscureText || maxLines == 1,
          'Obscured fields cannot be multiline.',
        ),
        assert(maxLength == null || maxLength > 0),
        super(
          key: key,
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          onSaved: onSaved,
          validator: validator,
          //autovalidate: autovalidate,
          enabled: enabled,
          builder: (FormFieldState<String> field) {
            final _SelectFormFieldState state = field as _SelectFormFieldState;

            final InputDecoration effectiveDecoration = (decoration ??
                InputDecoration(
                  labelText: labelText,
                  icon: state._icon ?? icon,
                  hintText: hintText,
                  suffixIcon: Container(
                    width: 10,
                    margin: EdgeInsets.all(0),
                    child: TextButton(
                      onPressed: () {},
                      child: Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ));
            effectiveDecoration.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );

            void onChangedHandler(String value) {
              if (onChanged != null) {
                onChanged(value);
              }
              field.didChange(value);
            }

            Widget buildField(SelectFormFieldType peType) {
              var lfOnTap;

              if (readOnly == false) {
                switch (peType) {
                  case SelectFormFieldType.dialog:
                    lfOnTap = state._showSelectFormFieldDialog;
                    break;
                  default:
                    lfOnTap = state._showSelectFormFieldMenu;
                }
              }

              return TextField(
                controller: state._labelController,
                focusNode: focusNode,
                decoration: effectiveDecoration.copyWith(
                  errorText: field.errorText,
                ),
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                style: style,
                strutStyle: strutStyle,
                textAlign: textAlign,
                textAlignVertical: textAlignVertical,
                textDirection: textDirection,
                textCapitalization: textCapitalization,
                autofocus: autofocus,
                toolbarOptions: toolbarOptions,
                readOnly: true,
                showCursor: showCursor,
                obscureText: obscureText,
                autocorrect: autocorrect,
                smartDashesType: smartDashesType ??
                    (obscureText
                        ? SmartDashesType.disabled
                        : SmartDashesType.enabled),
                smartQuotesType: smartQuotesType ??
                    (obscureText
                        ? SmartQuotesType.disabled
                        : SmartQuotesType.enabled),
                enableSuggestions: enableSuggestions,
                //maxLengthEnforced: maxLengthEnforced,
                maxLines: maxLines,
                minLines: minLines,
                expands: expands,
                maxLength: maxLength,
                onChanged: onChangedHandler,
                onTap: readOnly ? null : lfOnTap,
                onEditingComplete: onEditingComplete,
                onSubmitted: onFieldSubmitted,
                inputFormatters: inputFormatters,
                enabled: enabled,
                cursorWidth: cursorWidth,
                cursorRadius: cursorRadius,
                cursorColor: cursorColor,
                scrollPadding: scrollPadding,
                scrollPhysics: scrollPhysics,
                keyboardAppearance: keyboardAppearance,
                enableInteractiveSelection: enableInteractiveSelection,
                buildCounter: buildCounter,
              );
            }

            switch (type) {
              case SelectFormFieldType.dialog:
                return buildField(SelectFormFieldType.dialog);
              default:
                return buildField(SelectFormFieldType.dropdown);
            }
          },
        );

  /// The SelectFormField type:
  /// [dropdown] or [dialog].
  final SelectFormFieldType type;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController? controller;

  /// An icon to show before the input field and outside of the decoration's
  /// container.
  ///
  /// The size and color of the icon is configured automatically using an
  /// [IconTheme] and therefore does not need to be explicitly given in the
  /// icon widget.
  ///
  /// The trailing edge of the icon is padded by 16dps.
  ///
  /// The decoration's container is the area which is filled if [filled] is
  /// true and bordered per the [border]. It's the area adjacent to
  /// [decoration.icon] and above the widgets that contain [helperText],
  /// [errorText], and [counterText].
  ///
  /// See [Icon], [ImageIcon].
  final Widget? icon;

  /// If true and the item list has icon property, when one item is selected the
  /// field icon will be changed as well.
  ///
  /// Default is false.
  final bool changeIcon;

  /// Text that describes the input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on
  /// top of the input field (i.e., at the same location on the screen where
  /// text may be entered in the input field). When the input field receives
  /// focus (or if the field is non-empty), the label moves above (i.e.,
  /// vertically adjacent to) the input field.
  final String? labelText;

  /// Text that suggests what sort of input the field accepts.
  ///
  /// Displayed on top of the input [child] (i.e., at the same location on the
  /// screen where text may be entered in the input [child]) when the input
  /// [isEmpty] and either (a) [labelText] is null or (b) the input has the focus.
  final String? hintText;

  /// The title of the dialog window.
  final String? dialogTitle;

  /// The search field hint text
  final String? dialogSearchHint;

  /// The cancel button label on dialog
  final String? dialogCancelBtn;

  /// Param to set search feature. The default value is true.
  ///
  /// If enable, an icon button will be displayed on top right of the dialog
  /// window to show a text field to type the icon name to search of.
  final bool enableSearch;

  final ValueChanged<String>? onChanged;

  /// A list map of items to show as options to select.
  ///
  /// or a list map as below:
  ///
  /// ```dart
  ///final List<Map<String, dynamic>> _items = [
  ///  {
  ///    'value': 'box',
  ///    'label': 'Box',
  ///    'icon': Icon(Icons.stop),
  ///  },
  ///  {
  ///    'value': 'circle',
  ///    'label': 'Circle',
  ///    'icon': Icon(Icons.fiber_manual_record),
  ///    'textStyle': TextStyle(color: Colors.red),
  ///  },
  ///  {
  ///    'value': 'star',
  ///    'label': 'Star',
  ///    'enable': false,
  ///    'icon': Icon(Icons.grade),
  ///  },
  ///  ...
  /// ];
  /// ```
  final List<Map<String, dynamic>>? items;

  @override
  _SelectFormFieldState createState() => _SelectFormFieldState();
}

class _SelectFormFieldState extends FormFieldState<String> {
  TextEditingController _labelController = TextEditingController();
  TextEditingController? _stateController;
  Widget? _icon;
  Map<String, dynamic>? _item;

  @override
  SelectFormField get widget => super.widget as SelectFormField;

  TextEditingController? get _effectiveController =>
      widget.controller ?? _stateController;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _stateController = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller?.addListener(_handleControllerChanged);
    }

    if (_effectiveController?.text != null &&
        _effectiveController?.text != '') {
      _item = widget.items?.firstWhere(
        (lmItem) => lmItem['value'].toString() == _effectiveController?.text,
      );

      if (_item != null) {
        _labelController.text = _item?['label'];

        if (widget.changeIcon &&
            _item?['icon'] != null &&
            _item?['icon'] != '') {
          _icon = _item?['icon'];
        }
      }
    }
  }

  @override
  void didUpdateWidget(SelectFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _stateController =
            TextEditingController.fromValue(oldWidget.controller?.value);
      }

      if (widget.controller != null) {
        setValue(widget.controller?.text);

        if (oldWidget.controller == null) {
          _stateController = null;
        }
      }
    }

    if (_effectiveController?.text != null &&
        _effectiveController?.text != '') {
      _item = widget.items?.firstWhere(
        (lmItem) => lmItem['value'] == _effectiveController?.text,
      );

      if (_item != null) {
        _labelController.text = _item?['label'];

        if (widget.changeIcon &&
            _item?['icon'] != null &&
            _item?['icon'] != '') {
          _icon = _item?['icon'];
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);

    super.dispose();
  }

  @override
  void reset() {
    super.reset();

    setState(() {
      _effectiveController?.text = widget.initialValue ?? '';
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController?.text != value) {
      didChange(_effectiveController?.text);
    }
  }

  void onChangedHandler(String? value) {
    if (value == null) return;
    widget.onChanged?.call(value);

    didChange(value);
  }

  Future<void> _showSelectFormFieldMenu() async {
    String lvPicked = await showMenu<dynamic>(
      context: context,
      position: _buttonMenuPosition(context),
      initialValue: value,
      items: _renderItems(),
    );

    if (lvPicked != value) {
      _item = widget.items?.firstWhere(
        (lmItem) => lmItem['value'] == lvPicked,
      );

      if (_item != null) {
        _labelController.text = _item?['label'];
        _effectiveController?.text = lvPicked.toString();

        if (widget.changeIcon &&
            _item?['icon'] != null &&
            _item?['icon'] != '') {
          setState(() {
            _icon = _item?['icon'];
          });
        }

        onChangedHandler(lvPicked.toString());
      }
    }
  }

  Future<void> _showSelectFormFieldDialog() async {
    Map<String, dynamic> lvPicked = await showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return ItemPickerDialog(
          widget.dialogTitle,
          widget.items,
          widget.enableSearch,
          widget.dialogSearchHint,
          widget.dialogCancelBtn,
        );
      },
    );

    if (lvPicked is Map<String, dynamic>) {
      _labelController.text = lvPicked['label'];
      _effectiveController?.text = lvPicked['value'].toString();

      if (widget.changeIcon &&
          lvPicked['icon'] != null &&
          lvPicked['icon'] != '') {
        setState(() {
          _icon = lvPicked['icon'];
        });
      }

      onChangedHandler(lvPicked['value'].toString());
    }
  }

  List<PopupMenuEntry<String>> _renderItems() {
    List<PopupMenuItem<String>> llItems = <PopupMenuItem<String>>[];

    widget.items?.forEach((lmElement) {
      PopupMenuItem<String> loItem = PopupMenuItem<String>(
        value: lmElement['value'],
        enabled: lmElement['enable'] ?? true,
        textStyle: lmElement['textStyle'] ?? lmElement['textStyle'],
        child: Row(
          children: [
            lmElement['icon'] ?? SizedBox(width: 5),
            Expanded(
              child: Text(
                lmElement['label'] ?? lmElement['value'],
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ],
        ),
      );

      llItems.add(loItem);
    });

    return llItems;
  }

  RelativeRect _buttonMenuPosition(BuildContext poContext) {
    final RenderBox loBar = poContext.findRenderObject() as RenderBox;
    final RenderBox loOverlay =
        Overlay.of(poContext)?.context.findRenderObject() as RenderBox;
    const Offset loOffset = Offset.zero;

    final RelativeRect loPosition = RelativeRect.fromRect(
      Rect.fromPoints(
        loBar.localToGlobal(
          loBar.size.centerRight(loOffset),
          ancestor: loOverlay,
        ),
        loBar.localToGlobal(
          loBar.size.centerRight(loOffset),
          ancestor: loOverlay,
        ),
      ),
      loOffset & loOverlay.size,
    );

    return loPosition;
  }
}

class ItemPickerDialog extends StatefulWidget {
  final String? title;
  final String? searchHint;
  final String? cancelBtn;
  final List<Map<String, dynamic>>? items;
  final bool enableSearch;

  ItemPickerDialog(
    this.title,
    this.items, [
    this.enableSearch = true,
    this.searchHint = '',
    this.cancelBtn,
  ]);

  @override
  _ItemPickerDialogState createState() => new _ItemPickerDialogState();
}

class _ItemPickerDialogState extends State<ItemPickerDialog> {
  TextEditingController _oCtrlSearchQuery = TextEditingController();
  List<Map<String, dynamic>> _lItemListShow = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _lItemListOriginal = <Map<String, dynamic>>[];
  int _iQtItems = -1;

  @override
  void initState() {
    super.initState();

    _oCtrlSearchQuery.addListener(_search);
    _lItemListOriginal.clear();
    _lItemListShow.clear();
    _lItemListOriginal.addAll(widget.items ?? <Map<String, dynamic>>[]);
    _lItemListShow.addAll(_lItemListOriginal);
    _iQtItems = _lItemListOriginal.length;
  }

  @override
  void dispose() {
    _oCtrlSearchQuery.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _titleDialog(),
      content: Container(
        width: double.maxFinite,
        child: _content(),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(widget.cancelBtn ?? ''),
        ),
      ],
    );
  }

  Widget _titleDialog() {
    if (!widget.enableSearch) {
      return Text(widget.title ?? '');
    }

    return Column(
      children: <Widget>[
        Text(widget.title ?? ''),
        TextField(
          controller: _oCtrlSearchQuery,
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: widget.searchHint,
            //hintStyle: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _content() {
    if (_iQtItems == -1) {
      return Center(child: CircularProgressIndicator());
    } else if (_iQtItems == 0) {
      return _showEmpty();
    }

    return ListItem(_lItemListShow);
  }

  Widget _showEmpty() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment(0, -0.5),
          child: Icon(
            Icons.category,
            size: 50,
          ),
        ),
      ],
    );
  }

  void _search() {
    String lsQuery = _oCtrlSearchQuery.text;

    if (lsQuery.length > 2) {
      lsQuery.toLowerCase();

      String lsValue;

      setState(() {
        _lItemListShow.clear();

        _lItemListOriginal.forEach((loCredential) {
          lsValue = loCredential['label'].toLowerCase();

          if (lsValue.contains(lsQuery)) {
            _lItemListShow.add(loCredential);
          }
        });

        _iQtItems = _lItemListShow.length;
      });
    } else {
      setState(() {
        _lItemListShow.clear();

        _lItemListOriginal.forEach((loCredential) {
          _lItemListShow.add(loCredential);
        });

        _iQtItems = _lItemListShow.length;
      });
    }
  }
}

class ListItem extends StatelessWidget {
  final List<Map<String, dynamic>> _lItens;

  ListItem(this._lItens);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _itemList(context),
    );
  }

  List<Widget> _itemList(context) {
    List<Widget> llItems = <Widget>[];

    _lItens.forEach((lmItem) {
      Widget loIten = ListTile(
        leading: lmItem['icon'] ?? null,
        title: Text(
          lmItem['label'] ?? lmItem['value'],
          style: lmItem['textStyle'] ?? lmItem['textStyle'],
        ),
        enabled: lmItem['enable'] ?? true,
        onTap: () => Navigator.pop(context, lmItem),
      );

      llItems.add(loIten);
    });

    return llItems;
  }
}
