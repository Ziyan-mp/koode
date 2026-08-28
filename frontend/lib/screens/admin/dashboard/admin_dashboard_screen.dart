import 'package:flutter/material.dart';
import '../complaints/admin_complaints_screen.dart';
import '../settings/admin_settings_screen.dart';
import '../users/manage_users_screen.dart';
import '../banner/manage_spotlight_banner_dialog.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // Temporary frontend complaint data.
  // This can later be replaced with data from the Django API.
  final List<Map<String, String>> _complaints = [
    {
      'title': 'Infrastructure Issue - Block B',
      'time': '2h ago',
    },
    {
      'title': 'Feedback - Library Services',
      'time': '2h ago',
    },
    {
      'title': 'Feedback - Queans - Block B',
      'time': '2h ago',
    },
  ];

  void _deleteComplaint(int index) {
    final deletedComplaint = _complaints[index];

    setState(() {
      _complaints.removeAt(index);
    });

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${deletedComplaint['title']} deleted',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E7ED),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ---------------------------------------------------------
              // 1. BRANDING HEADER
              // ---------------------------------------------------------

              const Text(
                "AN INITIATIVE OF UDSF CEV",
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF004D61),
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              // Current Koode logo text
              // We can replace this with the actual logo asset later.
              const Text(
                "കൂടെ",
                style: TextStyle(
                  fontSize: 64,
                  color: Color(0xFF7B8BB2),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                "your voice your campus",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF004D61),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Admin Dashboard",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF004D61),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // ---------------------------------------------------------
              // 2. STAT CARDS
              // ---------------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      Icons.people,
                      "Total Users",
                      "12,850",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard(
                      Icons.campaign,
                      "Active Complaints",
                      "145",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      Icons.calendar_today,
                      "Pending Reviews",
                      "32",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard(
                      Icons.location_city,
                      "Campus Units",
                      "28",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ---------------------------------------------------------
              // 3. RECENT COMPLAINTS & FEEDBACK
              // ---------------------------------------------------------

              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Recent Complaints & Feedback",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004D61),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF004D61),
                    width: 1,
                  ),
                ),
                child: _complaints.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(
                          child: Text(
                            "No complaints or feedback",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF004D61),
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: List.generate(
                          _complaints.length,
                          (index) {
                            final complaint = _complaints[index];

                            return Column(
                              children: [
                                _buildComplaintTile(
                                  title: complaint['title'] ?? '',
                                  time: complaint['time'] ?? '',
                                  onDelete: () =>
                                      _deleteComplaint(index),
                                ),

                                if (index != _complaints.length - 1)
                                  const Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
              ),

              const SizedBox(height: 24),

              // ---------------------------------------------------------
              // 4. QUICK ACTIONS
              // ---------------------------------------------------------

              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004D61),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                children: [
                  _buildActionPill(
                    context,
                    "Manage Users",
                    const ManageUsersScreen(),
                  ),

                  _buildActionPill(
                    context,
                    "Review Complaints",
                    const AdminComplaintsScreen(),
                    isPrimary: true,
                  ),

                  _buildActionPill(
                    context,
                    "System Settings",
                    const AdminSettingsScreen(),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ---------------------------------------------------------
              // 5. ADD BANNER BUTTON
              // ---------------------------------------------------------

              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          const ManageSpotlightBannerDialog(),
                    );
                  },
                  icon: const Text(
                    "add",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  label: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ---------------------------------------------------------
              // 6. FOOTER
              // ---------------------------------------------------------

              TextButton(
                onPressed: () {
                  // Logout functionality can be connected here later.
                },
                child: const Text(
                  "Log Out Admin",
                  style: TextStyle(
                    color: Color(0xFF004D61),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "© powered by UDSF CEV",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF004D61),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // STAT CARD
  // -------------------------------------------------------------------

  Widget _buildStatCard(
    IconData icon,
    String title,
    String count,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF004D61),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: const Color(0xFF004D61),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF004D61),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            count,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D61),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // COMPLAINT TILE
  // -------------------------------------------------------------------

  Widget _buildComplaintTile({
    required String title,
    required String time,
    required VoidCallback onDelete,
  }) {
    return ListTile(
      leading: const Icon(
        Icons.person,
        color: Color(0xFF004D61),
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF004D61),
        ),
      ),

      subtitle: Text(
        time,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF004D61),
        ),
      ),

      // DELETE BUTTON
      trailing: IconButton(
        tooltip: "Delete",
        onPressed: onDelete,
        icon: const Icon(
          Icons.delete_outline,
          color: Color(0xFF004D61),
          size: 22,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // QUICK ACTION PILL
  // -------------------------------------------------------------------

 Widget _buildActionPill(
  BuildContext context,
  String title,
  Widget targetScreen, {
  bool isPrimary = false,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF009688),
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => targetScreen,
        ),
      );
    },
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
    ),
  );
}
}