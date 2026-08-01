import 'package:flutter/material.dart';
import '../complaints/admin_complaints_screen.dart';
import '../settings/admin_settings_screen.dart';
import '../users/manage_users_screen.dart';
import '../banner/manage_spotlight_banner_dialog.dart'; // Links your new folder!

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E7ED), // Light blue-grey background from Image 3
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Branding Header
              const Text(
                "AN INITIATIVE OF UDSF CEV",
                style: TextStyle(fontSize: 10, color: Color(0xFF004D61), letterSpacing: 1.2),
              ),
              const SizedBox(height: 8),
              // Malayalam Logo Text placeholder
              const Text(
                "കൂടെ",
                style: TextStyle(fontSize: 64, color: Color(0xFF7B8BB2), fontWeight: FontWeight.bold),
              ),
              const Text(
                "your campus",
                style: TextStyle(fontSize: 14, color: Color(0xFF004D61)),
              ),
              const SizedBox(height: 12),
              const Text(
                "Admin Dashboard",
                style: TextStyle(fontSize: 18, color: Color(0xFF004D61), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // 2. Stat Cards (With icons and borders)
              Row(
                children: [
                  Expanded(child: _buildStatCard(Icons.people, "Total Users", "12,850")),
                  const SizedBox(width: 8),
                  Expanded(child: _buildStatCard(Icons.campaign, "Active Complaints", "145")),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _buildStatCard(Icons.calendar_today, "Pending Reviews", "32")),
                  const SizedBox(width: 8),
                  Expanded(child: _buildStatCard(Icons.location_city, "Campus Units", "28")),
                ],
              ),
              const SizedBox(height: 24),

              // 3. Recent Complaints Section
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Recent Complaints & Feedback",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF004D61)),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF004D61), width: 1),
                ),
                child: Column(
                  children: [
                    _buildComplaintTile("Infrastructure Issue - Block B", "2h ago", "Pending"),
                    const Divider(height: 1, color: Colors.grey),
                    _buildComplaintTile("Feedback - Library Services", "2h ago", "In Progress"),
                    const Divider(height: 1, color: Colors.grey),
                    _buildComplaintTile("Feedback - Queans - Block B", "2h ago", "Pending"),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4. Quick Actions
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Quick Actions",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF004D61)),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                children: [
                  _buildActionPill(context, "Manage Users", const ManageUsersScreen()),
                  _buildActionPill(context, "Review Complaints", const AdminComplaintsScreen(), isPrimary: true),
                  _buildActionPill(context, "System Settings", const AdminSettingsScreen()),
                ],
              ),
              const SizedBox(height: 16),

              // 5. Add Banner Button (The "add +" button)
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688), // Teal color
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    // Opens your new Manage Spotlight Banner Dialog!
                    showDialog(
                      context: context,
                      builder: (context) => const ManageSpotlightBannerDialog(),
                    );
                  },
                  icon: const Text("add", style: TextStyle(color: Colors.white, fontSize: 16)),
                  label: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(height: 40),

              // 6. Footer
              TextButton(
                onPressed: () {},
                child: const Text("Log Out Admin", style: TextStyle(color: Color(0xFF004D61), decoration: TextDecoration.underline)),
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(color: Color(0xFF004D61)),
              const SizedBox(height: 16),
              const Text("© powered by UDSF CEV", style: TextStyle(fontSize: 12, color: Color(0xFF004D61))),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Stat Cards
  Widget _buildStatCard(IconData icon, String title, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF004D61), width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: const Color(0xFF004D61)),
              const SizedBox(width: 4),
              Text(title, style: const TextStyle(fontSize: 11, color: Color(0xFF004D61))),
            ],
          ),
          const SizedBox(height: 8),
          Text(count, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D61))),
        ],
      ),
    );
  }

  // Helper Widget for Complaint List
  Widget _buildComplaintTile(String title, String time, String status) {
    return ListTile(
      leading: const Icon(Icons.person, color: Color(0xFF004D61)),
      title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D61))),
      subtitle: Text(time, style: const TextStyle(fontSize: 11, color: Color(0xFF004D61))),
      trailing: Text(
        status,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: status == "Pending" ? const Color(0xFF004D61) : const Color(0xFF009688)),
      ),
    );
  }

  // Helper Widget for Quick Action Pills
  Widget _buildActionPill(BuildContext context, String title, Widget targetScreen, {bool isPrimary = false}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? const Color(0xFF009688) : Colors.grey.shade400,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => targetScreen));
      },
      child: Text(title, style: TextStyle(color: isPrimary ? Colors.white : Colors.black87, fontSize: 13)),
    );
  }
}