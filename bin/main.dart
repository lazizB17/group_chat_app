import 'package:group_chat_app/menu/contacts/add_contact_menu.dart';
import 'package:group_chat_app/menu/contacts/delete_all_menu.dart';
import 'package:group_chat_app/menu/contacts/delete_chose_menu.dart';
import 'package:group_chat_app/menu/contacts/delete_contact_menu.dart';
import 'package:group_chat_app/menu/home_menu.dart';
import 'package:group_chat_app/menu/message/send_message_menu.dart';
import 'package:group_chat_app/menu/settings/settings_menu.dart';
import 'package:group_chat_app/service/chat_app_service.dart';
import 'package:group_chat_app/service/io_service.dart';
import 'package:group_chat_app/service/lang_service.dart';

void main()async{
  print(time());
  try {
    MyApp(
      home: HomeMenu(),
      locale: await LangService.currentLanguage(),
      routes: {
        HomeMenu.id: HomeMenu(),
        AddContact.id: AddContact(),
        DeleteContact.id: DeleteContact(),
        DeleteAll.id: DeleteAll(),
        DeleteChose.id: DeleteChose(),
        SendMessage.id: SendMessage(),
        SettingsMenu.id: SettingsMenu(),
      },
    );
  }catch(e){
    main();
  }
}
