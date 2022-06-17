import 'package:group_chat_app/pages/navigate_menu.dart';
import '../model/home_model.dart';
import 'lang_service.dart';

class MyApp {
  static Map<String, Menu> routeMenu = {};

  MyApp({required Menu home, required Language locale, required Map<String, Menu> routes}) {
    routeMenu = routes;
    LangService.language = locale;
    Navigator.initialValue = home;
    _runApp(home);
  }

  void _runApp(Menu menu) async {
    while(true) {
      await menu.build();
    }
  }
}