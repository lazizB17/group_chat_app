import 'package:group_chat_app/pages/navigate_menu.dart';
import 'package:group_chat_app/service/ext_service.dart';
import '../../model/home_model.dart';
import '../../service/data_service.dart';
import '../../service/io_service.dart';
import '../../service/lang_service.dart';

class LangMenu extends Menu {
  static final String id = "/lang_menu";

  DataService _serv = DataService();

  Future<void> selectLang(String select) async {
    switch (select) {
      case "I":
        {
          LangService.language = Language.uz;
          await _serv.storeData(key: "language", value: "uz");
        }
        break;
      case "II":
        {
          LangService.language = Language.ru;
          await _serv.storeData(key: "language", value: "ru");
        }
        break;
      case "III":
        {
          LangService.language = Language.en;
          await _serv.storeData(key: "language", value: "en");
        }
        break;
      case "IV":
        {
          Navigator.pop();
        }
        break;
      case "V":
        {
          Navigator.popUntil();
        }
        break;
      default:
        {
          writeln("error_chose".tr);
          await build();
        }
    }
  }

  @override
  Future<void> build() async {
    writeln("I.  " + "uzb".tr);
    writeln("II. " + "rus".tr);
    writeln("III." + "eng".tr);
    writeln("IV." + "back".tr);
    writeln("V." + "back_home".tr);

    String select = read();
    writeln("");
    await selectLang(select);
    writeln("");
    await Navigator.pop();
  }
}

