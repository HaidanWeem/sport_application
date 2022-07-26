import 'package:flutter/widgets.dart';
import 'package:sport_app/features/sport_app/domain/entities/user.dart';

class Home extends ChangeNotifier {
  CurrentUser user = CurrentUser(name: '', email: '', age: 0, weight: 0);
  String imageProfile = '';
}
