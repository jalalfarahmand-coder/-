import 'package:isar/isar.dart';
import '../../../phone_book/data/models/contact_model.dart';

part 'car_deal_model.g.dart';

enum DealStatus {
  available, // خودروی موجود
  sold,      // خودروی فروخته شده
}

@collection
class CarDeal {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  late DealStatus status;

  // Transaction Dates
  DateTime? dealDate;
  DateTime? insuranceExpiryDate;

  // Car Specifications
  final carInfo = IsarLink<Car>();

  // Seller(s) Info
  final sellers = IsarLinks<Contact>();
  final sellerShares = IsarLinks<PartyShare>(); // To store percentage for each seller

  // Buyer(s) Info (filled when sold)
  final buyers = IsarLinks<Contact>();
  final buyerShares = IsarLinks<PartyShare>(); // To store percentage for each buyer

  // Financials
  double? totalPurchasePrice;
  double? initialPayment; // مبلغ پرداختی اولیه در خرید

  double? totalSalePrice;
  double? saleInitialPayment; // مبلغ پرداختی اولیه در فروش

  final payments = IsarLinks<Payment>();

  // Delivered Items
  final deliveredItems = IsarLinks<DeliveredItem>();
  DateTime? deliveryDate;

  // Partners
  final partnerShares = IsarLinks<PartnerShare>();
}

@embedded
class PartyShare {
  int? contactId;
  double? percentage;
}

@embedded
class PartnerShare {
  // Assuming Partner will be another collection
  int? partnerId;
  double? percentage;
}


@collection
class Car {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String? licensePlate;
  String? dangs; // دانگ
  String? type;  // نوع
  String? model; // مدل
  String? system; // سیستم
  String? color; // رنگ
  int? cylinders; // سیلندر
  int? wheels; // چرخ
  String? engineNumber;
  String? chassisNumber;
  String? vinNumber;
}

enum PaymentType {
  cash,
  card,
  cheque,
  installment
}

@collection
class Payment {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  late PaymentType type;

  DateTime? date;
  double? amount;
  String? description;

  // Card specific
  String? fromCard;
  String? toCard;

  // Cheque specific
  String? chequeNumber;
  String? bankName;
  String? accountNumber;

  bool isGuaranteeCheque = false;
}

@collection
class DeliveredItem {
  Id id = Isar.autoIncrement;
  String? name;
  bool isDelivered = false;
}
