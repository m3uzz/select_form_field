// Copyright 2014 The m3uzz Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library select_form_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    Key key,
    this.controller,
    this.icon,
    this.labelText,
    this.hintText,
    this.items,
    String initialValue,
    FocusNode focusNode,
    InputDecoration decoration,
    TextInputType keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction,
    TextStyle style,
    StrutStyle strutStyle,
    TextDirection textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions toolbarOptions,
    bool showCursor,
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType smartDashesType,
    SmartQuotesType smartQuotesType,
    bool enableSuggestions = true,
    bool autovalidate = false,
    bool maxLengthEnforced = true,
    int maxLines = 1,
    int minLines,
    bool expands = false,
    int maxLength,
    this.onChanged,
    //GestureTapCallback onTap,
    VoidCallback onEditingComplete,
    ValueChanged<String> onFieldSubmitted,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatters,
    bool enabled = true,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    Color cursorColor,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder buildCounter,
    ScrollPhysics scrollPhysics,
  })  : assert(initialValue == null || controller == null),
        assert(items != null),
        assert(textAlign != null),
        assert(autofocus != null),
        assert(readOnly != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(enableSuggestions != null),
        assert(autovalidate != null),
        assert(maxLengthEnforced != null),
        assert(scrollPadding != null),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(expands != null),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(
          !obscureText || maxLines == 1,
          'Obscured fields cannot be multiline.',
        ),
        assert(maxLength == null || maxLength > 0),
        assert(enableInteractiveSelection != null),
        super(
          key: key,
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          enabled: enabled,
          builder: (FormFieldState<String> field) {
            final _SelectFormFieldState state = field as _SelectFormFieldState;

            final InputDecoration effectiveDecoration = (decoration ??
                InputDecoration(
                  labelText: labelText,
                  icon: icon,
                  hintText: hintText,
                  suffixIcon: Container(
                    width: 10,
                    margin: EdgeInsets.all(0),
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 15),
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
              maxLengthEnforced: maxLengthEnforced,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              maxLength: maxLength,
              onChanged: onChangedHandler,
              onTap: readOnly ? null : state._showSelectFormFieldMenu,
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
          },
        );

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController controller;

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
  final Widget icon;

  /// Text that describes the input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on
  /// top of the input field (i.e., at the same location on the screen where
  /// text may be entered in the input field). When the input field receives
  /// focus (or if the field is non-empty), the label moves above (i.e.,
  /// vertically adjacent to) the input field.
  final String labelText;

  /// Text that suggests what sort of input the field accepts.
  ///
  /// Displayed on top of the input [child] (i.e., at the same location on the
  /// screen where text may be entered in the input [child]) when the input
  /// [isEmpty] and either (a) [labelText] is null or (b) the input has the focus.
  final String hintText;

  final ValueChanged<String> onChanged;

  /// A list map of items to show on a dropdown menu to select.
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
  final List<Map<String, dynamic>> items;

  @override
  _SelectFormFieldState createState() => _SelectFormFieldState();
}

class _SelectFormFieldState extends FormFieldState<String> {
  TextEditingController _labelController = TextEditingController();
  TextEditingController _valueController;
  Map<String, dynamic> _item;

  @override
  SelectFormField get widget => super.widget as SelectFormField;

  TextEditingController get _effectiveController =>
      widget.controller ?? _valueController;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _valueController = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }

    _item = widget.items.firstWhere(
      (lmItem) => lmItem['value'] == _effectiveController.text,
      orElse: () => widget.items[0],
    );
    _labelController.text = _item['label'];
  }

  @override
  void didUpdateWidget(SelectFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _valueController =
            TextEditingController.fromValue(oldWidget.controller.value);
      }

      if (widget.controller != null) {
        setValue(widget.controller.text);

        if (oldWidget.controller == null) {
          _valueController = null;
        }
      }
    }

    _item = widget.items.firstWhere(
      (lmItem) => lmItem['value'] == _effectiveController.text,
      orElse: () => widget.items[0],
    );
    _labelController.text = _item['label'];
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
      _effectiveController.text = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  void onChangedHandler(String value) {
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }

    didChange(value);
  }

  Future<void> _showSelectFormFieldMenu() async {
    String lvItemPicked = await showMenu<dynamic>(
      context: context,
      position: _buttonMenuPosition(context),
      initialValue: value,
      items: _renderItems(),
    );

    if (lvItemPicked != null && lvItemPicked != value) {
      _item = widget.items
          .firstWhere((lmItem) => lmItem['value'] == _effectiveController.text);
      _labelController.text = _item['label'];

      _effectiveController.text = lvItemPicked;
      onChangedHandler(lvItemPicked);
    }
  }

  List<PopupMenuEntry<String>> _renderItems() {
    List<PopupMenuItem<String>> llItems = <PopupMenuItem<String>>[];

    widget.items.forEach((lmElement) {
      PopupMenuItem<String> loItem = PopupMenuItem<String>(
        value: lmElement['value'],
        enabled: lmElement['enable'] ?? true,
        textStyle: lmElement['textStyle'] ?? lmElement['textStyle'],
        child: Row(
          children: [
            lmElement['icon'] ?? SizedBox(width: 5),
            Text(lmElement['label'] ?? lmElement['value']),
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
        Overlay.of(poContext).context.findRenderObject() as RenderBox;
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
