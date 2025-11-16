import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class ShamsiDatePickerField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final Function(Jalali)? onDateSelected;

  const ShamsiDatePickerField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.onDateSelected,
  }) : super(key: key);

  @override
  _ShamsiDatePickerFieldState createState() => _ShamsiDatePickerFieldState();
}

class _ShamsiDatePickerFieldState extends State<ShamsiDatePickerField> {
  Future<void> _selectDate(BuildContext context) async {
    final Jalali initialDate = Jalali.now();
    final Jalali? picked = await showDatePicker(
      context: context,
      initialDate: initialDate.toDateTime(),
      firstDate: DateTime(1300, 1, 1),
      lastDate: DateTime(1450, 12, 29),
      // Note: Flutter's default date picker is Gregorian.
      // For a true Shamsi calendar picker UI, a custom package would be needed.
      // For now, we use the default picker and convert the result.
      // The user can still navigate through months and years.
    ).then((gregorianDate) {
      if (gregorianDate == null) return null;
      return Jalali.fromDateTime(gregorianDate);
    });

    if (picked != null) {
      setState(() {
        final f = picked.formatter;
        widget.controller.text = '${f.yyyy}/${f.mm}/${f.dd}';
        if (widget.onDateSelected != null) {
          widget.onDateSelected!(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onTap: () => _selectDate(context),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'لطفا تاریخ را انتخاب کنید';
        }
        return null;
      },
    );
  }
}
