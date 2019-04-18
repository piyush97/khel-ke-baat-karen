import 'package:scoped_model/scoped_model.dart';
import '../models/user.dart';
import './connected_activities.dart';

class UserModel extends ConnectedActivities {
  void login(String email, String password) {
    authenticatedUser = User(
      id: 'Piyush',
      email: email,
      password: password,
    );
  }
}
