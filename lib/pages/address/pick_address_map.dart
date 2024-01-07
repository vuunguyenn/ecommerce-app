import 'package:e_commercee_app/base/custom_button.dart';
import 'package:e_commercee_app/controllers/location_controller.dart';
import 'package:e_commercee_app/pages/address/add_address_page.dart';
import 'package:e_commercee_app/pages/address/widgets/search_location_dialogue_page.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {

  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  final LatLng latLng;
  const PickAddressMap({super.key, required this.fromSignup,
    required this.fromAddress, this.googleMapController, required this.latLng});
  @override
  State<PickAddressMap> createState() => _PickAddressMapState();

}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initalPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    // if(Get.find<LocationController>().addressList.isEmpty){
      _initalPosition = widget.latLng;
      _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
    // }else{
    //   if(Get.find<LocationController>().addressList.isNotEmpty){
    //     _initalPosition = LatLng(
    //        double.parse(Get.find<LocationController>().getAddress["latitude"]),
    //        double.parse(Get.find<LocationController>().getAddress["longtitude"]));
    //     _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
    //   }
    // }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: CameraPosition(
                      target: _initalPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition){
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: (){
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController){
                      _mapController = mapController;
                    },
                  ),
                  Center(
                    child: !locationController.loading? Image.asset("assets/images/pick_marker.png", height: 50, width: 50)
                    : CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimenstions.height15*3,
                    left: Dimenstions.width20,
                    right: Dimenstions.width20,
                    child: InkWell(
                      onTap: () => Get.dialog(LocationDialogue(mapController: _mapController)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimenstions.width10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.teal[400],
                          borderRadius: BorderRadius.circular(Dimenstions.radius20/2)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on,size: 25, color: AppColors.yellow30),
                            Expanded(child: Text(
                              '${locationController.pickPlacemark.name??""}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimenstions.font20
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                            SizedBox(width: Dimenstions.width10),
                            const Icon(Icons.search, size: 25, color: AppColors.yellow30),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 80,
                      left: Dimenstions.width20,
                      right: Dimenstions.width20,
                      child: locationController.isLoading?
                      Center(child: CircularProgressIndicator()):
                      CustomButton(
                        buttonText: locationController.inZone?widget.fromAddress? "Pick address" : "Pick Location" : "Service is not available in your area" ,
                        onPressed: (locationController.buttonDisable || locationController.loading)?null: (){
                          if(locationController.pickPosition.latitude!=0&&
                              locationController.pickPlacemark.name!=null){
                            if(widget.fromAddress){
                              if(widget.googleMapController!=null){
                                // widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                                //     locationController.pickPosition.latitude,
                                //     locationController.pickPosition.longitude
                                // ))));
                                locationController.setAddAddressData();
                              }
                              var pickPosition = locationController.pickPosition;
                              Get.offNamed(RouteHelper.getAddressPage(lat:  pickPosition.latitude,long: pickPosition.longitude));
                            }
                          }
                        },
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
