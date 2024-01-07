import 'package:e_commercee_app/base/custom_app_bar.dart';
import 'package:e_commercee_app/controllers/auth_controller.dart';
import 'package:e_commercee_app/controllers/location_controller.dart';
import 'package:e_commercee_app/controllers/user_controller.dart';
import 'package:e_commercee_app/models/address_model.dart';
import 'package:e_commercee_app/pages/address/pick_address_map.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/app_text_field.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  final LatLng? latLng;
  const AddAddressPage({super.key, this.latLng});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  late CameraPosition _cameraPosition;

  late LatLng _initialPosition ;

  @override
  void initState() {
    super.initState();
    _cameraPosition = CameraPosition(target: widget.latLng ?? LatLng(45.51563, -122.677433), zoom: 17);
    _initialPosition = widget.latLng ?? LatLng(45.51563, -122.677433);
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      print("get user profile");
      Get.find<UserController>().getUserInfo();
    }
    print("rundjc");
    if (Get.find<LocationController>().addressList.isNotEmpty && widget.latLng == null) {
      if(Get.find<LocationController>().getUserAddressFromLocalStorage() == ""){
        Get.find<LocationController>().saveUserAddress(Get
        .find<LocationController>()
        .addressList.last);
      }
      Get.find<LocationController>().getUserAddress();

      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longtitude"])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(
              Get.find<LocationController>().getAddress["longtitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Address", ),
        body: GetBuilder<UserController>(builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = userController.userModel?.name??"";
            _contactPersonNumber.text = userController.userModel?.phone??"";
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(builder: (locationController) {
            _addressController.text =
                '${locationController.placemark.name ?? ""}'
                '${locationController.placemark.locality ?? ""}'
                '${locationController.placemark.postalCode ?? ""}'
                '${locationController.placemark.country}';
            print('address in my view is ' + _addressController.text);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: AppColors.green70)),
                    child: Stack(children: [
                      GoogleMap(
                        onTap: (latlng){
                          var position = locationController.position;
                          Get.offNamed(RouteHelper.getPickAddressPage(),
                          arguments: PickAddressMap(
                            fromSignup: false,
                            fromAddress: true,
                            googleMapController: locationController.mapController, latLng: LatLng(position.latitude,position.longitude ),
                            )
                          );
                        },
                        initialCameraPosition:
                            CameraPosition(target: _initialPosition, zoom: 17),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: () {
                          locationController.updatePosition(
                              _cameraPosition, true);
                        },
                        onCameraMove: ((position) =>
                            _cameraPosition = position),
                        onMapCreated: (GoogleMapController controller) {
                          locationController.setMapController(controller);
                        },
                      )
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimenstions.width20, top: Dimenstions.height20),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: locationController.addressTypeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                locationController.setAddressTypeIndex(index);
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimenstions.width20,
                                      vertical: Dimenstions.height10),
                                  margin: EdgeInsets.only(
                                      right: Dimenstions.width10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimenstions.radius20 / 4),
                                      color: Theme.of(context).cardColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[200]!,
                                            spreadRadius: 1,
                                            blurRadius: 5)
                                      ]),
                                  child: Icon(
                                    index == 0
                                        ? Icons.home_filled
                                        : index == 1
                                            ? Icons.work
                                            : Icons.location_on,
                                    color: index ==
                                            locationController.addressTypeIndex
                                        ? AppColors.green70
                                        : Theme.of(context).disabledColor,
                                  )),
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: Dimenstions.height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimenstions.width20),
                    child: BigText(text: "Delivery Address"),
                  ),
                  SizedBox(
                    height: Dimenstions.height10,
                  ),
                  AppTextField(
                      textEditingController: _addressController,
                      hintText: "Your address",
                      icon: Icons.map),
                  Padding(
                    padding: EdgeInsets.only(left: Dimenstions.width20),
                    child: BigText(text: "Contact name"),
                  ),
                  SizedBox(
                    height: Dimenstions.height10,
                  ),
                  AppTextField(
                      textEditingController: _contactPersonName,
                      hintText: "Your name",
                      icon: Icons.person),
                  Padding(
                    padding: EdgeInsets.only(left: Dimenstions.width20),
                    child: BigText(text: "Your number"),
                  ),
                  SizedBox(
                    height: Dimenstions.height20,
                  ),
                  AppTextField(
                      textEditingController: _contactPersonNumber,
                      hintText: "Your number",
                      icon: Icons.phone),
                ],
              ),
            );
          });
        }),
        bottomNavigationBar:
            GetBuilder<LocationController>(builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimenstions.height20*8,
                padding:
                    EdgeInsets.only(top: Dimenstions.height20, bottom: Dimenstions.height20, left: Dimenstions.width10, right: Dimenstions.width10),
                decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          addressType: controller.addressTypeList[controller.addressTypeIndex],
                          contactPersonName: _contactPersonNumber.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude: controller.position.latitude.toString(),
                          longtitude: controller.position.longitude.toString(),
                        );
                        controller.addAddress(_addressModel).then((response){
                          if(response.isSuccess){

                            print("runigngng");
                            Get.snackbar("Address", "Added Successfully");
                            Navigator.pop(context);
                          }
                          else{
                            Get.snackbar("Address", "Failure");
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimenstions.width20, vertical: Dimenstions.height20),
                        child: BigText(
                          text: 'Save address',
                          color: Colors.white,
                          size: 26,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimenstions.radius20),
                            color: Colors.teal[400]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
