import 'dart:async';

import 'package:e_shop/core/utils/services_location.dart';
import 'package:e_shop/core/widgets/custom_bottom.dart';
import 'package:e_shop/core/widgets/custom_text_feild.dart';
import 'package:e_shop/core/widgets/main_app_bar.dart';
import 'package:e_shop/features/address/presentation/view_model/add_address_cubit/add_address_cubit.dart';
import 'package:e_shop/features/address/presentation/view_model/add_address_cubit/add_address_states.dart';
import 'package:e_shop/features/cart/presentation/views/widgets/custom_bar.dart';
import 'package:e_shop/features/home/presentation/view/widgets/custom_app_bar.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constant.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/customTextFeild1.dart';
import '../../../home/data/repo/home_repo_imp.dart';
import 'addreess_view.dart';

class NewAddressView extends StatefulWidget {
  const NewAddressView({Key? key}) : super(key: key);

  @override
  State<NewAddressView> createState() => _NewAddressViewState();
}

class _NewAddressViewState extends State<NewAddressView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.3847811, 30.7822392),
    zoom: 10,
  );

  ServicesLocation servicesLocation = ServicesLocation();
  Position? currentLocation;
  Set<Marker> _markers = {};
  @override
  void initState() {
    super.initState();
    servicesLocation.getPostion(context);
    getLoc();
    
  }

  void getLoc() async {
    currentLocation = await servicesLocation.getLatAndLang();
    print(
        "lat=${currentLocation!.latitude} and lng=${currentLocation!.longitude}");
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("current_location"),
        position: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        infoWindow: InfoWindow(title: "Current Location"),
      ));
    });
  }

  void _onMapDragEnd(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId("new_location"),
        position: position,
        infoWindow: const InfoWindow(title: "New Location"),
      ));
    });
  }

  Future<String> getAddressFromLatLng(
      {required double lat, required double lng}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark place = placemarks[0]; // Get the first address
    String address =
        "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
    print("${place.administrativeArea}, ${place.street},  ${place.country}");
    region = place.administrativeArea;
    details = place.street;

    return address;
  }

  String? name, details, region, city, notes;
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isLoad=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddAddressCubit(getIt.get<HomeRepoImplement>()),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: 300,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: h10 * 30,
                          child: currentLocation != null
                              ? GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: _kGooglePlex,
                                  zoomControlsEnabled: false,
                                  markers: _markers,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                  onCameraMove: (postion) {
                                    _onMapDragEnd(postion.target);
                                    getAddressFromLatLng(
                                        lat: postion.target.latitude,
                                        lng: postion.target.longitude);
                                    print(
                                        "change==lat=${postion.target.latitude} and lang==${postion.target.longitude}");
                                  },
                                )
                              : const Center(
                                  child: CircularProgressIndicator()),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: MainAppBar(
                          title: "Add New Address",
                          isArrowBack: true,
                          onPressed: () async{
                            Navigator.pop(context,true);
                           // GoRouter.of(context).push(AppRouter.address);
                           
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: FloatingActionButton(
                            backgroundColor: Theme.of(context).primaryColor,
                            onPressed: () async {
                              final GoogleMapController controller =
                                  await _controller.future;
                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      bearing: 192.8334901395799,
                                      target: LatLng(currentLocation!.latitude,
                                          currentLocation!.longitude),
                                      tilt: 59.440717697143555,
                                      zoom: 19.151926040649414)));
                              getAddressFromLatLng(
                                  lat: currentLocation!.latitude,
                                  lng: currentLocation!.longitude);
                            },
                            //label: const Text('To the lake!'),
                            child: const Icon(
                              Icons.location_on,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Container(
                      height: h10 * 55,
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          color: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .backgroundColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                              child: MiddleText(
                                  text: "Address Details", fontSize: 25)),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                              endIndent: 50, indent: 50, thickness: 1.2),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFeild1(
                            hintText: "Place Name",
                            onSaved: (value) {
                              name = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFeild1(
                                  hintText: "City",
                                  onSaved: (value) {
                                    city = value;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: CustomTextFeild1(
                                  hintText: "Region",
                                  onSaved: (value) {
                                    region = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const MiddleText(text: "Address Details"),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFeild1(
                            hintText: details ?? "Enter your details",
                            onSaved: (value) {
                              if(details !=null){
                                details=details;
                              }else if(value ==null){
                                details="";
                              }else{
                                details=value;
                              }
                              //details ?? value;
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const MiddleText(text: "Notes"),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFeild1(
                            hintText: "Notes",
                            onSaved: (value) {
                              notes = value;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocConsumer<AddAddressCubit, AddAddressStates>(
                            listener: (context, state) {
                              if (state is AddAddressSuccessState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    showSnakBar(
                                        backgroundColor: Theme.of(context).primaryColor,
                                        context: context,
                                        message: state.favoritesModel.message ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 16)));
                              }
                              else if(state is AddAddressErrorState){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    showSnakBar(
                                        backgroundColor: Colors.red,
                                        context: context,
                                        message: state.errMessage,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 16)));
                              }
                            },
                            builder: (context, state) {
                              return CustomButton(
                                borderRadius: 25,
                                title: "Add",
                                isLoading: state is AddAddressLoadingState
                                    ? true
                                    : false,
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    print(
                                        "address=$name &&details=$details,$region,$notes,$city,${currentLocation!.latitude}");
                                    if(currentLocation!=null){
                                      AddAddressCubit.get(context).addAddressData(
                                        name: name!,
                                        city: city!,
                                        details: details!,
                                        notes: notes!,
                                        region: region!,
                                        lat: "${currentLocation?.latitude??29.3847811}",
                                        long: "${currentLocation?.longitude??30.7822392}");
                                    }
                                    /* cubit.login(
                              email: email!,
                              password: password!,
                              context: context);*/
                                  } else {
                                    autovalidateMode =
                                        AutovalidateMode.onUserInteraction;
                                    setState(() {});
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(
                      currentLocation!.latitude, currentLocation!.longitude),
                  tilt: 59.440717697143555,
                  zoom: 19.151926040649414)));
          getAddressFromLatLng(
              lat: currentLocation!.latitude, lng: currentLocation!.longitude);
        },
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
  }
}
