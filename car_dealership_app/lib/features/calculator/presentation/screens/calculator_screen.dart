import 'package:flutter/material.dart';
import '../../../../presentation/widgets/custom_text_field.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _totalAmountController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _installmentsCountController = TextEditingController();
  final _intervalController = TextEditingController(text: '1');
  final _gracePeriodController = TextEditingController(text: '0');

  List<double> _installmentResults = [];

  void _calculateInstallments() {
    if (_formKey.currentState!.validate()) {
      final totalAmountRaw = _totalAmountController.text.replaceAll(RegExp(r'[^0-9]'), '');
      double totalAmount = double.tryParse(totalAmountRaw) ?? 0;
      final double interestRate = double.tryParse(_interestRateController.text) ?? 0;
      final int installmentsCount = int.tryParse(_installmentsCountController.text) ?? 0;
      final int graceDays = int.tryParse(_gracePeriodController.text) ?? 0;

      if (installmentsCount == 0) return;

      setState(() {
        _installmentResults = [];

        // 1. Calculate grace period interest
        if (graceDays > 0) {
          double graceInterest = (totalAmount * (interestRate / 100) / 30) * graceDays;
          totalAmount += graceInterest;
        }

        // 2. Calculate monthly installment using the standard formula
        // For simplicity, we use a basic interest calculation.
        // A more accurate formula would be more complex.
        final double totalInterest = totalAmount * (interestRate / 100) * installmentsCount;
        final double finalAmount = totalAmount + totalInterest;
        final double installmentAmount = finalAmount / installmentsCount;

        _installmentResults = List.generate(installmentsCount, (_) => installmentAmount);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محاسبه قسط و وام'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(controller: _totalAmountController, labelText: 'مبلغ کل', isCurrency: true, keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              CustomTextField(controller: _interestRateController, labelText: 'نرخ سود ماهیانه (درصد)', keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              CustomTextField(controller: _installmentsCountController, labelText: 'تعداد اقساط', keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              CustomTextField(controller: _intervalController, labelText: 'فاصله زمانی اقساط (ماه)', keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              CustomTextField(controller: _gracePeriodController, labelText: 'مدت تنفس (روز)', keyboardType: TextInputType.number),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculateInstallments,
                child: const Text('محاسبه'),
              ),
              const SizedBox(height: 24),
              if (_installmentResults.isNotEmpty) _buildResults(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نتایج:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _installmentResults.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('قسط شماره ${index + 1}'),
              trailing: Text('${_installmentResults[index].toStringAsFixed(0)} تومان'),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _totalAmountController.dispose();
    _interestRateController.dispose();
    _installmentsCountController.dispose();
    _intervalController.dispose();
    _gracePeriodController.dispose();
    super.dispose();
  }
}
