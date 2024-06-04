
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/onboarding/data/models/onboarding_model.dart';

List<OnboardingModel>onbordingList=[
  OnboardingModel(
    title: "Choose Product",
    body: "A Product is the item offered for sale .\n A Product can be service or an item.it can\n be physical or in virtual or cyber form ",
    image: themeSaved==true? "assets/images/don4.png":"assets/images/on1.png"
  ),
  OnboardingModel(
    title: "Make Payment",
    body: "Payment is the transfer of money \n services is exchange product or payments \n typically mode terms agreed ",
    image: themeSaved==true? "assets/images/don3.png":"assets/images/on2.png"
  ),
  OnboardingModel(
    title: "Get Your Orders",
    body: "Business or commerce an order is a \nstated  intention either spoken to engage in \na commerical transaction specific products",
    image: themeSaved==true? "assets/images/don2.png":"assets/images/on3.png"
  ),
];