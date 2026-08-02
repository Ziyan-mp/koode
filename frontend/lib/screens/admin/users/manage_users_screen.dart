import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Manage Users",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                  child: const Icon(Icons.person, color: AppColors.primary),
                ),
                title: Text(
                  "Student User #${index + 1}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("student${index + 1}@campus.edu"),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    // Handle user actions (View, Suspend, Delete)
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: "view",
                      child: Text("View Details"),
                    ),
                    const PopupMenuItem(
                      value: "suspend",
                      child: Text("Suspend Account"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}