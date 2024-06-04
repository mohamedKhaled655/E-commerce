


import '../../../home/data/models/notification_model.dart';

abstract class NotificationStates{}
class NotificationInitState extends NotificationStates{}
class NotificationLoadingState extends NotificationStates{}
class NotificationSuccessState extends NotificationStates{
final List<NotificModel> notificationModel;

   NotificationSuccessState(this.notificationModel);
}
class NotificationErrorState extends NotificationStates{
  final String errMessage;

   NotificationErrorState(this.errMessage);
}