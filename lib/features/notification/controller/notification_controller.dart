import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/notification/repository/notification_repository.dart';
import 'package:drip_plus/models/notification_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationControllerProvider =
    StateNotifierProvider<NotificationController, bool>((ref) {
  final notificationRepository = ref.watch(notificationRepositoryProvider);
  return NotificationController(
    notificationRepository: notificationRepository,
    ref: ref,
  );
});

final notificationListsProvider = StreamProvider((ref) {
  final notificationController =
      ref.watch(notificationControllerProvider.notifier);
  return notificationController.notificationLists();
});

class NotificationController extends StateNotifier<bool> {
  final NotificationRepository _notificationRepository;
  final Ref _ref;
  NotificationController({
    required NotificationRepository notificationRepository,
    required Ref ref,
  })  : _notificationRepository = notificationRepository,
        _ref = ref,
        super(false);

  Stream<List<NotificationModel>> notificationLists() {
    final userId = _ref.read(userProvider)!.uid;
    return _notificationRepository.notificationLists(userId);
  }

  void updateNotification(NotificationModel notification) async {
    _notificationRepository.updateNotification(notification);
  }
}
