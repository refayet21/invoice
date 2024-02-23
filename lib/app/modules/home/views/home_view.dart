import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:invoice/app/modules/login/views/login_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
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
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
