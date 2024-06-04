
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:e_shop/features/payment/presentation/view_model/payment_cubit/payment_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/api_constance.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit(this.homeRepo) : super(PaymentInitState());

  static PaymentCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;

  
  Future<void>getPaymenttAuthToken()async{
    emit(PaymentAuthTokenLoadingState());
    var result= await homeRepo.getAuthPaymentToken();
    result.fold((failure) {
      emit(PaymentAuthTokenErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (paymentAuthToken){
      ApiContest.paymentFirstToken=paymentAuthToken.token!;
      emit(PaymentAuthTokenSuccessState(paymentAuthToken));
      print("paymentAuthToken=${paymentAuthToken.token}");
    });
  }
  bool isPayment=false;

  Future<void>getOrderRegistrationID({ required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,})async{
    emit(GetOrderRegistrationIDLoadingState());
    var result= await homeRepo.getOrderRegistrationID(price: price, firstName: firstName, lastName: lastName, email: email, phone: phone);
    result.fold((failure) {
      isPayment=false;
      emit(GetOrderRegistrationIDErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (paymentOrderId){
      ApiContest.paymentOrderId=paymentOrderId;
      getPaymentRequest(priceOrder: price, firstName: firstName, lastName: lastName, email: email, phone: phone);
      emit(GetOrderRegistrationIDSuccessState(paymentOrderId));
      print("paymentOrderId=$paymentOrderId");
    });
  }

  Future<void>getPaymentRequest({ required String priceOrder,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,})async{
    emit(GetPaymentRequestLoadingState());
    var result= await homeRepo.getPaymentRequest(priceOrder: priceOrder, firstName: firstName, lastName: lastName, email: email, phone: phone);
    result.fold((failure) {
      emit(GetPaymentRequestErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (finalToken){
      ApiContest.finalToken=finalToken;
      isPayment=true;
      emit(GetPaymentRequestSuccessState(finalToken));
      print("finalToken=$finalToken");
    });
  }

  Future<void>fettchRefCode()async{
    emit(GetRefCodeLoadingState());
    var result= await homeRepo.getRefCode();
    result.fold((failure) {
      emit(GetRefCodeErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (refCode){
      ApiContest.refCode=refCode;
      emit(GetRefCodeSuccessState(refCode));
      print("The ref code 🍅=$refCode");
    });
  }

}