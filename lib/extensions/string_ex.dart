import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';

class CapitalizeTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toCapitalized(),
      selection: newValue.selection,
    );
  }
}
