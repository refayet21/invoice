import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice/app/modules/login/views/login_view.dart';
import 'package:invoice/model/user_model.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  SignupController _controller = Get.put(SignupController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
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
                    obscureText: _controller.passwordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _controller.passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          _controller.togglePasswordVisibility();
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
                    try {
                      await SignupController.signup(
                          _emailController.text, _passwordController.text);
                      // await SignupController.addUser(UserModel(
                      //     userId: controller.authUser!.uid,
                      //     email: _emailController.text));
                      Get.to(LoginView());
                    } catch (e) {
                      // Handle signup errors
                      print('Signup Error: $e');
                    }
                  }
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Get.to(LoginView());
                },
                child: Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
