import '../models/user_model.dart';
import 'storage_service.dart';

class ProfileService {
  final StorageService _storageService;

  ProfileService({StorageService? storageService})
      : _storageService = storageService ?? StorageService();

  // Retrieve current logged in user profile
  Future<UserModel?> getUserProfile() async {
    return await _storageService.getLoggedInUser();
  }

  // Update user profile details
  Future<bool> updateProfile(UserModel updatedUser) async {
    try {
      await _storageService.saveUser(updatedUser);
      return true;
    } catch (_) {
      return false;
    }
  }
}
