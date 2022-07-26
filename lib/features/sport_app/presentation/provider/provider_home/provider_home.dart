import 'package:flutter/widgets.dart';
import 'package:sport_app/features/sport_app/domain/entities/user.dart';
import 'package:sport_app/features/sport_app/presentation/elements/home_elements.dart';

class Home extends ChangeNotifier {
  CurrentUser user =
      CurrentUser(name: '', email: '', age: 0, weight: 0, isMale: true);
  String imageProfile = '';

  //Drawer
  //Objects for localizations
  static final ua = OptionItem(id: 1, title: "Ukrainian");
  static final en = OptionItem(id: 2, title: "English");
  static final ru = OptionItem(id: 3, title: "Russian");

  DropListModel dropListModel = DropListModel([ua, en, ru]);
  OptionItem optionItemSelected = en;

  void choseLanguage(OptionItem optionItem) {
    optionItemSelected = optionItem;
    notifyListeners();
  }
  //

  //
}
