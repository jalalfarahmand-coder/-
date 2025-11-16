import 'package:isar/isar.dart';

part 'contact_model.g.dart';

enum ContactType {
  individual,
  legal,
}

@collection
class Contact {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  late ContactType type;

  // Fields for Individual Contact
  String? firstName;
  String? lastName;
  String? fatherName;
  String? birthCertNumber;
  String? nationalId;
  String? issuePlace;

  // Fields for Legal Contact
  String? companyName;
  String? companyNationalId;
  String? registrationNumber;
  String? companyPhone;
  String? representativeInfo; // Storing representative as a simple string for now, can be a separate embedded object later.

  // Common fields
  final addresses = IsarLinks<AddressInfo>();
  final phones = IsarLinks<PhoneInfo>();
  final attachments = IsarLinks<Attachment>();

  @Index()
  String get fullName => type == ContactType.individual ? '$firstName $lastName' : companyName ?? '';
}

@embedded
class AddressInfo {
  String? address;
  String? postalCode;
}

@embedded
class PhoneInfo {
  String? mobileNumber;
  String? landlineNumber;
}

@embedded
class Attachment {
  String? filePath; // Path to the image file
  String? description;
}
