part of 'car_deal_bloc.dart';

abstract class CarDealEvent extends Equatable {
  const CarDealEvent();

  @override
  List<Object> get props => [];
}

// Event to load all car deals
class LoadCarDeals extends CarDealEvent {}

// Event to filter deals by status (Available or Sold)
class FilterDealsByStatus extends CarDealEvent {
  final DealStatus status;

  const FilterDealsByStatus(this.status);

  @override
  List<Object> get props => [status];
}

// Event to add a new car purchase deal
class AddCarPurchaseDeal extends CarDealEvent {
  final CarDeal deal;
  final Car car;

  const AddCarPurchaseDeal({required this.deal, required this.car});

  @override
  List<Object> get props => [deal, car];
}

// Event to sell a car
class SellCar extends CarDealEvent {
  final CarDeal updatedDeal;

  const SellCar(this.updatedDeal);

  @override
  List<Object> get props => [updatedDeal];
}

// Event to add an expense to a car
class AddExpenseToCar extends CarDealEvent {
  final int dealId;
  final Payment expense;

  const AddExpenseToCar({required this.dealId, required this.expense});

  @override
  List<Object> get props => [dealId, expense];
}
