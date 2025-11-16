import 'package:isar/isar.dart';
import '../models/car_deal_model.dart';

class CarDealRepository {
  late Future<Isar> _db;

  // Assuming the Isar instance is already opened by PhoneBookRepository or a central service.
  CarDealRepository() {
    _db = Future.value(Isar.getInstance('CarDealershipDb'));
  }

  // Get all car deals
  Future<List<CarDeal>> getAllDeals() async {
    final isar = await _db;
    // We use links to fetch related data.
    return await isar.carDeals.where().findAll();
  }

  // Get deals by status (Available or Sold)
  Future<List<CarDeal>> getDealsByStatus(DealStatus status) async {
    final isar = await _db;
    return await isar.carDeals.filter().statusEqualTo(status).findAll();
  }

  // Get a single deal by its ID
  Future<CarDeal?> getDealById(int id) async {
    final isar = await _db;
    return await isar.carDeals.get(id);
  }

  // Add or Update a car deal
  // This is a complex transaction involving multiple linked objects.
  Future<void> saveDeal(CarDeal deal, Car carInfo) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      // Save the car info first to get an ID
      await isar.cars.put(carInfo);

      // Save the deal
      await isar.carDeals.put(deal);

      // Link the car to the deal
      await deal.carInfo.save();

      // Link sellers, buyers, payments etc.
      await deal.sellers.save();
      await deal.buyers.save();
      await deal.payments.save();
    });
  }

  // More methods for specific queries can be added here.
  // For example, adding an expense to a car, selling a car (updating its status), etc.
}
