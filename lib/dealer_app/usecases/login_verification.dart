import '../entities/user.dart';
import '../repository/database.dart';

class LoginVerification {
  Future<User?> verifyLogin(String username, String password) async {
    final table = UsersTableController();

    final userList = await table.selectByUsername(username);

    if (userList.isEmpty) {
      return null;
    }

    final user = userList.first;

    if (user.password != password) {
      return null;
    } else {
      return user;
    }
  }
}
