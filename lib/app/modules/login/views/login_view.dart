import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:invoice/app/modules/signup/views/signup_view.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
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
                  obscureText: controller.passwordVisible.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.passwordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        controller.togglePasswordVisibility();
                      },
                    ),
                  ),
                )),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement login functionality here
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Get.to(() => SignupView());
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
