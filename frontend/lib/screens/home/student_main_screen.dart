import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../complaints/my_complaints_screen.dart';
import '../notes/notes_screen.dart';
import '../profile/profile_screen.dart';
import 'home_screen.dart';

/// Main container screen for students after authentication.
/// Manages tab navigation using an IndexedStack to preserve state.
class StudentMainScreen extends StatefulWidget {
  const StudentMainScreen({super.key});

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  // Currently active tab index (0: Home, 1: Complaints, 2: Notes, 3: Profile)
  int _selectedIndex = 0;

  /// Updates selected tab index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pages corresponding to each BottomNavigationBar tab (Home, Complaints, Notes, Profile)
    final List<Widget> pages = [
      HomeScreen(
        onFileComplaintTap: () => _onItemTapped(1),
        onAcademicsTap: () => _onItemTapped(2),
      ),
      const MyComplaintsScreen(),
      const NotesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      // IndexedStack preserves state across tab switches
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),

      // Material 3 Styled Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              activeIcon: Icon(Icons.assignment),
              label: 'Complaints',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_alt_outlined),
              activeIcon: Icon(Icons.note_alt),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
