
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_states.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit(this.homeRepo) : super(NotificationInitState());

  static NotificationCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;


  Future<void>fetchNotificationData()async{
    emit(NotificationLoadingState());
    var result= await homeRepo.fetchNotification(
      lang: language,
      token: token
    );
    result.fold((failure) {
      emit(NotificationErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (notification){
   
      emit(NotificationSuccessState(notification));
      print("Notification=$notification");
    
    });
  }

}