import 'package:flutter/material.dart';
import '../../../../core/utils/validators.dart';
import '../../../../presentation/widgets/custom_text_field.dart';
import '../../../../presentation/widgets/shamsi_date_picker_field.dart';
import '../../data/models/contact_model.dart';
// Other imports will be needed as we build the full app

class AddEditContactScreen extends StatefulWidget {
  final Contact? contact; // If contact is null, it's a new contact. Otherwise, we're editing.

  const AddEditContactScreen({Key? key, this.contact}) : super(key: key);

  @override
  _AddEditContactScreenState createState() => _AddEditContactScreenState();
}

class _AddEditContactScreenState extends State<AddEditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late ContactType _contactType;

  // Controllers for Individual
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _birthCertController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _issuePlaceController = TextEditingController();

  // Controllers for Legal
  final _companyNameController = TextEditingController();
  final _companyNationalIdController = TextEditingController();
  final _registrationNumberController = TextEditingController();

  // Common Controllers
  final _mobileController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contactType = widget.contact?.type ?? ContactType.individual;
    // Pre-fill fields if editing
    if (widget.contact != null) {
      _loadContactData(widget.contact!);
    }
  }

  void _loadContactData(Contact contact) {
    if (contact.type == ContactType.individual) {
      _firstNameController.text = contact.firstName ?? '';
      _lastNameController.text = contact.lastName ?? '';
      _fatherNameController.text = contact.fatherName ?? '';
      _nationalIdController.text = contact.nationalId ?? '';
    } else {
      _companyNameController.text = contact.companyName ?? '';
      _companyNationalIdController.text = contact.companyNationalId ?? '';
    }
    // Load common fields (address, phone etc.) here
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      // Logic to create or update Contact object from controllers
      // Then use Bloc to send an AddContact or UpdateContact event
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact == null ? 'افزودن مخاطب' : 'ویرایش مخاطب'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveContact,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildContactTypeSelector(),
              const SizedBox(height: 20),
              if (_contactType == ContactType.individual) _buildIndividualForm(),
              if (_contactType == ContactType.legal) _buildLegalForm(),
              const SizedBox(height: 20),
              _buildCommonFields(),
               const SizedBox(height: 20),
              // Attachment Section Placeholder
              ElevatedButton.icon(
                onPressed: () {}, // Implement attachment logic
                icon: const Icon(Icons.attach_file),
                label: const Text('افزودن پیوست'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactTypeSelector() {
    return SegmentedButton<ContactType>(
      segments: const [
        ButtonSegment(value: ContactType.individual, label: Text('حقیقی')),
        ButtonSegment(value: ContactType.legal, label: Text('حقوقی')),
      ],
      selected: {_contactType},
      onSelectionChanged: (Set<ContactType> newSelection) {
        setState(() {
          _contactType = newSelection.first;
        });
      },
    );
  }

  Widget _buildIndividualForm() {
    return Column(
      children: [
        CustomTextField(controller: _firstNameController, labelText: 'نام', validator: AppValidators.required),
        const SizedBox(height: 16),
        CustomTextField(controller: _lastNameController, labelText: 'نام خانوادگی', validator: AppValidators.required),
        const SizedBox(height: 16),
        CustomTextField(controller: _fatherNameController, labelText: 'نام پدر'),
        const SizedBox(height: 16),
        CustomTextField(controller: _nationalIdController, labelText: 'کد ملی', keyboardType: TextInputType.number, validator: AppValidators.nationalId),
      ],
    );
  }

  Widget _buildLegalForm() {
    return Column(
      children: [
        CustomTextField(controller: _companyNameController, labelText: 'نام شرکت', validator: AppValidators.required),
        const SizedBox(height: 16),
        CustomTextField(controller: _companyNationalIdController, labelText: 'شناسه ملی', keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        CustomTextField(controller: _registrationNumberController, labelText: 'شماره ثبت', keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildCommonFields() {
    return Column(
      children: [
        CustomTextField(controller: _mobileController, labelText: 'تلفن همراه', keyboardType: TextInputType.number, validator: AppValidators.mobileNumber),
        const SizedBox(height: 16),
        CustomTextField(controller: _phoneController, labelText: 'تلفن ثابت', keyboardType: TextInputType.number, validator: AppValidators.landlineNumber),
        const SizedBox(height: 16),
        CustomTextField(controller: _addressController, labelText: 'آدرس', maxLines: 2),
        const SizedBox(height: 16),
        CustomTextField(controller: _postalCodeController, labelText: 'کد پستی', keyboardType: TextInputType.number, validator: AppValidators.postalCode),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose all controllers
    _firstNameController.dispose();
    _lastNameController.dispose();
    // ... dispose others
    super.dispose();
  }
}
