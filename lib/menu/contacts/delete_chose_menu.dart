import 'package:group_chat_app/service/ext_service.dart';
import 'package:group_chat_app/pages/navigate_menu.dart';
import '../../model/home_model.dart';
import '../../service/contact_service.dart';
import '../../service/io_service.dart';
import '../../service/network_service.dart';

class DeleteChose extends Menu {
  static final String id = "/delete_chose_menu";
  final ContactService _service = ContactService();

  Future<void> deleteCont(String select) async {
    await NetworkService.DELETE(
        NetworkService.apiUsers + "/" + select, NetworkService.headers);

    await _service.init();
  }

  @override
  Future<void> build() async {
    writeln("");
    await _service.readAllContact();
    writeln("");
    writeln("chose".tr);
    writeln("");
    String selecte = read();
    if(selecte == "exit"){
      Navigator.pop();
    }
    await deleteCont(selecte);
    writeln("");
    writeln("success_update".tr);
    writeln("");
    Navigator.pop();
  }
}
