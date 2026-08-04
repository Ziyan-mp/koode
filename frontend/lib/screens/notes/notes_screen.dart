import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../models/note_model.dart';
import '../../widgets/common/app_background.dart';
import '../../widgets/notes/note_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedSemester = 'All';
  String _selectedSubject = 'All';
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> _semesters = const [
    'All',
    'Sem 1',
    'Sem 2',
    'Sem 3',
    'Sem 4',
    'Sem 5',
    'Sem 6',
    'Sem 7',
    'Sem 8',
  ];

  final List<String> _subjects = const [
    'All',
    'Data Structures',
    'Operating Systems',
    'DBMS',
    'Software Engineering',
    'Computer Networks',
    'AI & ML',
    'Web Development',
    'Mathematics',
  ];

  // Dummy Study Notes Data
  final List<NoteModel> _allNotes = const [
    NoteModel(
      id: '1',
      title: 'Data Structures & Algorithms Handwritten Notes',
      subject: 'Data Structures',
      semester: 'Sem 3',
      uploadedBy: 'Prof. Anjali Nair',
      uploadDate: '02 Aug 2026',
      fileType: 'PDF',
      fileSize: '4.2 MB',
      description: 'Complete Trees, Graphs, Sorting & Searching algorithms.',
    ),
    NoteModel(
      id: '2',
      title: 'Operating Systems Process Synchronization & Deadlocks',
      subject: 'Operating Systems',
      semester: 'Sem 4',
      uploadedBy: 'Dr. Ramesh Kumar',
      uploadDate: '28 Jul 2026',
      fileType: 'PDF',
      fileSize: '2.8 MB',
      description: 'Detailed explanation of Semaphores, Mutex, and Banker\'s Algorithm.',
    ),
    NoteModel(
      id: '3',
      title: 'Database Management Systems SQL Cheat Sheet & Normalization',
      subject: 'DBMS',
      semester: 'Sem 4',
      uploadedBy: 'Dept. Faculty',
      uploadDate: '20 Jul 2026',
      fileType: 'DOCX',
      fileSize: '1.5 MB',
      description: 'Includes 1NF to BCNF rules and SQL query examples.',
    ),
    NoteModel(
      id: '4',
      title: 'Computer Networks OSI Model & TCP/IP Layer Slides',
      subject: 'Computer Networks',
      semester: 'Sem 5',
      uploadedBy: 'Prof. Vikram Singh',
      uploadDate: '15 Jul 2026',
      fileType: 'PPTX',
      fileSize: '8.4 MB',
      description: 'Lecture slides covering Network layer protocols and Routing.',
    ),
    NoteModel(
      id: '5',
      title: 'Machine Learning Neural Networks & Deep Learning Guide',
      subject: 'AI & ML',
      semester: 'Sem 6',
      uploadedBy: 'Dr. Priya Menon',
      uploadDate: '10 Jul 2026',
      fileType: 'PDF',
      fileSize: '5.6 MB',
      description: 'Backpropagation, Convolutional Networks, and Transformers basics.',
    ),
    NoteModel(
      id: '6',
      title: 'Web Development React & Flutter Architecture Notes',
      subject: 'Web Development',
      semester: 'Sem 5',
      uploadedBy: 'Student Association',
      uploadDate: '05 Jul 2026',
      fileType: 'PDF',
      fileSize: '3.1 MB',
      description: 'State management, widget trees, and REST API integration guide.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  List<NoteModel> get _filteredNotes {
    final query = _searchController.text.trim().toLowerCase();

    return _allNotes.where((note) {
      final matchesSearch = query.isEmpty ||
          note.title.toLowerCase().contains(query) ||
          note.subject.toLowerCase().contains(query) ||
          note.uploadedBy.toLowerCase().contains(query);

      final matchesSemester =
          _selectedSemester == 'All' || note.semester == _selectedSemester;

      final matchesSubject =
          _selectedSubject == 'All' || note.subject == _selectedSubject;

      return matchesSearch && matchesSemester && matchesSubject;
    }).toList();
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedSemester = 'All';
      _selectedSubject = 'All';
      _errorMessage = null;
    });
  }

  Future<void> _refreshNotes() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width >= 900;
    final isTablet = size.width >= 600 && size.width < 900;

    final crossAxisCount = isWeb ? 3 : (isTablet ? 2 : 1);
    final childAspectRatio = isWeb ? 0.95 : (isTablet ? 0.9 : 0.88);

    final filtered = _filteredNotes;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _refreshNotes,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: AppColors.white.withAlpha(217),
                      borderRadius: AppRadius.largeBorderRadius,
                      boxShadow: AppShadows.light,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.note_alt_outlined,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Study Notes & Materials',
                                style: AppTextStyles.heading,
                              ),
                              AppSpacing.xsHeight,
                              Text(
                                'Access lecture notes, slides & study resources',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  AppSpacing.lgHeight,

                  // Search Bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search notes by title, subject, or professor...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.textSecondary,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () => _searchController.clear(),
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.white.withAlpha(220),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: AppRadius.mediumBorderRadius,
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: AppRadius.mediumBorderRadius,
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: AppRadius.mediumBorderRadius,
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),

                  AppSpacing.mdHeight,

                  // Filter Row (Semester & Subject Dropdowns)
                  Row(
                    children: [
                      // Semester Dropdown Filter
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedSemester,
                          decoration: const InputDecoration(
                            labelText: 'Semester',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            filled: true,
                            fillColor: AppColors.surface,
                            border: OutlineInputBorder(
                              borderRadius: AppRadius.mediumBorderRadius,
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: AppRadius.mediumBorderRadius,
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                          ),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedSemester = val;
                              });
                            }
                          },
                          items: _semesters.map((sem) {
                            return DropdownMenuItem<String>(
                              value: sem,
                              child: Text(sem),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Subject Dropdown Filter
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedSubject,
                          decoration: const InputDecoration(
                            labelText: 'Subject',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            filled: true,
                            fillColor: AppColors.surface,
                            border: OutlineInputBorder(
                              borderRadius: AppRadius.mediumBorderRadius,
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: AppRadius.mediumBorderRadius,
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                          ),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedSubject = val;
                              });
                            }
                          },
                          items: _subjects.map((subj) {
                            return DropdownMenuItem<String>(
                              value: subj,
                              child: Text(
                                subj,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),

                  AppSpacing.lgHeight,

                  // Loading State
                  if (_isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    )

                  // Error State
                  else if (_errorMessage != null)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: AppColors.white.withAlpha(217),
                          borderRadius: AppRadius.mediumBorderRadius,
                          boxShadow: AppShadows.light,
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.error,
                              size: 40,
                            ),
                            AppSpacing.smHeight,
                            Text(
                              _errorMessage!,
                              style: AppTextStyles.body,
                              textAlign: TextAlign.center,
                            ),
                            AppSpacing.mdHeight,
                            ElevatedButton(
                              onPressed: _refreshNotes,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.white,
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    )

                  // Empty State
                  else if (filtered.isEmpty)
                    Center(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 40,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: AppColors.white.withAlpha(217),
                          borderRadius: AppRadius.largeBorderRadius,
                          boxShadow: AppShadows.light,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.search_off_outlined,
                                color: AppColors.primary,
                                size: 40,
                              ),
                            ),
                            AppSpacing.mdHeight,
                            const Text(
                              'No Study Notes Found',
                              style: AppTextStyles.heading,
                              textAlign: TextAlign.center,
                            ),
                            AppSpacing.xsHeight,
                            Text(
                              'No notes match your current search or filter criteria.',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            AppSpacing.lgHeight,
                            OutlinedButton.icon(
                              onPressed: _resetFilters,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Clear Filters'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )

                  // Notes Grid
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filtered.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final note = filtered[index];
                        return NoteCard(
                          note: note,
                          onView: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Opening "${note.title}"...'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          onDownload: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Downloading "${note.title}" (${note.fileSize})...'),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          onShare: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Sharing link for "${note.title}"'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
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
