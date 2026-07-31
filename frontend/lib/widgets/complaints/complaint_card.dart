import 'package:flutter/material.dart';

class ComplaintCard extends StatelessWidget {
  const ComplaintCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        title: Text('Complaint Card'),
      ),
    );
  }
}
