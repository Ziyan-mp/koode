import 'package:flutter/material.dart';

class AdminComplaintDetailsScreen extends StatefulWidget {
  final String complaintId;

  const AdminComplaintDetailsScreen({
    super.key,
    this.complaintId = 'C145B2',
  });

  @override
  State<AdminComplaintDetailsScreen> createState() =>
      _AdminComplaintDetailsScreenState();
}

class _AdminComplaintDetailsScreenState
    extends State<AdminComplaintDetailsScreen> {
  String selectedStatus = 'Pending';
  String selectedPriority = 'High';
  final TextEditingController _adminNotesController = TextEditingController();

  final List<String> statusOptions = ['Pending', 'In Progress', 'Resolved'];
  final List<String> priorityOptions = ['Low', 'Medium', 'High', 'Urgent'];

  @override
  void dispose() {
    _adminNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCBE2F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            children: [
              // Header Section
              Column(
                children: const [
                  Text(
                    'AN INITIATIVE OF UDSF CEV',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.2,
                      color: Color(0xFF4A5568),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'കൂടെ',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C5282),
                    ),
                  ),
                  Text(
                    'your voice your campus',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF2C5282),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Main Card Container
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFD6E8F6).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF4A5568), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Complaint Header ID
                    Center(
                      child: Text(
                        'Complaint Details - [${widget.complaintId}]',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Title & Time Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: _buildLabeledBox(
                            'Complaint Title',
                            'Infrastructure Issue - Block B',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Date/Time Submitted: 2h ago',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 2),
                              _buildSimpleBox('User #12,850'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Category & Location Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildLabeledBox(
                            'Category',
                            'Block B - Ground Floor, Common Area',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildLabeledBox(
                            'Location',
                            'Campus Infrastructure',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Status & Priority Dropdowns Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField(
                            label: 'Status',
                            value: selectedStatus,
                            items: statusOptions,
                            bgColor: Colors.orangeAccent,
                            onChanged: (val) =>
                                setState(() => selectedStatus = val!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDropdownField(
                            label: 'Priority',
                            value: selectedPriority,
                            items: priorityOptions,
                            bgColor: Colors.white,
                            onChanged: (val) =>
                                setState(() => selectedPriority = val!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Description Box
                    const Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black45),
                      ),
                      child: const Text(
                        'Reported issue of significant water leakage from the ceiling in the Block B common area, near the main entrance. This is causing slippery floors and potential electrical hazards. Requires immediate attention from maintenance.',
                        style: TextStyle(fontSize: 11, height: 1.3),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Evidence Section
                    const Text(
                      'Evidence',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black38),
                      ),
                      child: Stack(
                        children: [
                          const Center(
                            child: Icon(Icons.image,
                                size: 36, color: Colors.black54),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              color: Colors.white70,
                              padding: const EdgeInsets.all(1),
                              child: const Icon(Icons.article_outlined,
                                  size: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'leak_image_1.jpg',
                      style: TextStyle(fontSize: 10, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),

                    // Timeline Section
                    const Text(
                      'Timeline',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text('[Date/Time] - Complaint Submitted',
                        style: TextStyle(fontSize: 10)),
                    const Text('[Date/Time] - Assigned to Maintenance Dept.',
                        style: TextStyle(fontSize: 10)),
                    const Text('[Date/Time] - Acknowledged by [Admin Name]',
                        style: TextStyle(fontSize: 10)),
                    const SizedBox(height: 12),



                    // Admin Notes Input Field
                    const Text(
                      'Admin Notes',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _adminNotesController,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 11),
                      decoration: InputDecoration(
                        hintText: 'Add a private internal note...',
                        hintStyle: const TextStyle(
                            fontSize: 11, color: Colors.black38),
                        fillColor: Colors.white.withOpacity(0.6),
                        filled: true,
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black45),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Back to Dashboard Button
                    Center(
                      child: SizedBox(
                        width: 160,
                        height: 36,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Back to Dashboard',
                            style:
                                TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Powered Footer
              const Text(
                '© powered by UDSF CEV',
                style: TextStyle(fontSize: 10, color: Color(0xFF4A5568)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledBox(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        _buildSimpleBox(content),
      ],
    );
  }

  Widget _buildSimpleBox(String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black38),
      ),
      child: Text(
        content,
        style: const TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Color bgColor,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black38),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              style: const TextStyle(fontSize: 11, color: Colors.black),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}