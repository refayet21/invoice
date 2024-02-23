import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:invoice/app/modules/login/controllers/login_controller.dart';
import 'package:invoice/app/modules/login/views/login_view.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  LoginController logincontroller = Get.put(LoginController());
  SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Obx(() => TextFormField(
                  obscureText: logincontroller.passwordVisible.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        logincontroller.passwordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        logincontroller.togglePasswordVisibility();
                      },
                    ),
                  ),
                )),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement sign up functionality here
              },
              child: Text('Sign Up'),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Get.to(() => LoginView());
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
