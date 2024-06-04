import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_shop/features/onboarding/presentation/view/widgets/custom_smooth_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant.dart';
import '../../../../../core/widgets/cutom_arrow_back.dart';
import '../../../../home/data/models/product_model.dart';

class ImageDetalisProduct extends StatelessWidget {
  const ImageDetalisProduct({
    Key? key,
    required this.pageController,required this.productModel,
   
   
  }) : super(key: key);

  final PageController pageController;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .45,
      child: PageView.builder(
        controller: pageController,
        itemCount: productModel.images!.length,
        itemBuilder: (context, index) {
          return Stack(
          // fit: StackFit.expand,
            children: [
              Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: productModel.images![index],
                      height: MediaQuery.of(context).size.height * .4,
                      //width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: kPrimaryColor,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomSmoothIndicator(
                    pageController: pageController,
                    count:productModel.images!.length,
                    dotHeight: 7,
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(h10 * 1.5)),
                color: const Color(0xff1f222a).withOpacity(.3),
                // border: Border.all(color:Colors.white30 ),
              )),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: CutomArrowBack()),
              ),
            ],
          );
        },
      ),
    );
  }
}