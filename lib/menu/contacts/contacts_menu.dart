import 'package:group_chat_app/service/ext_service.dart';
import '../../model/home_model.dart';
import 'package:group_chat_app/pages/navigate_menu.dart';
import '../../service/contact_service.dart';
import '../../service/io_service.dart';
import 'add_contact_menu.dart';
import 'delete_contact_menu.dart';

class Contacts extends Menu {
  static final String id = "/contacts_menu";
  ContactService _service = ContactService();
  Future<void> selectMenu(String select) async {
    switch (select) {
      case "I":
        {
          await Navigator.push(AddContact());
        }
        break;
      case "II":
        {
          await Navigator.push(DeleteContact());
        }
        break;
      case "III":
        {
          await _service.readAllContact();
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
    writeln("I.  " + "add_contact".tr);
    writeln("II. " + "delete_contact".tr);
    writeln("III." + "read_all".tr);
    writeln("IV." + "back_home".tr);
    writeln("");
    String select = read();
    await selectMenu(select);
    writeln("");
  }
}
