import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:invoice/app/modules/login/views/login_view.dart';
import 'package:invoice/app/modules/preview/views/preview_view.dart';
import 'package:invoice/app/modules/vendor/views/vendor_view.dart';
import 'package:invoice/model/vendor_model.dart';

import '../controllers/home_controller.dart';

// class HomeView extends GetView<HomeController> {
//   HomeController homeController = Get.put(HomeController());
//   TextEditingController dateController = TextEditingController();
//   VendorModel? selectedVendor;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HomeView'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () {
//               HomeController
//                   .logout(); // Call the logout method from HomeController
//               Get.to(() => LoginView()); // Redirect to the LoginView
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             DropdownButtonFormField<VendorModel>(
//               onChanged: (value) {
//                 selectedVendor = value;
//               },
//               decoration: InputDecoration(
//                 labelText: 'Select Vendor',
//                 border: OutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//               ),
//               isExpanded: true,
//               value: selectedVendor,
//               items: homeController.vendors
//                   .map((vendor) => DropdownMenuItem<VendorModel>(
//                         value: vendor,
//                         child: Text(vendor.name ?? 'N/A'),
//                       ))
//                   .toList(),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Get.to(() => VendorView());
//               },
//               icon: Icon(Icons.add),
//               label: Text('Add Vendor'),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: dateController,
//               decoration: InputDecoration(
//                 labelText: "Enter Date",
//                 prefixIcon: Icon(Icons.calendar_today),
//                 border: OutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//               ),
//               readOnly: true,
//               onTap: () {
//                 selectDate(context);
//               },
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Product Name',
//                 border: OutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Product price',
//                 border: OutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Product quantity',
//                 border: OutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Address',
//                 border: OutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   String vendorInfo =
//                       'Vendor Name: ${selectedVendor?.name ?? "N/A"}';
//                   String dateInfo = 'Date: ${dateController.text}';

//                   print('vendorInfo $vendorInfo  dateInfo $dateInfo');
//                 },
//                 child: Text('Invoice'))
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != DateTime.now()) {
//       String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
//       dateController.text = formattedDate;
//     }
//   }
// }

class HomeView extends GetView<HomeController> {
  HomeController homeController = Get.put(HomeController());
  TextEditingController dateController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  VendorModel? selectedVendor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              HomeController
                  .logout(); // Call the logout method from HomeController
              Get.to(() => LoginView()); // Redirect to the LoginView
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // DropdownButtonFormField<VendorModel>(
              //   onChanged: (value) {
              //     selectedVendor = value;
              //   },
              //   decoration: InputDecoration(
              //     labelText: 'Select Vendor',
              //     border: OutlineInputBorder(),
              //     contentPadding:
              //         EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              //   ),
              //   isExpanded: true,
              //   value: selectedVendor,
              //   items: homeController.vendors
              //       .map((vendor) => DropdownMenuItem<VendorModel>(
              //             value: vendor,
              //             child: Text(vendor.name ?? 'N/A'),
              //           ))
              //       .toList(),
              // ),

              Obx(
                () => DropdownButtonFormField<VendorModel>(
                  onChanged: (value) {
                    selectedVendor = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Vendor',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  ),
                  isExpanded: true,
                  value: selectedVendor,
                  items: homeController.vendors
                      .map((vendor) => DropdownMenuItem<VendorModel>(
                            value: vendor,
                            child: Text(vendor.name ?? 'N/A'),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => VendorView());
                },
                icon: Icon(Icons.add),
                label: Text('Add Vendor'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: "Enter Date",
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
                readOnly: true,
                onTap: () {
                  selectDate(context);
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: productNameController,
                decoration: InputDecoration(
                  hintText: 'Product Name',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: productPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Product Price',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: productQuantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Product Quantity',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: 'Address',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                // onPressed: () {
                //   String vendorInfo =
                //       'Vendor Name: ${selectedVendor?.name ?? "N/A"}';
                //   String dateInfo = 'Date: ${dateController.text}';
                //   String productInfo =
                //       'Product Name: ${productNameController.text}';
                //   String priceInfo = 'Price: ${productPriceController.text}';
                //   String quantityInfo =
                //       'Quantity: ${productQuantityController.text}';
                //   String addressInfo = 'Address: ${addressController.text}';

                //   print(
                //     '$vendorInfo\n$dateInfo\n$productInfo\n$priceInfo\n$quantityInfo\n$addressInfo',
                //   );

                //   homeController.generateInvoicePDF(vendorInfo);
                // },
                onPressed: () async {
                  // Get the selected vendor, date, product details from the controllers
                  String vendorInfo =
                      'Vendor Name: ${selectedVendor?.name ?? "N/A"}';
                  final date = dateController.text;
                  final productName = productNameController.text;
                  final productPrice =
                      double.parse(productPriceController.text);
                  final productQuantity =
                      int.parse(productQuantityController.text);

                  // Call the generateInvoicePDF method
                  homeController.generateInvoicePdf(vendorInfo, date,
                      productName, productPrice, productQuantity);
                },
                child: Text('Invoice'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
      dateController.text = formattedDate;
    }
  }
}
