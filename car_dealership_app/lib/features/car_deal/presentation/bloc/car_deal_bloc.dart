import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/car_deal_model.dart';
import '../../data/repositories/car_deal_repository.dart';

part 'car_deal_event.dart';
part 'car_deal_state.dart';

class CarDealBloc extends Bloc<CarDealEvent, CarDealState> {
  final CarDealRepository _repository;

  CarDealBloc(this._repository) : super(CarDealInitial()) {
    on<LoadCarDeals>(_onLoadCarDeals);
    on<FilterDealsByStatus>(_onFilterDealsByStatus);
    on<AddCarPurchaseDeal>(_onAddCarPurchaseDeal);
    // Add handlers for other events like SellCar, AddExpense etc.
  }

  Future<void> _onLoadCarDeals(LoadCarDeals event, Emitter<CarDealState> emit) async {
    emit(CarDealLoading());
    try {
      final deals = await _repository.getAllDeals();
      emit(CarDealLoaded(deals: deals, activeFilter: null));
    } catch (e) {
      emit(CarDealError(e.toString()));
    }
  }

  Future<void> _onFilterDealsByStatus(FilterDealsByStatus event, Emitter<CarDealState> emit) async {
    emit(CarDealLoading());
    try {
      final deals = await _repository.getDealsByStatus(event.status);
      emit(CarDealLoaded(deals: deals, activeFilter: event.status));
    } catch (e) {
      emit(CarDealError(e.toString()));
    }
  }

  Future<void> _onAddCarPurchaseDeal(AddCarPurchaseDeal event, Emitter<CarDealState> emit) async {
    try {
      await _repository.saveDeal(event.deal, event.car);
      add(LoadCarDeals()); // Reload all deals after adding a new one
    } catch (e) {
      emit(CarDealError(e.toString()));
    }
  }
}
