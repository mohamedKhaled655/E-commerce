import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:e_shop/core/widgets/custom_loading_widget.dart';
import 'package:e_shop/core/widgets/error_widget.dart';
import 'package:e_shop/features/home/data/repo/home_repo_imp.dart';
import 'package:e_shop/features/home/presentation/view_model/banners_cubit/banners_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

import '../../../../../core/constant.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../../core/utils/shimmer_screen/carousel_shimmer.dart';
import '../../view_model/banners_cubit/banners_cubit.dart';


List listImage = [
  "assets/images/b1.jpg",
  "assets/images/b2.jpg",
  "assets/images/b3.jpg",
];

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannersCubit(getIt.get<HomeRepoImplement>())..fetchBannerData(),
      child: BlocBuilder<BannersCubit,BannersStates>(
        builder: (context, state) {
          if(state is BannersLoadingState){
            return const CarouselShimmer();
          }else if(state is BannersErrorState){
            return CustomErrorWidget(errorText: state.errMessage);
          }else if(state is BannersSuccessState){
            return FadeIn(
        duration:const Duration(milliseconds: 500),
        child: CarouselSlider(
          options: CarouselOptions(
            height: h10*17,
           // aspectRatio: 16 / 9,
            viewportFraction: .85,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration:const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            //onPageChanged: callbackFunction,
            scrollDirection: Axis.horizontal,
          ),
          
          items: state.banners.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration:  BoxDecoration(color: Colors.blueGrey[50],borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: i.image??"",
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ));
              },
            );
          }).toList(),
        ),
      );
          }else{
            return const CarouselShimmer();
          }
        },
      ),
    );
  }
}