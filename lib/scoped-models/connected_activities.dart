import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import '../models/activity.dart';
import '../models/user.dart';
import '../models/auth.dart';
import '../shared/global_config.dart';

class ConnectedActivitiesModel extends Model {
  List<Activity> _activities = [];
  User _authenticatedUser;
  String _selActivityId;
  bool _isLoading = false;
}
// class SecretLoader {
//   final String secretPath;

//   SecretLoader({this.secretPath});

//   Future<Secret> load() {
//     return rootBundle.loadStructuredData<Secret>(this.secretPath,
//         (jsonStr) async {
//       final secret = Secret.fromJson(json.decode(jsonStr));
//       return secret;
//     });
//   }
// }

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

  Future<Map<String, dynamic>> uploadImage(File image,
      {String imagePath}) async {
    final mimeTypeData = lookupMimeType(image.path).split('/');
    final imageUploadRequest = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://us-central1-khel-ke-baat-karen.cloudfunctions.net/storeImage'));
    final file = await http.MultipartFile.fromPath(
      'image',
      image.path,
      contentType: MediaType(
        mimeTypeData[0],
        mimeTypeData[1],
      ),
    );
    imageUploadRequest.files.add(file);
    if (imagePath != null) {
      imageUploadRequest.fields['imagePath'] = Uri.encodeComponent(imagePath);
    }
    imageUploadRequest.headers['Authorization'] =
        'Bearer ${_authenticatedUser.token}';

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('Something went wrong');
        print(json.decode(response.body));
        return null;
      }
      final responseData = json.decode(response.body);
      return responseData;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> addActivities(
      String title, String description, File image, double time) async {
    _isLoading = true;
    notifyListeners();
    final uploadData = await uploadImage(image);

    if (uploadData == null) {
      print('Upload Failed');
      return false;
    }

    final Map<String, dynamic> activityData = {
      'title': title,
      'description': description,
      'time': time,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
      'imagePath': uploadData['imagePath'],
      'imageUrl': uploadData['imageUrl'],
    };
    try {
      final http.Response response = await http.post(
          'https://khel-ke-baat-karen.firebaseio.com/activities.json?auth=${_authenticatedUser.token}',
          body: json.encode(activityData));
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
        image: uploadData['imageUrl'],
        imagePath: uploadData['imagePath'],
        time: time,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id,
      );
      _activities.add(newActivity);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
    // .catchError((error) {
    //   _isLoading = false;
    //   notifyListeners();
    //   return false;
    // });
  }

  Future<bool> deleteActivities() {
    _isLoading = true;
    final deletedActivityId = selectedActivity.id;
    _activities.removeAt(selectedActivityIndex);
    _selActivityId = null;
    notifyListeners();
    return http
        .delete(
            'https://khel-ke-baat-karen.firebaseio.com/activities/$deletedActivityId.json?auth=${_authenticatedUser.token}')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> fetchActivities({onlyForUser = false}) {
    _isLoading = true;
    notifyListeners();
    return http
        .get(
            'https://khel-ke-baat-karen.firebaseio.com/activities.json?auth=${_authenticatedUser.token}')
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
            imagePath: activityData['imagePath'],
            time: activityData['time'],
            userEmail: activityData['userEmail'],
            userId: activityData['userId'],
            isFavorite: activityData['wishlistUsers'] == null
                ? false
                : (activityData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));
        fetchedActivityList.add(activity);
      });
      _activities = onlyForUser
          ? fetchedActivityList.where((Activity activity) {
              return activity.userId == _authenticatedUser.id;
            }).toList()
          : fetchedActivityList;
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
      String title, String description, File image, double time) async {
    _isLoading = true;
    notifyListeners();
    String imageUrl = selectedActivity.image;
    String imagePath = selectedActivity.imagePath;
    if (image != null) {
      final uploadData = await uploadImage(image);

      if (uploadData == null) {
        print('Upload failed!');
        return false;
      }

      imageUrl = uploadData['imageUrl'];
      imagePath = uploadData['imagePath'];
    }
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'imagePath': imagePath,
      'time': time,
      'userEmail': selectedActivity.userEmail,
      'userId': selectedActivity.userId
    };
    try {
      await http.put(
          'https://khel-ke-baat-karen.firebaseio.com/activities/${selectedActivity.id}.json?auth=${_authenticatedUser.token}',
          body: json.encode(updateData));
      _isLoading = false;
      final Activity updatedActivity = Activity(
          id: selectedActivity.id,
          title: title,
          description: description,
          image: imageUrl,
          imagePath: imagePath,
          time: time,
          userEmail: selectedActivity.userEmail,
          userId: selectedActivity.userId);
      _activities[selectedActivityIndex] = updatedActivity;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void toggleActivityFavoriteStatus() async {
    final bool isCurrentlyFavorite = selectedActivity.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Activity updatedactivity = Activity(
        id: selectedActivity.id,
        title: selectedActivity.title,
        description: selectedActivity.description,
        time: selectedActivity.time,
        image: selectedActivity.image,
        imagePath: selectedActivity.imagePath,
        userEmail: selectedActivity.userEmail,
        userId: selectedActivity.userId,
        isFavorite: newFavoriteStatus);
    _activities[selectedActivityIndex] = updatedactivity;
    notifyListeners();
    http.Response response;
    if (newFavoriteStatus) {
      response = await http.put(
        'https://khel-ke-baat-karen.firebaseio.com/activities/${selectedActivity.id}/wishlistUsers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}',
        body: json.encode(true),
      );
    } else {
      response = await http.delete(
          'https://khel-ke-baat-karen.firebaseio.com/activities/${selectedActivity.id}/wishlistUsers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}');
    }
    if (response.statusCode != 200 && response.statusCode != 201) {
      final Activity updatedactivity = Activity(
          id: selectedActivity.id,
          title: selectedActivity.title,
          description: selectedActivity.description,
          time: selectedActivity.time,
          image: selectedActivity.image,
          imagePath: selectedActivity.imagePath,
          userEmail: selectedActivity.userEmail,
          userId: selectedActivity.userId,
          isFavorite: !newFavoriteStatus);
      _activities[selectedActivityIndex] = updatedactivity;
      notifyListeners();
    }
    _selActivityId = null;
  }

  void selectActivity(String activityId) {
    _selActivityId = activityId;
    if (activityId != null) {
      notifyListeners();
    }
  }

  void toggleDisplayMode() {
    showFavorites = !showFavorites;
    notifyListeners();
  }
}

class UserModel extends ConnectedActivitiesModel {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();
  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    String _loadApi() {
      rootBundle.loadString('assets/secrets.json');
      Map decoded = jsonDecode('assets/secrets.json');
      return decoded['api_key'];
    }

    print(_loadApi.toString());

    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$apiKey',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=$apiKey',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong.';
    print(responseData);
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedUser = User(
          id: responseData['localId'],
          email: email,
          token: responseData['idToken']);
      setAuthTimeOut(int.parse(responseData['expiresIn']));
      final now = DateTime.now();
      final DateTime expiryTime = now.add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      _userSubject.add(true);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found.';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists.';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'The password is invalid.';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expiryTimeString = prefs.getString('expiryTime');
    if (token != null) {
      final DateTime now = DateTime.now();
      final parsedExpiryTime = DateTime.parse(expiryTimeString);
      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedUser = User(id: userId, email: userEmail, token: token);
      _userSubject.add(true);
      setAuthTimeOut(tokenLifespan);
      notifyListeners();
    }
  }

  void logout() async {
    _authenticatedUser = null;
    _authTimer.cancel();
    _userSubject.add(false);
    _selActivityId = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
    _userSubject.add(false);
  }

  void setAuthTimeOut(int time) {
    _authTimer = Timer(
      Duration(seconds: time),
      logout,
    );
  }
}

class UtilityModel extends ConnectedActivitiesModel {
  bool get isLoading {
    return _isLoading;
  }
}
