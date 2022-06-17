import 'dart:io';
import 'package:group_chat_app/menu/settings/settings_menu.dart';
import 'package:group_chat_app/service/ext_service.dart';
import '../model/home_model.dart';
import 'package:group_chat_app/pages/navigate_menu.dart';
import '../service/check_sevice.dart';
import '../service/io_service.dart';
import '../service/security_service.dart';
import 'contacts/contacts_menu.dart';
import 'message/send_message_menu.dart';

class HomeMenu extends Menu {
  final SecurityService _service = SecurityService();
  static const String id = "/home_menu";
  bool status = true;

  Future<void> selectFunction(String select) async {
    switch (select) {
      case "I":
        {
          await Navigator.push(Contacts());
        }
        break;
      case "II":
        {
          await Navigator.push(SendMessage());
        }
        break;
      case "III":
        {
          await Navigator.push(SettingsMenu());
        }
        break;
      case "IV":
        {
          exit(0);
        }
    }
  }

  @override
  Future<void> build() async {
    bool check = await _service.pasword();
    if (status && check) {
      bool password = await validator();
      if (password) {
        status = false;
      }
    }
    try{

      writeln("");
      writeln("welcome".tr);
      writeln("I. " + "contact".tr);
      writeln("II. " + "send_message".tr);
      writeln("III. " + "settings".tr);
      writeln("IV. " + "exit".tr);
      writeln("");
      String selectedMenu = read();
      await selectFunction(selectedMenu);
      writeln("");
    }catch(e){
      await build();
    }
  }
}
