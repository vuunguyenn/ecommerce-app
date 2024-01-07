import 'dart:convert';

import 'package:e_commercee_app/data/api/api_checked.dart';
import 'package:e_commercee_app/data/repository/location_repo.dart';
import 'package:e_commercee_app/models/address_model.dart';
import 'package:e_commercee_app/models/response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:mapbox_search/mapbox_search.dart';
class LocationController extends GetxController implements GetxService{
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});
  bool _loading = false;

  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark _pickPlacemark = Placemark();
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;

  List<String> _addressTypeList = ["home", "office", "others"];
  int _addressTypeIndex = 0;

  int get addressTypeIndex => _addressTypeIndex;
  List<String> get addressTypeList => _addressTypeList;

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _inZone = false;
  bool get inZone => _inZone;

  bool _buttonDisable = true;
  bool get buttonDisable => _buttonDisable;

  List<Suggestion> _suggestionList = [];

  void setMapController(GoogleMapController mapController){
    _mapController = mapController;
  }

  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
    if(_updateAddressData){
      _loading = true;
      update();
      try{
        if(fromAddress) {
          _position =  Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1, altitudeAccuracy: 1, headingAccuracy: 1
          );
        }
        else{
          _pickPosition =  Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1, altitudeAccuracy: 1, headingAccuracy: 1
          );
        }
        ResponseModel _responseModel =
          await getZone(position.target.latitude.toString(), position.target.longitude.toString(), false);
        _buttonDisable = !_responseModel.isSuccess;
        if(_changeAddress) {
          String _address = await getAddressFromGeocode(
            LatLng(position.target.latitude, position.target.longitude)
          );

          fromAddress?{
            _placemark = Placemark(name: _address)
          }
        :
          _pickPlacemark = Placemark(name: _address);
          print('111');
        }
        else{
          _changeAddress = true;
          print('333');
        }
      }catch(e){
        print(e);
      }
      _loading = false;
      update();
    }else{
      print("updateAddressData = false");
      _updateAddressData = true;
    }

  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = "Unknow location Found";
    http.Response response = await locationRepo.getAddressFromGeocode(latLng);

    if(response.statusCode == 200){
      print('222');
      print(response.body);
      _address = response.body;
    }
    else{
      print("Error getting the google api");
    }
    update();
    return _address;
  }

  AddressModel getUserAddress(){
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try{
      _addressModel = AddressModel.fromJson(_getAddress);
    }catch(e){
      print(e);
    }
    return _addressModel;

  }
  void setAddressTypeIndex(int index){
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    bool status = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if(status){
      await getAddressList();
      String message = "successfully add address";
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    }else{
      print("couldn't save the address");
      responseModel =ResponseModel(false, "Save address failure");
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    final data = await locationRepo.getAllAddress();
    if(data != null){
      final address = data.entries.map((e) =>e.value);
      _addressList = [];
      _allAddressList =[];
      address.forEach((ad) {
        _addressList.add(AddressModel.fromJson(ad));
        _allAddressList.add(AddressModel.fromJson(ad));
      });
    }else{
      _addressList=[];
      _allAddressList=[];
    }
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList(){
    _addressList =[];
    _allAddressList =[];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData(){
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }
  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if(markerLoad){
      _loading = true;
    }else{
      _isLoading = true;
    }
    update();
    // Response response = await locationRepo.getZone(lat, lng);
    // if(response.statusCode == 200){
    //   _inZone = true;
    //   _responseModel = ResponseModel(true, response.body.toString());
    // }else{
    //   _inZone = false;
    //   _responseModel = ResponseModel(false, response.statusText!);
    // }
    _inZone = true;
    _responseModel = ResponseModel(true, "address is in serviced zone");
    if(markerLoad){
      _loading = false;
    }else{
      _isLoading = false;
    }
    update();
    return _responseModel;
  }

  Future<List<Suggestion>> searchLocation(BuildContext context, String text) async {
    if(text.isNotEmpty){
      http.Response response = await locationRepo.searchLocation(text);
      if(response.statusCode == 200){
        _suggestionList = [];
        jsonDecode(response.body)["suggestions"].forEach((suggestion) => _suggestionList.add(Suggestion.fromJson(suggestion)));
      }else{
        ApiChecker.checkApi(response);
      }
    }
    return _suggestionList;
  }
  setLocation(String placeId, String address, GoogleMapController mapController) async {
    _loading = true;
    update();
    Feature detail;
    http.Response response = await locationRepo.setLocation(placeId);
    detail = Feature.fromJson(jsonDecode(response.body)['features'][0]);
    _pickPosition = Position(
      latitude: detail.geometry.coordinates.lat,
      longitude: detail.geometry.coordinates.long,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1, altitudeAccuracy: 1,headingAccuracy: 1
    );
    _pickPlacemark = Placemark(name: address);
    _changeAddress = false;
    if(mapController != null){
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(
          detail.geometry.coordinates.lat,
            detail.geometry.coordinates.long
        ), zoom: 17)
      ));
    }
    _loading = false;
    update();
  }



}