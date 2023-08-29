import 'package:flutter/material.dart';

import '../../entities/role.dart';
import '../../repository/database.dart';

class UserRegistrationState with ChangeNotifier {
  UserRegistrationState() {
    load();
  }

  final formState = GlobalKey<FormState>();
  final roleList = <Role>[];

  Future<void> load() async {
    final list = await RolesTableController().select();

    roleList.clear();
    roleList.addAll(list);
    notifyListeners();
  }
}
