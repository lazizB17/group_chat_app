import 'package:group_chat_app/service/ext_service.dart';
import '../../model/home_model.dart';
import '../../service/contact_service.dart';
import '../../service/io_service.dart';
import '../../service/network_service.dart';
import 'package:group_chat_app/pages/navigate_menu.dart';

class AddContact extends Menu {
  static final String id = "add_contact_menu";

  ContactService _contact = ContactService();

  Future<void> add() async {
    try {
      await _contact.getContacts();
      await _contact.readAllContact();
    } catch (e) {
      if (e == "404") {
        writeln("empty".tr);
        Navigator.pop();
      }
      print(e);
      write("....");
      await waitingCont();
      write("....");
      await waitingCont();
      write("....");
      await waitingCont();
      writeln("....");
      await add();
    }
    writeln("");
    write("phone".tr + ": ");
    String phone = validPhone();
    writeln("");
    write("name".tr + ": ");
    String name = read();
    writeln("");

    await NetworkService.POST(NetworkService.apiUsers, NetworkService.headers,
        {"name": name, "number": phone});

    await _contact.readAllContact();

  }

  @override
  Future<void> build() async {
    writeln("");
    await add();
    writeln("");
    Navigator.pop();
  }
}
