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
    return selectedActivityIndex;
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
    selectedActivityIndex = null;
    notifyListeners();
  }

  void updateActivities(Activity activity) {
    activities[selectedActivityIndex] = activity;
    selectedActivityIndex = null;
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
    );
    activities[selectedActivityIndex] = updatedActivity;
    selectedActivityIndex = null;
    notifyListeners();
    selectedActivityIndex = null;
  }

  void selectActivity(int index) {
    selectedActivityIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    showFavorites = !showFavorites;
    notifyListeners();
  }
}
