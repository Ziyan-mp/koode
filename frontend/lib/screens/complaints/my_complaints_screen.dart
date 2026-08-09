import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_routes.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../models/complaint_model.dart';
import '../../services/auth_service.dart';
import '../../services/complaint_service.dart';
import '../../widgets/common/app_background.dart';
import '../../widgets/home/complaint_categories_section.dart';
import 'complaint_details_screen.dart';
import 'create_complaint_screen.dart';

class MyComplaintsScreen extends StatefulWidget {
  const MyComplaintsScreen({super.key});

  @override
  State<MyComplaintsScreen> createState() => _MyComplaintsScreenState();
}

class _MyComplaintsScreenState extends State<MyComplaintsScreen> {
  final ComplaintService _complaintService = ComplaintService();
  final AuthService _authService = AuthService();

  List<ComplaintModel> _complaints = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserComplaints();
  }

  Future<void> _loadUserComplaints() async {
    setState(() {
      _isLoading = true;
    });

    final currentUser = await _authService.getCurrentUser();
    if (currentUser == null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
      return;
    }

    final userComplaints =
        await _complaintService.getUserComplaints(currentUser.email);

    if (mounted) {
      setState(() {
        _complaints = userComplaints;
        _isLoading = false;
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status.trim().toLowerCase()) {
      case 'resolved':
        return Colors.green.shade700;
      case 'in progress':
      case 'inprogress':
        return Colors.orange.shade700;
      case 'rejected':
        return Colors.red.shade700;
      case 'pending':
      default:
        return Colors.blue.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _loadUserComplaints,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Header Row
                  Row(
                    children: [
                      if (Navigator.canPop(context))
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.textPrimary,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      const Text(
                        'My Complaints',
                        style: AppTextStyles.heading,
                      ),
                    ],
                  ),

                  AppSpacing.mdHeight,

                  // Section 1: Complaint Categories Section for submitting new complaints
                  ComplaintCategoriesSection(
                    onCategorySelected: (category) async {
                      final result = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateComplaintScreen(
                            selectedCategory: category,
                          ),
                        ),
                      );
                      if (result == true) {
                        _loadUserComplaints();
                      }
                    },
                  ),

                  AppSpacing.lgHeight,

                  // Section 2: Submitted Complaints List Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Submitted History',
                        style: AppTextStyles.subHeading,
                      ),
                      Text(
                        '${_complaints.length} Total',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  AppSpacing.mdHeight,

                  if (_isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  else if (_complaints.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 40.0,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withAlpha(217),
                        borderRadius: AppRadius.largeBorderRadius,
                        boxShadow: AppShadows.light,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryLight,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.assignment_outlined,
                              color: AppColors.primary,
                              size: 48,
                            ),
                          ),
                          AppSpacing.mdHeight,
                          const Text(
                            "You haven't submitted any complaints yet.",
                            style: AppTextStyles.subHeading,
                            textAlign: TextAlign.center,
                          ),
                          AppSpacing.xsHeight,
                          Text(
                            "Select a category above to submit a new complaint.",
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _complaints.length,
                      itemBuilder: (context, index) {
                        final complaint = _complaints[index];
                        final statusColor = _getStatusColor(complaint.status);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 14.0),
                          decoration: BoxDecoration(
                            color: AppColors.white.withAlpha(217),
                            borderRadius: AppRadius.largeBorderRadius,
                            boxShadow: AppShadows.light,
                            border: Border.all(
                              color: AppColors.white.withAlpha(200),
                              width: 1.2,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: AppRadius.largeBorderRadius,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ComplaintDetailsScreen(
                                      complaint: complaint,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ID & Status Badge Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          complaint.id.startsWith('#')
                                              ? complaint.id
                                              : '#${complaint.id}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor.withAlpha(30),
                                            borderRadius:
                                                AppRadius.pillBorderRadius,
                                            border: Border.all(
                                              color: statusColor.withAlpha(80),
                                            ),
                                          ),
                                          child: Text(
                                            complaint.status.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: statusColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    AppSpacing.xsHeight,

                                    // Category Tag & Date
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryLight,
                                            borderRadius:
                                                AppRadius.pillBorderRadius,
                                          ),
                                          child: Text(
                                            complaint.category,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '•  ${complaint.dateSubmitted}',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),

                                    AppSpacing.smHeight,

                                    // Complaint Title
                                    Text(
                                      complaint.title,
                                      style: AppTextStyles.subHeading.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    const SizedBox(height: 4),

                                    // Short Description
                                    Text(
                                      complaint.description,
                                      style: AppTextStyles.body.copyWith(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
