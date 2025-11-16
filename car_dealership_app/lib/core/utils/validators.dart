class AppValidators {
  // A simple validator for required fields
  static String? required(String? value, {String message = 'این فیلد الزامی است'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  // Validator for National ID (10 digits)
  static String? nationalId(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Not required, just a format check
    }
    final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanValue.length != 10) {
      return 'کد ملی باید ۱۰ رقم باشد';
    }
    return null;
  }

  // Validator for Mobile Number (11 digits, starts with 09)
  static String? mobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Not required, just a format check
    }
    final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanValue.length != 11) {
      return 'شماره موبایل باید ۱۱ رقم باشد';
    }
    if (!cleanValue.startsWith('09')) {
      return 'شماره موبایل باید با ۰۹ شروع شود';
    }
    return null;
  }

  // Validator for Landline Phone Number (11 digits)
  static String? landlineNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Not required, just a format check
    }
    final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanValue.length != 11) {
      return 'تلفن ثابت باید ۱۱ رقم باشد';
    }
    return null;
  }

  // Validator for Postal Code (10 digits)
  static String? postalCode(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Not required, just a format check
    }
    final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanValue.length != 10) {
      return 'کد پستی باید ۱۰ رقم باشد';
    }
    return null;
  }

  // A combined validator
  static String? Function(String?)? compose(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }
}
