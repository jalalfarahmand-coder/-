import 'package:car_dealership_app/features/car_deal/data/models/car_deal_model.dart';
import 'package:car_dealership_app/features/car_deal/data/repositories/car_deal_repository.dart';
import 'package:car_dealership_app/core/services/notification_service.dart';

class NotificationScheduler {
  final CarDealRepository _carDealRepository = CarDealRepository();
  final NotificationService _notificationService = NotificationService();

  // This method should be called periodically, e.g., once a day when the app starts.
  Future<void> scheduleDailyChecks() async {
    await _scheduleInsuranceExpiryNotifications();
    await _scheduleChequeNotifications();
    // Add calls to other schedulers here (e.g., installments)
  }

  Future<void> _scheduleInsuranceExpiryNotifications() async {
    final deals = await _carDealRepository.getDealsByStatus(DealStatus.available);
    for (final deal in deals) {
      if (deal.insuranceExpiryDate != null) {
        final notificationDate = deal.insuranceExpiryDate!.subtract(const Duration(days: 30));
        // Check if the notification date is in the future
        if (notificationDate.isAfter(DateTime.now())) {
          _notificationService.scheduleNotification(
            id: deal.id, // Use a unique ID for each notification
            title: 'انقضای بیمه',
            body: 'بیمه خودرو مدل ${deal.carInfo.value?.model ?? ""} تا ۳۰ روز دیگر منقضی می‌شود.',
            scheduledDate: notificationDate,
          );
        }
      }
    }
  }

  Future<void> _scheduleChequeNotifications() async {
    // This is more complex as it requires querying all payments across all deals.
    // This is a placeholder for the logic.

    // 1. Get all deals
    // 2. For each deal, get all payments of type 'cheque'
    // 3. For each cheque, calculate the notification date (e.g., 3 days before)
    // 4. If the date is in the future, schedule a notification.

    print("Checking for cheque due dates...");
    // Example:
    // _notificationService.scheduleNotification(
    //   id: payment.id + 10000, // Ensure unique ID
    //   title: 'سررسید چک',
    //   body: 'چک شماره ${payment.chequeNumber} به مبلغ ${payment.amount} فردا سررسید می‌شود.',
    //   scheduledDate: chequeDate.subtract(const Duration(days: 1)),
    // );
  }
}
