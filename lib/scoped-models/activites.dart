import 'package:scoped_model/scoped_model.dart';

import '../models/activity.dart';

class ActivityModel extends Model {
  List<Activity> _activities = [];

  List<Activity> get activities {
    return List.from(_activities);
  }

  void addActivities(Activity activity) {
    _activities.add(activity);
  }

  void deleteActivities(int index) {
    _activities.removeAt(index);
  }

  void updateActivities(int index, Activity activity) {
    _activities[index] = activity;
  }
}
