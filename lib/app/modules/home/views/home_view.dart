// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:invoice/app/modules/login/views/login_view.dart';
// import 'package:invoice/app/modules/vendor/views/vendor_view.dart';
// import 'package:invoice/model/vendor_model.dart';

// import '../controllers/home_controller.dart';

// class HomeView extends GetView<HomeController> {
//   HomeController homecontroller = Get.put(HomeController());
//   HomeView({Key? key}) : super(key: key);
//   TextEditingController dateController = TextEditingController();
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
//       body: Column(
//         children: [
//           Row(
//             children: [
//               DropdownButtonFormField<VendorModel>(
//                 onChanged: (value) {
//                   selectedVendor = value;
//                 },
//                 hint: const Text('Select Vendor'),
//                 isExpanded: true,
//                 value: selectedVendor,
//                 items: homecontroller.vendors
//                     .map((vendor) => DropdownMenuItem<VendorModel>(
//                           value: vendor,
//                           child: Text(vendor.name ?? 'N/A'),
//                         ))
//                     .toList(),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     Get.to(() => VendorView());
//                   },
//                   child: Icon(Icons.add))
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: dateController,
//             decoration: InputDecoration(
//                 icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
//             readOnly: true,
//             onTap: () {
//               selectDate(context);
//             },
//           ),
//         ],
//       ),

//     );
//   }
// }

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:invoice/app/modules/login/views/login_view.dart';
import 'package:invoice/app/modules/vendor/views/vendor_view.dart';
import 'package:invoice/model/vendor_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController homeController = Get.put(HomeController());
  TextEditingController dateController = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<VendorModel>(
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
            ElevatedButton(
                onPressed: () {
                  String vendorInfo =
                      'Vendor Name: ${selectedVendor?.name ?? "N/A"}';
                  String dateInfo = 'Date: ${dateController.text}';

                  print('vendorInfo $vendorInfo  dateInfo $dateInfo');
                },
                child: Text('Invoice'))
          ],
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
