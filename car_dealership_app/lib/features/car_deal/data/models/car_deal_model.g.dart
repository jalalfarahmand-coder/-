// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_deal_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

// --- CarDeal Collection ---
extension GetCarDealCollection on Isar {
  IsarCollection<CarDeal> get carDeals => this.collection();
}
const CarDealSchema = CollectionSchema(
  name: r'CarDeal',
  id: -259458113892783828,
  // ... other properties, indexes, links
  embeddedSchemas: {
    r'PartyShare': PartyShareSchema,
    r'PartnerShare': PartnerShareSchema,
  },
  // ... other schema definitions
);

// --- Car Collection ---
extension GetCarCollection on Isar {
  IsarCollection<Car> get cars => this.collection();
}
const CarSchema = CollectionSchema(
  name: r'Car',
  id: -822989531586716016,
  // ... other properties, indexes, links
);


// --- Payment Collection ---
extension GetPaymentCollection on Isar {
  IsarCollection<Payment> get payments => this.collection();
}
const PaymentSchema = CollectionSchema(
  name: r'Payment',
  id: -4174366914527999464,
  // ... other properties, indexes, links
);

// --- DeliveredItem Collection ---
extension GetDeliveredItemCollection on Isar {
  IsarCollection<DeliveredItem> get deliveredItems => this.collection();
}
const DeliveredItemSchema = CollectionSchema(
  name: r'DeliveredItem',
  id: 641125748892189953,
  // ... other properties, indexes, links
);

// --- Embedded Schemas ---
const PartyShareSchema = EmbeddedSchema(
  name: r'PartyShare',
  id: 8089222415174093952,
  properties: {},
  // ...
);

const PartnerShareSchema = EmbeddedSchema(
  name: r'PartnerShare',
  id: -7716130383794953935,
  properties: {},
  // ...
);

// Placeholder for the rest of the generated code.
// In a real project, this file would be thousands of lines long.
