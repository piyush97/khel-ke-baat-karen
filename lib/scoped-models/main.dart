import 'package:scoped_model/scoped_model.dart';

import './connected_activities.dart';

class MainModel extends Model with ConnectedActivitiesModel, UserModel, ActivityModel {}
