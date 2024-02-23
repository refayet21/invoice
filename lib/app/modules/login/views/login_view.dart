// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:invoice/app/modules/home/views/home_view.dart';
// import 'package:invoice/app/modules/signup/views/signup_view.dart';

// import '../controllers/login_controller.dart';

// class LoginView extends GetView<LoginController> {
//   LoginView({Key? key}) : super(key: key);
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Page'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: emailcontroller,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   // Add more email validation if necessary
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20.0),
//               Obx(() => TextFormField(
//                     controller: passwordcontroller,
//                     obscureText: controller.passwordVisible.value,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           controller.passwordVisible.value
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                         ),
//                         onPressed: () {
//                           controller.togglePasswordVisibility();
//                         },
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       // Add more password validation if necessary
//                       return null;
//                     },
//                   )),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     LoginController.login(
//                         emailcontroller.text, passwordcontroller.text);
//                   }
//                   Get.offAll(() => HomeView());
//                 },
//                 child: Text('Login'),
//               ),
//               SizedBox(height: 10.0),
//               TextButton(
//                 onPressed: () {
//                   Get.to(() => SignupView());
//                 },
//                 child: Text('Go to Signup'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice/app/modules/home/views/home_view.dart';
import 'package:invoice/app/modules/signup/views/signup_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add more email validation if necessary
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Obx(() => TextFormField(
                    controller: _passwordController,
                    obscureText: !controller.passwordVisible.value,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // Add more password validation if necessary
                      return null;
                    },
                  )),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    try {
                      final userExists =
                          await controller.checkUserExists(email);
                      if (userExists) {
                        await controller.login(email, password);
                        Get.offAll(HomeView());
                      } else {
                        Get.snackbar(
                          'Error',
                          'User does not exist.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    } catch (e) {
                      // Handle login errors
                      print('Login Error: $e');
                    }
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Get.to(() => SignupView());
                },
                child: Text('Go to Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
