import 'package:group_chat_app/service/ext_service.dart';
import '../../model/home_model.dart';
import '../../pages/navigate_menu.dart';
import '../../service/io_service.dart';
import '../home_menu.dart';
import 'delete_all_menu.dart';
import 'delete_chose_menu.dart';

class DeleteContact extends Menu {
  static final String id = "/delete_contact_menu";

  Future<void> selectMenu() async {
    String select = read();
    switch (select) {
      case "I":
        {
          await Navigator.push(DeleteChose());
        }
        break;
      case "II":
        {
          await Navigator.push(DeleteAll());
        }
        break;
      case "III":
        {
          await Navigator.pop();
        }
        break;
      case "IV":
        {
          await Navigator.popUntil();
        }
        break;
      default:
        {
          writeln("error".tr);
          await build();
        }
    }
  }

  @override
  Future<void> build() async {
    writeln("");
    writeln("I. " + "delete_one".tr);
    writeln("II." + "delete_all".tr);
    writeln("III." + "back".tr);
    writeln("IV." + "back_home".tr);
    writeln("");
    await selectMenu();
    writeln("");
    Navigator.pushReplacement(HomeMenu());
  }
}
