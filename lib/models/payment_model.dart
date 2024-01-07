class PaymentModel{
  String? name;
  String? price;
  int? quantity;
  late String currency;
  String status = "pending";
  PaymentModel({this.name,this.quantity,this.price,  required this.currency});

  PaymentModel.fromJson(Map<String, dynamic>json) {
    name = json["name"];
    currency = json["currency"];
    price = json["price"];
    quantity = json["quantity"];
  }

  Map<String, dynamic> toJson(){
    return {
      "name" : name,
      "quantity": quantity,
      "price": price,
      "currency": currency,
    };
  }
}