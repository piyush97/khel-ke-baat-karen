import 'package:scoped_model/scoped_model.dart';
import '../models/activity.dart';
import '../models/user.dart';

class ConnectedActivitiesModel extends Model {
  List<Activity> _activities = [];
  User _authenticatedUser;
  int _selActivityIndex;

  void addActivities(
      String title, String description, String image, double time) {
    final Activity newActivity = Activity(
      title: title,
      description: description,
      image: image,
      time: time,
      userEmail: _authenticatedUser.email,
      userId: _authenticatedUser.id,
    );
    _activities.add(newActivity);
    notifyListeners();
  }
}

class ActivityModel extends ConnectedActivitiesModel {
  bool showFavorites = false;

  List<Activity> get allActivities {
    return List.from(_activities);
  }

  List<Activity> get displayActivities {
    if (showFavorites) {
      return List.from(
        _activities.where((Activity activity) => activity.isFavorite).toList(),
      );
    }
    return List.from(_activities);
  }

  int get selectedActivityIndex {
    return _selActivityIndex;
  }

  Activity get selectedActivity {
    if (selectedActivityIndex == null) {
      return null;
    }
    return _activities[selectedActivityIndex];
  }

  bool get displayFavoritesOnly {
    return showFavorites;
  }

  void deleteActivities() {
    _activities.removeAt(selectedActivityIndex);
    notifyListeners();
  }

  void updateActivities(
      String title, String description, String image, double time) {
    final Activity updatedActivity = Activity(
      title: title,
      description: description,
      image: image,
      time: time,
      userEmail: selectedActivity.userEmail,
      userId: selectedActivity.userId,
    );
    _activities[selectedActivityIndex] = updatedActivity;
    notifyListeners();
  }

  void toggleFavActivity() {
    final bool isCurrentlyFavorite = selectedActivity.isFavorite;
    final bool newFavStatus = !isCurrentlyFavorite;
    final Activity updatedActivity = Activity(
        title: selectedActivity.title,
        description: selectedActivity.description,
        time: selectedActivity.time,
        image: selectedActivity.image,
        isFavorite: newFavStatus,
        userEmail: selectedActivity.userEmail,
        userId: selectedActivity.userId);
    _activities[selectedActivityIndex] = updatedActivity;
    notifyListeners();
  }

  void selectActivity(int index) {
    _selActivityIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    showFavorites = !showFavorites;
    notifyListeners();
  }
}

class UserModel extends ConnectedActivitiesModel {
  void login(String email, String password) {
    _authenticatedUser = User(
      id: 'Piyush',
      email: email,
      password: password,
    );
  }
}
