import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'currency_input_formatter.dart'; // Import the formatter we just created

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? suffixText;
  final TextInputType keyboardType;
  final bool isCurrency;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.suffixText,
    this.keyboardType = TextInputType.text,
    this.isCurrency = false,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the list of formatters
    List<TextInputFormatter> formatters = inputFormatters ?? [];
    if (isCurrency) {
      formatters.add(FilteringTextInputFormatter.digitsOnly);
      formatters.add(CurrencyInputFormatter());
    } else if (keyboardType == TextInputType.number) {
      formatters.add(FilteringTextInputFormatter.digitsOnly);
    }

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixText: isCurrency ? 'تومان' : suffixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textAlign: isCurrency ? TextAlign.left : TextAlign.right,
      textDirection: isCurrency ? TextDirection.ltr : TextDirection.rtl,
    );
  }
}
