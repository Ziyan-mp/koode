class NoteModel {
  final String id;
  final String title;
  final String subject;
  final String semester;
  final String uploadedBy;
  final String uploadDate;
  final String fileType; // e.g., 'PDF', 'PPTX', 'DOCX'
  final String fileSize; // e.g., '2.4 MB'
  final String? description;
  final String? downloadUrl;

  const NoteModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.semester,
    required this.uploadedBy,
    required this.uploadDate,
    required this.fileType,
    required this.fileSize,
    this.description,
    this.downloadUrl,
  });
}
