import 'package:scoped_model/scoped_model.dart';

import './activites.dart';
import './user.dart';

class MainModel extends Model with UserModel, ActivityModel {}
