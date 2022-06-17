import 'package:group_chat_app/pages/navigate_menu.dart';
import 'package:group_chat_app/service/ext_service.dart';
import '../../model/home_model.dart';
import '../../service/contact_service.dart';
import '../../service/io_service.dart';
import '../../service/network_service.dart';

class DeleteAll extends Menu {
  static final String id = "/delete_all_menu";
  ContactService _service = ContactService();

  Future<void> deleteAll() async {
    List index = [];
    Map? source;

    try{
      source = await _service.getContacts();
    }catch(e){
      if(e == "404"){
        writeln("empty".tr);
        Navigator.pop();
      }
      write("....25");
      await waitingCont();
      write("....50");
      await waitingCont();
      write("....75");
      await waitingCont();
      writeln("....100");
      await deleteAll();
    }
    source!.forEach((key, value) {
      index.add(key);
    });
    for (int i = 0; i < index.length; i++) {
      await NetworkService.DELETE(
          NetworkService.apiUsers +"/"+ index[i], NetworkService.headers);
    }
    await _service.getContacts();

  }

  @override
  Future<void> build() async{
    writeln("");
    await deleteAll();
    writeln("success_update".tr);
    writeln("");
    Navigator.pop();
  }
}