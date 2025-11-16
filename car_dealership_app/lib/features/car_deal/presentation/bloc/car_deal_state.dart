part of 'car_deal_bloc.dart';

abstract class CarDealState extends Equatable {
  const CarDealState();

  @override
  List<Object> get props => [];
}

class CarDealInitial extends CarDealState {}

class CarDealLoading extends CarDealState {}

class CarDealLoaded extends CarDealState {
  final List<CarDeal> deals;
  final DealStatus? activeFilter;

  const CarDealLoaded({required this.deals, this.activeFilter});

  @override
  List<Object> get props => [deals, activeFilter ?? 'all'];
}

class CarDealError extends CarDealState {
  final String message;

  const CarDealError(this.message);

  @override
  List<Object> get props => [message];
}

// State for when a single deal is loaded (e.g., for viewing details)
class SingleDealLoaded extends CarDealState {
  final CarDeal deal;

  const SingleDealLoaded({required this.deal});

  @override
  List<Object> get props => [deal];
}
