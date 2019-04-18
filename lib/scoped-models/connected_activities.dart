import 'package:scoped_model/scoped_model.dart';
import '../models/activity.dart';
import '../models/user.dart';

class ConnectedActivities extends Model {
  List<Activity> activities = [];
  User authenticatedUser;
  int selActivityIndex;

  void addActivities(
      String title, String description, String image, double time) {
    final Activity newActivity = Activity(
      title: title,
      description: description,
      image: image,
      time: time,
      userEmail: authenticatedUser.email,
      userId: authenticatedUser.id,
    );
    activities.add(newActivity);
    selActivityIndex = null;
    notifyListeners();
  }
}
