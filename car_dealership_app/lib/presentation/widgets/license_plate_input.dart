import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LicensePlateInput extends StatefulWidget {
  final Function(String) onPlateChanged;

  const LicensePlateInput({Key? key, required this.onPlateChanged}) : super(key: key);

  @override
  _LicensePlateInputState createState() => _LicensePlateInputState();
}

class _LicensePlateInputState extends State<LicensePlateInput> {
  final _part1Controller = TextEditingController();
  final _part3Controller = TextEditingController();
  final _part4Controller = TextEditingController();

  String? _selectedLetter = 'الف';
  final List<String> _alphabet = [
    'الف', 'ب', 'پ', 'ت', 'ث', 'ج', 'چ', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'ژ', 'س', 'ش',
    'ص', 'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ک', 'گ', 'ل', 'م', 'ن', 'و', 'ه', 'ی'
  ];

  @override
  void initState() {
    super.initState();
    _part1Controller.addListener(_updatePlate);
    _part3Controller.addListener(_updatePlate);
    _part4Controller.addListener(_updatePlate);
  }

  void _updatePlate() {
    final plate =
        'ایران ${_part4Controller.text} - ${_part3Controller.text} ${_selectedLetter ?? ''} ${_part1Controller.text}';
    widget.onPlateChanged(plate);
  }

  @override
  void dispose() {
    _part1Controller.dispose();
    _part3Controller.dispose();
    _part4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'پلاک خودرو',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('ایران'),
            _buildTextField(_part4Controller, 2),
            const Text('-'),
            _buildTextField(_part3Controller, 3),
            _buildDropdown(),
            _buildTextField(_part1Controller, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, int length) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        maxLength: length,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          counterText: '',
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButton<String>(
      value: _selectedLetter,
      items: _alphabet.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedLetter = newValue;
          _updatePlate();
        });
      },
    );
  }
}
