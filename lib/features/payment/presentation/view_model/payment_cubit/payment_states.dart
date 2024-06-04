

import '../../../data/model/pay_auth_token_model.dart';

abstract class PaymentStates{}
class PaymentInitState extends PaymentStates{}
class PaymentAuthTokenLoadingState extends PaymentStates{}
class PaymentAuthTokenSuccessState extends PaymentStates{
final PaymentAuthTokenModel authToken;

   PaymentAuthTokenSuccessState(this.authToken);
}
class PaymentAuthTokenErrorState extends PaymentStates{
  final String errMessage;

   PaymentAuthTokenErrorState(this.errMessage);
}

class GetOrderRegistrationIDLoadingState extends PaymentStates{}
class GetOrderRegistrationIDSuccessState extends PaymentStates{
final String paymentFirstToken;

   GetOrderRegistrationIDSuccessState(this.paymentFirstToken);
}
class GetOrderRegistrationIDErrorState extends PaymentStates{
  final String errMessage;

   GetOrderRegistrationIDErrorState(this.errMessage);
}


class GetPaymentRequestLoadingState extends PaymentStates{}
class GetPaymentRequestSuccessState extends PaymentStates{
final String paymentFirstToken;

   GetPaymentRequestSuccessState(this.paymentFirstToken);
}
class GetPaymentRequestErrorState extends PaymentStates{
  final String errMessage;

   GetPaymentRequestErrorState(this.errMessage);
}

class GetRefCodeLoadingState extends PaymentStates{}
class GetRefCodeSuccessState extends PaymentStates{
final String refCode;

   GetRefCodeSuccessState(this.refCode);
}
class GetRefCodeErrorState extends PaymentStates{
  final String errMessage;

   GetRefCodeErrorState(this.errMessage);
}