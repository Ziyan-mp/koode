import 'package:flutter/material.dart';
import 'dashboard/admin_dashboard_screen.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E7ED),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Branding Header
                const Text(
                  "AN INITIATIVE OF UDSF CEV",
                  style: TextStyle(fontSize: 10, color: Color(0xFF004D61), letterSpacing: 1.2),
                ),
                const SizedBox(height: 8),
                const Text(
                  "കൂടെ",
                  style: TextStyle(fontSize: 80, color: Color(0xFF7B8BB2), fontWeight: FontWeight.bold),
                ),
                const Text(
                  "your campus",
                  style: TextStyle(fontSize: 16, color: Color(0xFF004D61)),
                ),
                const SizedBox(height: 40),
                
                // Login Box
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF004D61), width: 1.5),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Admin Portal",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D61)),
                      ),
                      const SizedBox(height: 24),
                      
                      // Email Field
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Admin ID",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          prefixIcon: const Icon(Icons.person, color: Color(0xFF004D61)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Password Field
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          prefixIcon: const Icon(Icons.lock, color: Color(0xFF004D61)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF009688),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
                            );
                          },
                          child: const Text("Secure Login", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ), // <-- This is the parenthesis that was missing!
    );
  }
}