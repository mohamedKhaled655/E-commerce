
import 'package:e_shop/features/home/data/models/product_model.dart';

abstract class ProductStates{}
class ProductInitState extends ProductStates{}
class ProductLoadingState extends ProductStates{}
class ProductSuccessState extends ProductStates{
final List<ProductModel> productModel;

   ProductSuccessState(this.productModel);
}
class ProductErrorState extends ProductStates{
  final String errMessage;

   ProductErrorState(this.errMessage);
}