import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  String? docId;
  String? name;
  String? address;
  String? mobile;
  int? balance;

  VendorModel({this.docId, this.name, this.address, this.mobile, this.balance});

  VendorModel.fromJson(DocumentSnapshot data) {
    docId = data.id;
    name = data["name"] as String?;
    address = data["address"] as String?;
    mobile = data["mobile"] as String?;
    balance = data["balance"] as int?;
  }

  // Convert VendorModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'address': address,
      'mobile': mobile,
      'balance': balance,
    };
  }
}
