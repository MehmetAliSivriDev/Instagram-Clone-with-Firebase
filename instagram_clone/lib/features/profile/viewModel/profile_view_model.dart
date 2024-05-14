import 'package:flutter/material.dart';
import '../../../core/service/base_service.dart';
import '../service/profile_service.dart';

import '../../../core/model/user_model.dart';

class ProfileViewModel extends ChangeNotifier {
  int userPostCount = 0;
  UserModel model = UserModel();

  IProfileService _service = ProfileService();
  IBaseService _baseService = BaseService();

  Future<void> getCurrentUserPostCount() async {
    userPostCount = await _service.getCurrentUserPostCount();
    notifyListeners();
  }

  Future<void> getCurrentUser() async {
    model = await _baseService.getUser();
    notifyListeners();
  }
}
