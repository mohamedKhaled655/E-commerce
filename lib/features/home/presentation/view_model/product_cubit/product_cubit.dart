
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:e_shop/features/home/presentation/view_model/product_cubit/product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit(this.homeRepo) : super(ProductInitState());

  static ProductCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;

  //Map <int,bool>favorites={};

  Future<void>fetchProductData({required String lang})async{
    emit(ProductLoadingState());
    var result= await homeRepo.fetchProduct(
      lang: language,
      token: token
    );
    result.fold((failure) {
      emit(ProductErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (product){
   
      emit(ProductSuccessState(product));
      print("product=$product");
         for (var element in product) { 
        favorites.addAll(
          {
            element.id!:element.inFavorites!
          }
        );
      }
      print("$favorites");
    });
  }

}