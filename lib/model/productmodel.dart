import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? docId;
  String? name;
  String? unit;
  int? pPrice;
  int? sPrice;
  int? stock;
  int quantity;

  ProductModel({
    this.docId,
    this.name,
    this.unit,
    this.pPrice,
    this.sPrice,
    this.stock,
    this.quantity = 1,
  });

  // Convert DocumentSnapshot to ProductModel object
  ProductModel.fromJson(DocumentSnapshot data)
      : docId = data.id,
        name = data["name"] as String?,
        unit = data["unit"] as String?,
        pPrice = data["p_price"] as int?,
        sPrice = data["s_price"] as int?,
        stock = data["stock"] as int?,
        quantity = 1;

  // Convert ProductModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'unit': unit,
      'p_price': pPrice,
      's_price': sPrice,
      'stock': stock,
      'quantity': quantity,
    };
  }
}
