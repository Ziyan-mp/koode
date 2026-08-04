import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../../../widgets/common/primary_button.dart';
import '../dashboard/admin_dashboard_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _adminIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _adminIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            // 1. Wrapped the Column inside a Form and attached the _formKey
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Admin Login",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 2. Added the validator for the Admin ID (Email Format)
                  CustomTextField(
                    labelText: "Admin ID",
                    hintText: "admin@campus.edu",
                    controller: _adminIdController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Admin ID';
                      }
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  
                  // 3. Added the validator for the Password (8+ characters)
                  CustomTextField(
                    labelText: "Password",
                    hintText: "Password",
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  PrimaryButton(
                    text: "Login Securely",
                    onPressed: () {
                      // 1. Check if the email and password pass the rules
                      if (_formKey.currentState!.validate()) {
                        
                        // 2. If everything is correct, navigate to the Admin Dashboard!
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminDashboardScreen(), 
                          ),
                        );
                        
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Admin Password?",
                      style: TextStyle(color: AppColors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Back to Portal",
                      style: TextStyle(color: AppColors.secondary),
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
}