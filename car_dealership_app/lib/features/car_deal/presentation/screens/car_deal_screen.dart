import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/car_deal_model.dart';
import '../bloc/car_deal_bloc.dart';
import '../../data/repositories/car_deal_repository.dart';
import 'add_purchase_screen.dart'; // We will create this next

class CarDealScreen extends StatelessWidget {
  const CarDealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarDealBloc(CarDealRepository())..add(LoadCarDeals()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('خرید و فروش خودرو'),
            bottom: TabBar(
              onTap: (index) {
                final bloc = context.read<CarDealBloc>();
                if (index == 0) {
                  bloc.add(const FilterDealsByStatus(DealStatus.available));
                } else {
                  bloc.add(const FilterDealsByStatus(DealStatus.sold));
                }
              },
              tabs: const [
                Tab(text: 'خودروهای موجود'),
                Tab(text: 'خودروهای فروخته شده'),
              ],
            ),
          ),
          body: BlocBuilder<CarDealBloc, CarDealState>(
            builder: (context, state) {
              if (state is CarDealLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CarDealLoaded) {
                return _buildDealList(context, state.deals);
              }
              if (state is CarDealError) {
                return Center(child: Text('خطا: ${state.message}'));
              }
              return const Center(child: Text('برای شروع، خرید خودرویی را ثبت کنید.'));
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<CarDealBloc>(context),
                    child: const AddPurchaseScreen(),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildDealList(BuildContext context, List<CarDeal> deals) {
    if (deals.isEmpty) {
      return const Center(child: Text('هیچ خودرویی یافت نشد.'));
    }

    return ListView.builder(
      itemCount: deals.length,
      itemBuilder: (context, index) {
        final deal = deals[index];
        // The car model might not be loaded yet, this is a simplified view.
        // In a real app, we would load the linked Car object.
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(deal.carInfo.value?.model ?? 'نامشخص'),
            subtitle: Text('قیمت خرید: ${deal.totalPurchasePrice ?? 0} تومان'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: () {}, child: const Text('مخارج')),
                TextButton(onPressed: () {}, child: const Text('فروش')),
              ],
            ),
          ),
        );
      },
    );
  }
}
