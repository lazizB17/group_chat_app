import 'package:group_chat_app/service/ext_service.dart';
import '../../model/home_model.dart';
import '../../service/check_sevice.dart';
import '../../service/io_service.dart';
import '../../service/security_service.dart';
import 'package:group_chat_app/pages/navigate_menu.dart';

class SecurityMenu extends Menu {
  final SecurityService _service = SecurityService();

  Future<void> selectMenu(String select) async {
    switch (select) {
      case "I":
        await password();
        break;
      case "II":
        await deletePasword();
        break;
      case "III":
        await Navigator.pop();
        break;
      case "IV":
        await Navigator.popUntil();
        break;
      default:
        {
          writeln("error".tr);
          await build();
        }
    }
  }

  Future<void> selectMenuWithNullPassword(String select) async {
    switch (select) {
      case "I":
        await password();
        break;
      case "II":
        await Navigator.pop();
        break;
      case "III":
        await Navigator.popUntil();
        break;
      default:
        {
          writeln("error".tr);
          await build();
        }
    }

  }

  Future<void> password() async {
    bool check = await _service.pasword();
    if (!check) {
      writeln("password_update".tr);
      writeln("yes".tr + "- 1");
      writeln("no".tr + "- 0");

      String password1 = read();

      if (password1 == "0") {
        await Navigator.pop();
      }
      writeln("password_set".tr);
      String password = read();
      await _service.setPassword(password);
      writeln("success_set".tr);
      return;
    }
    // await validator();

    writeln("password_update".tr);
    writeln("yes".tr + "- 1");
    writeln("no".tr + "- 0");

    String password1 = read();

    if (password1 == "0") {
      await Navigator.pop();
    }
    writeln("password_set".tr);
    await _service.setPassword(password1);
    writeln("success_update".tr);
  }

  Future<void> deletePasword() async {
    bool check = await _service.pasword();
    if (!check) {
      writeln("password_not_found".tr);

      return;
    }
    // await validator();
    writeln("password_delete".tr);
    writeln("yes".tr + "- 1");
    writeln("no".tr + "- 0");

    String password1 = read();

    if (password1 == "0") {
      await Navigator.pop();
    }
    await _service.deletePassword();

    writeln("success_update".tr);
  }

  Future<void> passwordSet() async {
    writeln("password_update".tr);
    writeln("yes".tr + "- 1");
    writeln("no".tr + "- 0");

    String password1 = read();

    if (password1 == "0") {
      await Navigator.pop();
    }
    writeln("password_set".tr);
    String password = read();
    await _service.setPassword(password);
    writeln("success_set".tr);
    writeln("success_update".tr);
  }

  @override
  Future<void> build() async {
    writeln("");
    bool pas = await _service.pasword();

    if (pas) {
      await validator();

      writeln("I.  " + "password_update!".tr);
      writeln("II. " + "password_delete!".tr);
      writeln("III." + "back".tr);
      writeln("IV. " + "back_home".tr);
      String select = read();
      writeln("");
      await selectMenu(select);
      writeln("");
    } else {
      writeln("I.  " + "password_set!".tr);
      writeln("II." + "back".tr);
      writeln("III. " + "back_home".tr);
      String select = read();
      await selectMenu(select);
      writeln("");
      await selectMenuWithNullPassword(select);
      writeln("");
    }
  }
}
