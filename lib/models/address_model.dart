class AddressModel{
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longtitude;

  AddressModel({
    id, required addressType, contactPersonName, contactPersonNumber,
    address, latitude, longtitude}){
    _id= id;
    _address = address;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _latitude = latitude;
    _longtitude = longtitude;
    _contactPersonNumber = contactPersonNumber;
  }

  String get address => _address;
  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;
  String get latitude => _latitude;
  String get longtitude => _longtitude;


  AddressModel.fromJson(Map<String, dynamic> json){
    _id = json['id'];
    _addressType = json['address_type']??"";
    _contactPersonNumber = json["contact_person_number"]??"";
    _contactPersonName = json["contact_person_name"]??"";
    _address = json["address"];
    _latitude = json["latitude"];
    _longtitude = json["longtitude"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this._id;
    data["address_type"] = this.addressType;
    data["contact_person_number"] = this.contactPersonNumber;
    data["contact_person_name"] = this.contactPersonName;
    data["longtitude"] = this._longtitude;
    data["address"] = this._address;
    data["latitude"] = this._latitude;
    return data;
  }

}