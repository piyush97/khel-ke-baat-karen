import 'package:scoped_model/scoped_model.dart';

import '../models/activity.dart';
import './connected_activities.dart';

class ActivityModel extends ConnectedActivities {
  bool showFavorites = false;

  List<Activity> get allActivities {
    return List.from(activities);
  }

  List<Activity> get displayActivities {
    if (showFavorites) {
      return List.from(
        activities.where((Activity activity) => activity.isFavorite).toList(),
      );
    }
    return List.from(activities);
  }

  int get selectedActivityIndex {
    return selActivityIndex;
  }

  Activity get selectedActivity {
    if (selectedActivityIndex == null) {
      return null;
    }
    return activities[selectedActivityIndex];
  }

  bool get displayFavoritesOnly {
    return showFavorites;
  }

  void deleteActivities() {
    activities.removeAt(selectedActivityIndex);
    selActivityIndex = null;
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
    activities[selectedActivityIndex] = updatedActivity;
    selActivityIndex = null;
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
    activities[selectedActivityIndex] = updatedActivity;
    selActivityIndex = null;
    notifyListeners();
    selActivityIndex = null;
  }

  void selectActivity(int index) {
    selActivityIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    showFavorites = !showFavorites;
    notifyListeners();
  }
}
