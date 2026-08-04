import '../models/complaint_model.dart';
import 'storage_service.dart';

class ComplaintService {
  final StorageService _storageService;

  ComplaintService({StorageService? storageService})
      : _storageService = storageService ?? StorageService();

  // Submit a new complaint
  Future<void> submitComplaint(ComplaintModel complaint) async {
    await _storageService.saveComplaint(complaint);
  }

  // Get list of complaints submitted by logged-in user
  Future<List<ComplaintModel>> getUserComplaints(String email) async {
    final list = await _storageService.getComplaintsForUser(email);
    return list;
  }

  // Calculate complaint status statistics for a user
  Future<Map<String, int>> getComplaintStats(String email) async {
    final list = await getUserComplaints(email);

    int total = list.length;
    int pending = 0;
    int inProgress = 0;
    int resolved = 0;
    int rejected = 0;

    for (final c in list) {
      switch (c.status.trim().toLowerCase()) {
        case 'pending':
          pending++;
          break;
        case 'in progress':
        case 'inprogress':
          inProgress++;
          break;
        case 'resolved':
          resolved++;
          break;
        case 'rejected':
          rejected++;
          break;
        default:
          pending++;
          break;
      }
    }

    return {
      'total': total,
      'pending': pending,
      'inProgress': inProgress,
      'resolved': resolved,
      'rejected': rejected,
    };
  }
}
