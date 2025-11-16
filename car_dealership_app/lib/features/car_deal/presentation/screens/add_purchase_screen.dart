import 'package:flutter/material.dart';

class AddPurchaseScreen extends StatefulWidget {
  const AddPurchaseScreen({Key? key}) : super(key: key);

  @override
  _AddPurchaseScreenState createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends State<AddPurchaseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _savePurchase() {
    // Collect data from all tabs and save the deal
    // This will involve complex state management
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ثبت خرید خودرو جدید'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePurchase,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'تاریخ'),
            Tab(text: 'مشخصات خودرو'),
            Tab(text: 'فروشنده'),
            Tab(text: 'ثمن معامله'),
            Tab(text: 'موارد تحویل'),
            Tab(text: 'شرکا'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Each child will be a complex form widget
          _buildDateTab(),
          _buildCarInfoTab(),
          _buildSellerTab(),
          _buildPaymentTab(),
          _buildDeliveryTab(),
          _buildPartnersTab(),
        ],
      ),
    );
  }

  // Placeholder for each tab's form
  Widget _buildDateTab() => const Center(child: Text('فرم تاریخ'));
  Widget _buildCarInfoTab() => const Center(child: Text('فرم مشخصات خودرو'));
  Widget _buildSellerTab() => const Center(child: Text('فرم فروشنده'));
  Widget _buildPaymentTab() => const Center(child: Text('فرم ثمن معامله'));
  Widget _buildDeliveryTab() => const Center(child: Text('فرم موارد تحویل'));
  Widget _buildPartnersTab() => const Center(child: Text('فرم شرکا'));
}
