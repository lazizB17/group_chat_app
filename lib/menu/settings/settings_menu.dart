import 'package:group_chat_app/menu/settings/securty_menu.dart';
import 'package:group_chat_app/service/ext_service.dart';
import '../../model/home_model.dart';
import 'package:group_chat_app/pages/navigate_menu.dart';
import '../../service/data_service.dart';
import '../../service/io_service.dart';
import 'id_menu.dart';
import 'lang_menu.dart';


class SettingsMenu extends Menu {
  static final String id = "/settings_menu";

  DataService _service = DataService();

  Future<void> selectFunction(String select) async {
    switch (select) {
      case "I":
        {
          await Navigator.push(LangMenu());
        }
        break;
      case "II":
        {
          await Navigator.push(SecurityMenu());
          break;
        }
      case "III":
        {
          await Navigator.popUntil();
          break;
        }
      default:
        {
          writeln("error".tr);
          await build();
        }
    }
  }
  Future<void> selectFunctionSecond(String select) async {
    switch (select) {
      case "I":
        {
          await Navigator.push(LangMenu());
        }
        break;
      case "II":
        {
          await Navigator.push(SecurityMenu());
          break;
        }
      case "III":
        {
          await Navigator.push(ID());
          break;
        }
      case "IV":
        {
          await Navigator.popUntil();
          break;
        }
      default:
        {
          writeln("error".tr);
          await build();
        }
    }
  }

  @override
  Future<void> build() async {
    String id = await _service.readDate(key: "id");

    if(id == "") {
      writeln("");
      writeln("I.  " + "change_lang".tr);
      writeln("II. " + "change_pasw".tr);
      writeln("III." + "back_home".tr);
      writeln("");
      String select = read();
      await selectFunction(select);
      writeln("");
    } else {
      writeln("");
      writeln("I.  " + "change_lang".tr);
      writeln("II. " + "change_pasw".tr);
      writeln("III." + "id_".tr);
      writeln("IV. " + "back_home".tr);
      writeln("");
      String select = read();
      await selectFunctionSecond(select);
      writeln("");
    }
  }
}
