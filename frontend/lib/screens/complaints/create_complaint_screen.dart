import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../utils/validators.dart';
import '../../widgets/common/app_logo.dart';
import '../../widgets/common/app_background.dart';
import '../../widgets/common/custom_dropdown.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/primary_button.dart';

class CreateComplaintScreen extends StatefulWidget {
  final String? selectedCategory;

  const CreateComplaintScreen({
    super.key,
    this.selectedCategory,
  });

  @override
  State<CreateComplaintScreen> createState() => _CreateComplaintScreenState();
}

class _CreateComplaintScreenState extends State<CreateComplaintScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedCategory;
  String? _selectedPriority;
  bool _isAnonymous = false;
  bool _isLoading = false;

  // File Preview Temporary Data
  String? _selectedFileName;
  String? _selectedFileSize;

  static const List<String> _categories = [
    'Academic',
    'Classroom',
    'Laboratory',
    'Hostel',
    'Library',
    'Bus',
    'Transport',
    'Electricity',
    'Water',
    'Canteen',
    'Cafeteria',
    'Infrastructure',
    'Sports',
    'Internet',
    'Cleanliness',
    'Others',
  ];

  static const List<String> _priorities = [
    'Low',
    'Medium',
    'High',
    'Urgent',
  ];

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_onFormFieldChanged);
    _locationController.addListener(_onFormFieldChanged);
    if (widget.selectedCategory != null &&
        _categories.contains(widget.selectedCategory)) {
      _selectedCategory = widget.selectedCategory;
    }
  }

  void _onFormFieldChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _titleController.removeListener(_onFormFieldChanged);
    _locationController.removeListener(_onFormFieldChanged);
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitComplaint() async {
    // Dismiss keyboard when submit is pressed
    FocusScope.of(context).unfocus();

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate 2 seconds loading state
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      debugPrint("Complaint Submitted");
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.largeBorderRadius,
          ),
          elevation: 8,
          backgroundColor: AppColors.surface,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Icon Container
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryLight,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.success,
                    size: 48,
                  ),
                ),
                AppSpacing.mdHeight,
                // Dialog Title
                const Text(
                  'Complaint Submitted Successfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                AppSpacing.smHeight,
                // Dialog Message
                const Text(
                  'Your complaint has been received. You can track its progress from My Complaints.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                AppSpacing.lgHeight,
                // Action Buttons
                PrimaryButton(
                  text: 'View My Complaints',
                  onPressed: () {
                    Navigator.of(context).pop();
                    debugPrint("Navigate to My Complaints");
                  },
                ),
                AppSpacing.smHeight,
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    debugPrint("Navigate to Home");
                  },
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: AppSpacing.lgPadding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // AppLogo includes logo icon, App Name, and Tagline
                  const AppLogo(
                    showTagline: true,
                  ),
                  AppSpacing.lgHeight,
                  // Screen Heading
                  const Text(
                    'Create Complaint',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading,
                  ),
                  AppSpacing.xsHeight,
                  // Screen Subtitle
                  Text(
                    "Tell us about the issue you're facing.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  AppSpacing.xlHeight,
                  // Complaint Title Field
                  CustomTextField(
                    controller: _titleController,
                    labelText: 'Complaint Title',
                    hintText: 'Enter complaint title',
                    prefixIcon: Icons.title,
                    validator: (value) => Validators.requiredField(
                      value,
                      fieldName: 'Complaint Title',
                    ),
                  ),
                  AppSpacing.mdHeight,
                  // Complaint Category Dropdown
                  CustomDropdown<String>(
                    value: _selectedCategory,
                    labelText: 'Complaint Category',
                    hintText: 'Select category',
                    prefixIcon: Icons.category,
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                    validator: (value) => Validators.requiredField(
                      value,
                      fieldName: 'Complaint Category',
                    ),
                  ),
                  AppSpacing.mdHeight,
                  // Priority Level Dropdown
                  CustomDropdown<String>(
                    value: _selectedPriority,
                    labelText: 'Priority Level',
                    hintText: 'Select priority',
                    prefixIcon: Icons.flag_outlined,
                    items: _priorities.map((String priority) {
                      return DropdownMenuItem<String>(
                        value: priority,
                        child: Text(priority),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPriority = newValue;
                      });
                    },
                    validator: (value) => Validators.requiredField(
                      value,
                      fieldName: 'Priority',
                    ),
                  ),
                  AppSpacing.mdHeight,
                  // Location Field
                  CustomTextField(
                    controller: _locationController,
                    labelText: 'Location',
                    hintText: 'Example: Library First Floor',
                    prefixIcon: Icons.location_on_outlined,
                    validator: (value) => Validators.requiredField(
                      value,
                      fieldName: 'Location',
                    ),
                  ),
                  AppSpacing.mdHeight,
                  // Description Field
                  CustomTextField(
                    controller: _descriptionController,
                    labelText: 'Description',
                    hintText: 'Describe the issue in detail.',
                    prefixIcon: Icons.description_outlined,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      final requiredError = Validators.requiredField(
                        value,
                        fieldName: 'Description',
                      );
                      if (requiredError != null) return requiredError;
                      if (value!.trim().length < 20) {
                        return 'Description must be at least 20 characters';
                      }
                      return null;
                    },
                  ),
                  AppSpacing.mdHeight,
                  // Anonymous Toggle Switch
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.mediumBorderRadius,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: SwitchListTile(
                      value: _isAnonymous,
                      onChanged: (bool value) {
                        setState(() {
                          _isAnonymous = value;
                        });
                      },
                      title: const Text(
                        'Submit anonymously',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      subtitle: const Text(
                        'Your identity will not be visible to others.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      activeThumbColor: AppColors.primary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppRadius.mediumBorderRadius,
                      ),
                    ),
                  ),
                  AppSpacing.mdHeight,
                  // Upload Evidence Section
                  Container(
                    width: double.infinity,
                    padding: AppSpacing.lgPadding,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.mediumBorderRadius,
                      border: Border.all(
                        color: AppColors.primary.withAlpha(100),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Attach Evidence',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        AppSpacing.smHeight,
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryLight.withAlpha(100),
                          ),
                          child: const Icon(
                            Icons.cloud_upload_outlined,
                            size: 36,
                            color: AppColors.primary,
                          ),
                        ),
                        AppSpacing.smHeight,
                        const Text(
                          'Supports Images, PDF, and Videos',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        AppSpacing.mdHeight,
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _selectedFileName = 'sample_evidence.png';
                              _selectedFileSize = '2.4 MB';
                            });
                            debugPrint("Choose File");
                          },
                          icon: const Icon(Icons.folder_open, size: 18),
                          label: const Text('Choose File'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryLight,
                            foregroundColor: AppColors.primaryDark,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.mediumBorderRadius,
                            ),
                          ),
                        ),
                        // File Preview Area (Mock/Temporary Data)
                        if (_selectedFileName != null) ...[
                          AppSpacing.mdHeight,
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: AppRadius.mediumBorderRadius,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                // Thumbnail / Icon
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: AppRadius.smallBorderRadius,
                                  ),
                                  child: const Icon(
                                    Icons.insert_drive_file_outlined,
                                    color: AppColors.primary,
                                    size: 24,
                                  ),
                                ),
                                AppSpacing.smWidth,
                                // Filename & Size
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _selectedFileName!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _selectedFileSize ?? '2.4 MB',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Remove Button
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: AppColors.error,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedFileName = null;
                                      _selectedFileSize = null;
                                    });
                                  },
                                  tooltip: 'Remove file',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  AppSpacing.mdHeight,
                  // Contact Information Card (Read-only)
                  Container(
                    width: double.infinity,
                    padding: AppSpacing.lgPadding,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.mediumBorderRadius,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.person_outline,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Contact Information',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: AppColors.divider, height: 1),
                        const SizedBox(height: 12),
                        _buildContactRow(
                          icon: Icons.badge_outlined,
                          label: 'Student Name',
                          value: 'Ziyan MP',
                        ),
                        const SizedBox(height: 10),
                        _buildContactRow(
                          icon: Icons.school_outlined,
                          label: 'Department',
                          value: 'Computer Science & Engineering',
                        ),
                        const SizedBox(height: 10),
                        _buildContactRow(
                          icon: Icons.phone_outlined,
                          label: 'Phone Number',
                          value: '+91 98765 43210',
                        ),
                        const SizedBox(height: 10),
                        _buildContactRow(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: 'ziyan@example.com',
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.mdHeight,
                  // Review Summary Card
                  Container(
                    width: double.infinity,
                    padding: AppSpacing.lgPadding,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.mediumBorderRadius,
                      border: Border.all(
                        color: AppColors.primary.withAlpha(120),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.fact_check_outlined,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Review Summary',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: AppColors.divider, height: 1),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          label: 'Title',
                          value: _titleController.text.trim().isEmpty
                              ? 'Not specified'
                              : _titleController.text,
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          label: 'Category',
                          value: _selectedCategory ?? 'Not selected',
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          label: 'Priority',
                          value: _selectedPriority ?? 'Not selected',
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          label: 'Location',
                          value: _locationController.text.trim().isEmpty
                              ? 'Not specified'
                              : _locationController.text,
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          label: 'Anonymous',
                          value: _isAnonymous ? 'Yes' : 'No',
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.xlHeight,
                  // Submit Complaint Button
                  PrimaryButton(
                    text: 'Submit Complaint',
                    isLoading: _isLoading,
                    onPressed: _isLoading ? null : _submitComplaint,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}
