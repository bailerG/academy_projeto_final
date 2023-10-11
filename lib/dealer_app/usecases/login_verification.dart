import '../entities/user.dart';
import 'database_controllers/users_table_controller.dart';

/// Simple login verification
class LoginVerification {
  /// Searches for a [User] in the database by the given [username] and
  /// compares [User.password] to the given [password].
  Future<User?> verifyLogin(String username, String password) async {
    final table = UsersTableController();

    final user = await table.selectByUsername(username);

    if (user.password != password) {
      return null;
    } else {
      return user;
    }
  }
}
