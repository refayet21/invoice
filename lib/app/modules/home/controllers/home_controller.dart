import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:invoice/app/modules/preview/views/preview_view.dart';
import 'package:invoice/app/modules/vendor/controllers/vendor_controller.dart';
import 'package:invoice/model/vendor_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController {
  RxList<VendorModel> vendors = RxList<VendorModel>([]);
  VendorController vendorAddController = Get.put(VendorController());
  late CollectionReference collectionReference;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<void> logout() {
    return _auth.signOut();
  }

  Stream<List<VendorModel>> getAllVendors() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => VendorModel.fromJson(item)).toList());

  // Dropdown options
  List<String> dropdownOptions = ['Product 1', 'Product 2', 'Product 3'];

  // Getter method for dropdown options
  List<String> getDropdownOptions() {
    return dropdownOptions;
  }

  // void generateInvoicePDF(String? vendor, String? date, String? productName,
  //     double? productPrice, int? productQuantity) {
  //   final pdf = pw.Document();

  //   // Calculate total price
  //   final totalPrice = productPrice! * productQuantity!;

  //   // Add page to PDF
  //   pdf.addPage(
  //     pw.MultiPage(
  //       header: (pw.Context context) {
  //         return pw.Container(
  //           alignment: pw.Alignment.center,
  //           margin: pw.EdgeInsets.only(bottom: 20.0),
  //           child: pw.Column(
  //             children: [
  //               pw.Text(
  //                 'Invoice',
  //                 style: pw.TextStyle(
  //                     fontSize: 20.0, fontWeight: pw.FontWeight.bold),
  //               ),
  //               pw.SizedBox(height: 10.0),
  //               pw.Text('Vendor: ${vendor}',
  //                   style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //               pw.Text('Date: $date',
  //                   style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //             ],
  //           ),
  //         );
  //       },
  //       build: (pw.Context context) {
  //         return <pw.Widget>[
  //           // Invoice body
  //           pw.Table.fromTextArray(
  //             context: context,
  //             cellAlignment: pw.Alignment.centerLeft,
  //             headerAlignment: pw.Alignment.centerLeft,
  //             headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
  //             cellStyle: const pw.TextStyle(),
  //             headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
  //             headers: <String>['Product Name', 'Price', 'Quantity'],
  //             data: <List<String>>[
  //               [
  //                 productName!,
  //                 productPrice.toString(),
  //                 productQuantity.toString()
  //               ],
  //             ],
  //           ),
  //           // Summary section
  //           pw.Divider(),
  //           pw.Row(
  //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //             children: [
  //               pw.Text('Total Price:',
  //                   style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //               pw.Text(totalPrice.toStringAsFixed(2)),
  //             ],
  //           ),
  //           pw.Row(
  //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //             children: [
  //               pw.Text('Total Quantity:',
  //                   style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //               pw.Text(productQuantity.toString()),
  //             ],
  //           ),
  //         ];
  //       },
  //     ),
  //   );

  //   // Save the PDF file
  //   savePDF(pdf);
  // }

  // Function to save PDF
  // void savePDF(pw.Document pdf) {
  //   final bytes = pdf.save();
  // }

  Future<void> generateInvoicePdf(String vendorName, String date,
      String productName, double productPrice, int productQuantity) async {
    final doc = pw.Document();
    try {
      // Load fonts
      final fontData = await rootBundle.load("assets/fonts/robotoregular.ttf");
      final ttf = pw.Font.ttf(fontData);

      // Invoice Header
      final header = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Column(
          children: [
            pw.Text(
              'Invoice',
              style: pw.TextStyle(
                fontSize: 20.0,
                fontWeight: pw.FontWeight.bold,
                font: ttf,
              ),
            ),
            pw.SizedBox(height: 10.0),
            pw.Text(
              '$vendorName',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                font: ttf,
              ),
            ),
            pw.Text(
              'Date: $date',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                font: ttf,
              ),
            ),
          ],
        ),
      );

      // Invoice Body
      final body = pw.Container(
        child: pw.Table.fromTextArray(
          context: null,
          cellAlignment: pw.Alignment.centerLeft,
          headerAlignment: pw.Alignment.centerLeft,
          headerStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            font: ttf,
          ),
          cellStyle: pw.TextStyle(),
          headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
          headers: <String>['Product Name', 'Price', 'Quantity'],
          data: <List<String>>[
            [productName, productPrice.toString(), productQuantity.toString()],
          ],
        ),
      );

      // Calculate total price
      final totalPrice = productPrice * productQuantity;

      // Invoice Footer
      final footer = pw.Container(
        alignment: pw.Alignment.centerRight,
        child: pw.Column(
          children: [
            pw.Text(
              'Total Price: $totalPrice',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                font: ttf,
              ),
            ),
          ],
        ),
      );

      // Add pages to the PDF document
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(
            base: ttf,
          ),
          build: (pw.Context context) {
            // return  [
            //   header,
            //   body,
            //   footer,
            // ];

            return pw.Expanded(
              child: pw.Padding(
                padding: pw.EdgeInsets.all(10),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    header,
                    body,
                    footer,
                  ],
                ),
              ),
            );
          },
        ),
      );

      Get.to(() => PreviewView(doc: doc));
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();

    vendors = vendorAddController.vendors;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
