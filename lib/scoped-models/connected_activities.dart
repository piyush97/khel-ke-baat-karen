import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import '../models/activity.dart';
import '../models/user.dart';

class ConnectedActivitiesModel extends Model {
  List<Activity> _activities = [];
  User _authenticatedUser;
  String _selActivityId;
  bool _isLoading = false;

  Future<bool> addActivities(
      String title, String description, String image, double time) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> activityData = {
      'title': title,
      'description': description,
      'image': 'http://images.huffingtonpost.com/2013-12-27-food12.jpg',
      'time': time,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
    };
    return http
        .post('https://khel-ke-baat-karen.firebaseio.com/activities.json',
            body: json.encode(activityData))
        .then((http.Response response) {
      if (response.statusCode != 200 || response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Activity newActivity = Activity(
        id: responseData['name'],
        title: title,
        description: description,
        image: image,
        time: time,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id,
      );
      _activities.add(newActivity);
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
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

  String get selectedActivityId {
    return _selActivityId;
  }

  int get selectedActivityIndex {
    return _activities.indexWhere((Activity activity) {
      return activity.id == _selActivityId;
    });
  }

  Activity get selectedActivity {
    if (selectedActivityId == null) {
      return null;
    }
    return _activities.firstWhere((Activity activity) {
      return activity.id == _selActivityId;
    });
  }

  bool get displayFavoritesOnly {
    return showFavorites;
  }

  void deleteActivities() {
    _isLoading = true;
    final deletedActivityId = selectedActivity.id;
    _activities.removeAt(selectedActivityIndex);
    _selActivityId = null;
    notifyListeners();
    http
        .delete(
            'https://khel-ke-baat-karen.firebaseio.com/activities/${deletedActivityId}.json')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<bool> fetchActivities() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://khel-ke-baat-karen.firebaseio.com/activities.json')
        .then<Null>((http.Response response) {
      final List<Activity> fetchedActivityList = [];
      final Map<String, dynamic> activityListData = json.decode(response.body);
      if (activityListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      activityListData.forEach((String activityId, dynamic activityData) {
        final Activity activity = Activity(
          id: activityId,
          title: activityData['title'],
          description: activityData['description'],
          image: activityData['image'],
          time: activityData['time'],
          userEmail: activityData['userEmail'],
          userId: activityData['userId'],
        );
        fetchedActivityList.add(activity);
      });
      _activities = fetchedActivityList;
      _isLoading = false;
      notifyListeners();
      _selActivityId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<bool> updateActivities(
      String title, String description, String image, double time) {
    _isLoading = true;
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image': 'http://images.huffingtonpost.com/2013-12-27-food12.jpg',
      'time': time,
      'userEmail': selectedActivity.userEmail,
      'userId': selectedActivity.userId,
    };
    return http
        .put(
      'https://khel-ke-baat-karen.firebaseio.com/activities/${selectedActivity.id}.json',
      body: json.encode(updateData),
    )
        .then((http.Response response) {
      _isLoading = false;
      final Activity updatedActivity = Activity(
        id: selectedActivity.id,
        title: title,
        description: description,
        image: image,
        time: time,
        userEmail: selectedActivity.userEmail,
        userId: selectedActivity.userId,
      );
      final int selectedActivityIndex =
          _activities.indexWhere((Activity activity) {
        return activity.id == _selActivityId;
      });
      _activities[selectedActivityIndex] = updatedActivity;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void toggleFavActivity() {
    final bool isCurrentlyFavorite = selectedActivity.isFavorite;
    final bool newFavStatus = !isCurrentlyFavorite;
    final Activity updatedActivity = Activity(
        id: selectedActivity.id,
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

  void selectActivity(String activityId) {
    _selActivityId = activityId;
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

class UtilityModel extends ConnectedActivitiesModel {
  bool get isLoading {
    return _isLoading;
  }
}
