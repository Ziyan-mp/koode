import 'dart:convert';

class ComplaintTimelineEvent {
  final String status;
  final String date;
  final String note;

  const ComplaintTimelineEvent({
    required this.status,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMap() => {
        'status': status,
        'date': date,
        'note': note,
      };

  factory ComplaintTimelineEvent.fromMap(Map<String, dynamic> map) =>
      ComplaintTimelineEvent(
        status: map['status'] as String? ?? '',
        date: map['date'] as String? ?? '',
        note: map['note'] as String? ?? '',
      );
}

class ComplaintModel {
  final String id;
  final String category;
  final String title;
  final String description;
  final String status; // 'Pending', 'In Progress', 'Resolved', 'Rejected'
  final String dateSubmitted;
  final String userEmail;
  final String? location;
  final String? priority; // 'Low', 'Medium', 'High', 'Urgent'
  final String? assignedDepartment;
  final String? adminRemarks;
  final List<String> attachments;
  final List<ComplaintTimelineEvent> timeline;

  ComplaintModel({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.status,
    required this.dateSubmitted,
    required this.userEmail,
    this.location,
    this.priority,
    this.assignedDepartment,
    this.adminRemarks,
    this.attachments = const [],
    this.timeline = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'description': description,
      'status': status,
      'dateSubmitted': dateSubmitted,
      'userEmail': userEmail,
      'location': location,
      'priority': priority,
      'assignedDepartment': assignedDepartment,
      'adminRemarks': adminRemarks,
      'attachments': attachments,
      'timeline': timeline.map((t) => t.toMap()).toList(),
    };
  }

  factory ComplaintModel.fromMap(Map<String, dynamic> map) {
    return ComplaintModel(
      id: map['id'] as String? ?? '',
      category: map['category'] as String? ?? 'General',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      status: map['status'] as String? ?? 'Pending',
      dateSubmitted: map['dateSubmitted'] as String? ?? '',
      userEmail: map['userEmail'] as String? ?? '',
      location: map['location'] as String?,
      priority: map['priority'] as String?,
      assignedDepartment: map['assignedDepartment'] as String?,
      adminRemarks: map['adminRemarks'] as String?,
      attachments: (map['attachments'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      timeline: (map['timeline'] as List<dynamic>?)
              ?.map((e) =>
                  ComplaintTimelineEvent.fromMap(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplaintModel.fromJson(String source) =>
      ComplaintModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
