import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // 1. Get the new text value and remove any non-digit characters.
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // 2. Parse the number.
    double value = double.parse(newText);

    // 3. Format the number with thousand separators.
    final formatter = NumberFormat.decimalPattern('fa_IR');
    String formattedText = formatter.format(value);

    // 4. Return the new TextEditingValue with the formatted text.
    // The cursor is moved to the end of the formatted text.
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
