// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetContactCollection on Isar {
  IsarCollection<Contact> get contacts => this.collection();
}

const ContactSchema = CollectionSchema(
  name: r'Contact',
  id: -3222482586854302542,
  properties: {
    r'birthCertNumber': PropertySchema(
      id: 0,
      name: r'birthCertNumber',
      type: IsarType.string,
    ),
    r'companyName': PropertySchema(
      id: 1,
      name: r'companyName',
      type: IsarType.string,
    ),
    r'companyNationalId': PropertySchema(
      id: 2,
      name: r'companyNationalId',
      type: IsarType.string,
    ),
    r'companyPhone': PropertySchema(
      id: 3,
      name: r'companyPhone',
      type: IsarType.string,
    ),
    r'fatherName': PropertySchema(
      id: 4,
      name: r'fatherName',
      type: IsarType.string,
    ),
    r'firstName': PropertySchema(
      id: 5,
      name: r'firstName',
      type: IsarType.string,
    ),
    r'fullName': PropertySchema(
      id: 6,
      name: r'fullName',
      type: IsarType.string,
    ),
    r'issuePlace': PropertySchema(
      id: 7,
      name: r'issuePlace',
      type: IsarType.string,
    ),
    r'lastName': PropertySchema(
      id: 8,
      name: r'lastName',
      type: IsarType.string,
    ),
    r'nationalId': PropertySchema(
      id: 9,
      name: r'nationalId',
      type: IsarType.string,
    ),
    r'registrationNumber': PropertySchema(
      id: 10,
      name: r'registrationNumber',
      type: IsarType.string,
    ),
    r'representativeInfo': PropertySchema(
      id: 11,
      name: r'representativeInfo',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 12,
      name: r'type',
      type: IsarType.byte,
      enumMap: _ContacttypeEnumValueMap,
    )
  },
  estimateSize: _contactEstimateSize,
  serialize: _contactSerialize,
  deserialize: _contactDeserialize,
  deserializeProp: _contactDeserializeProp,
  idName: r'id',
  indexes: {
    r'fullName': IndexSchema(
      id: 1493414999964173322,
      name: r'fullName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fullName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'addresses': LinkSchema(
      id: -5276384112859422204,
      name: r'addresses',
      target: r'AddressInfo',
      single: false,
    ),
    r'phones': LinkSchema(
      id: -483669040995908226,
      name: r'phones',
      target: r'PhoneInfo',
      single: false,
    ),
    r'attachments': LinkSchema(
      id: 5418195939523288421,
      name: r'attachments',
      target: r'Attachment',
      single: false,
    )
  },
  embeddedSchemas: {
    r'AddressInfo': AddressInfoSchema,
    r'PhoneInfo': PhoneInfoSchema,
    r'Attachment': AttachmentSchema
  },
  getId: _contactGetId,
  getLinks: _contactGetLinks,
  attach: _contactAttach,
  version: '3.1.0+1',
);

// Other generated code would follow, which is omitted for brevity.
// This is a simplified representation.
const _ContacttypeEnumValueMap = {
  'individual': 0,
  'legal': 1,
};
int _contactEstimateSize(Contact object, List<int> offsets, Map<Type, List<int>> allOffsets) => 0;
void _contactSerialize(Contact object, IsarWriter writer, List<int> offsets, Map<Type, List<int>> allOffsets) {}
Contact _contactDeserialize(Id id, IsarReader reader, List<int> offsets, Map<Type, List<int>> allOffsets) => Contact();
P _contactDeserializeProp<P>(IsarReader reader, int propertyId, int offset, Map<Type, List<int>> allOffsets) => throw UnimplementedError();
Id _contactGetId(Contact object) => object.id;
List<IsarLinkBase<dynamic>> _contactGetLinks(Contact object) => [object.addresses, object.phones, object.attachments];
void _contactAttach(IsarCollection<dynamic> col, Id id, Contact object) {}

const AddressInfoSchema = EmbeddedSchema(
  name: r'AddressInfo',
  id: -2226229612948330122,
  properties: {},
  estimateSize: (_, __, ___) => 0,
  serialize: (_, __, ___, ____) {},
  deserialize: (_) => AddressInfo(),
  deserializeProp: (_, __, ___) => throw UnimplementedError(),
);

const PhoneInfoSchema = EmbeddedSchema(
  name: r'PhoneInfo',
  id: -2585880709846399946,
  properties: {},
  estimateSize: (_, __, ___) => 0,
  serialize: (_, __, ___, ____) {},
  deserialize: (_) => PhoneInfo(),
  deserializeProp: (_, __, ___) => throw UnimplementedError(),
);

const AttachmentSchema = EmbeddedSchema(
  name: r'Attachment',
  id: 3939632968146995473,
  properties: {},
  estimateSize: (_, __, ___) => 0,
  serialize: (_, __, ___, ____) {},
  deserialize: (_) => Attachment(),
  deserializeProp: (_, __, ___) => throw UnimplementedError(),
);

// Query builder and other generated code would be here...
