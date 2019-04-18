import 'package:scoped_model/scoped_model.dart';

import '../models/activity.dart';

class ActivityModel extends Model {
  List<Activity> _activities = [];
  int _selectedActivityIndex;

  List<Activity> get activities {
    return List.from(_activities);
  }

  int get selectedActivityIndex {
    return _selectedActivityIndex;
  }

  Activity get selectedActivity {
    if (_selectedActivityIndex == null) {
      return null;
    }
    return _activities[_selectedActivityIndex];
  }

  void addActivities(Activity activity) {
    _activities.add(activity);
    _selectedActivityIndex = null;
    notifyListeners();
  }

  void deleteActivities() {
    _activities.removeAt(_selectedActivityIndex);
    _selectedActivityIndex = null;
    notifyListeners();
  }

  void updateActivities(Activity activity) {
    _activities[_selectedActivityIndex] = activity;
    _selectedActivityIndex = null;
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
    _activities[_selectedActivityIndex] = updatedActivity;
    _selectedActivityIndex = null;
    notifyListeners();
  }

  void selectActivity(int index) {
    _selectedActivityIndex = index;
  }
}
