import 'package:scoped_model/scoped_model.dart';

import './connected_activities.dart';
import './activites.dart';
import './user.dart';

class MainModel extends Model with ConnectedActivities, UserModel, ActivityModel {}
