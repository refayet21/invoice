import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:invoice/app/modules/home/views/home_view.dart';

import '../controllers/vendor_controller.dart';

class VendorView extends GetView<VendorController> {
  VendorController controller = Get.put(VendorController());
  VendorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(() => HomeView());
          },
          // color: Colors.black,
        ),
        title: Text(
          'Vendor',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.searchVendor(value),
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.foundVendor.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    title: Text(
                      'Name : ${controller.foundVendor[index].name!}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    // subtitle: Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     SizedBox(
                    //       height: 3,
                    //     ),
                    //     Text(
                    //       'Address :${controller.foundVendor[index].address!}',
                    //       style: TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w600,
                    //           color: Colors.black),
                    //     ),
                    //     SizedBox(
                    //       height: 3,
                    //     ),
                    //     Text(
                    //       'Mobile : ${controller.foundVendor[index].mobile!}',
                    //       style: TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w600,
                    //           color: Colors.black),
                    //     ),
                    //     SizedBox(
                    //       height: 3,
                    //     ),
                    //     Text(
                    //       'Balance : ${controller.foundVendor[index].balance.toString()}',
                    //       style: TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w600,
                    //           color: Colors.black),
                    //     ),
                    //   ],
                    // ),
                    leading: CircleAvatar(
                      child: Text(
                        controller.foundVendor[index].name!
                            .substring(0, 1)
                            .capitalize!,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                      backgroundColor: Colors.blue.shade200,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        displayDeleteDialog(
                            controller.foundVendor[index].docId!);
                      },
                    ),
                    onTap: () {
                      controller.nameController.text =
                          controller.foundVendor[index].name!;
                      // controller.addressController.text =
                      //     controller.foundVendor[index].address!;
                      // controller.mobileController.text =
                      //     controller.foundVendor[index].mobile!;
                      // controller.balanceController.text =
                      //     controller.foundVendor[index].balance!.toString();
                      _buildAddEditVendorView(
                          text: 'UPDATE',
                          addEditFlag: 2,
                          docId: controller.foundVendor[index].docId!);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            _buildAddEditVendorView(text: 'ADD', addEditFlag: 1, docId: '');
          },
          child: Text('Add Vendor')),
    );
  }

  _buildAddEditVendorView({String? text, int? addEditFlag, String? docId}) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.blue.shade200),
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${text} Vendor',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.nameController,
                    // validator: (value) {
                    //   return controller.validateName(value!);
                    // },
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // TextFormField(
                  //   keyboardType: TextInputType.multiline,
                  //   decoration: InputDecoration(
                  //     hintText: 'address',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  //   controller: controller.addressController,
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // TextFormField(
                  //   keyboardType: TextInputType.multiline,
                  //   decoration: InputDecoration(
                  //     hintText: 'Mobile',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  //   controller: controller.mobileController,
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // TextFormField(
                  //   readOnly: false,
                  //   keyboardType: TextInputType.multiline,
                  //   decoration: InputDecoration(
                  //     hintText: 'Balance',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  //   controller: controller.balanceController,
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: Get.context!.width, height: 45),
                    child: ElevatedButton(
                      child: Text(
                        text!,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      onPressed: () {
                        controller.saveUpdateVendor(
                          controller.nameController.text,
                          // controller.addressController.text,
                          // controller.mobileController.text,
                          // int.parse(controller.balanceController.text),
                          null, null, null,
                          docId!,
                          addEditFlag!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  displayDeleteDialog(String docId) {
    Get.defaultDialog(
      title: "Delete Vendor",
      titleStyle: TextStyle(fontSize: 20),
      middleText: 'Are you sure to delete Vendor ?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.black,
      onCancel: () {},
      onConfirm: () {
        controller.deleteData(docId);
      },
    );
  }
}
