import 'dart:convert';
import 'package:group_chat_app/service/ext_service.dart';
import '../../model/home_model.dart';
import '../../model/message_model.dart';
import '../../service/chat_service.dart';
import '../../service/contact_service.dart';
import '../../service/data_service.dart';
import '../../service/io_service.dart';
import '../../service/network_service.dart';
import 'package:group_chat_app/pages/navigate_menu.dart';

class SendMessage extends Menu {
  static final String id = "send_message_menu";

  final DataService _dataService = DataService();

  Future<void> sendMessage() async {
    ChatService chat = ChatService();
    ContactService contact = ContactService();
    bool status = false;
    bool chatStatus = true;
    await contact.readAllContact();

    List history = [];
    List index = [];
    String? user;
    String msg = 'is empty';
    String text = '';
    String myId = '';

    String? res;

    do {
      writeln("who".tr);
      user = read();

      res = await NetworkService.GET(
          NetworkService.apiMessages, NetworkService.headers);

      String id = await _dataService.readDate(key: "id");

      if (id == "") {
        writeln('id'.tr);
        myId = read();
        await _dataService.storeData(key: 'id', value: myId);
      } else {
        if (id == user) {
          writeln("error".tr);
          status = true;
        }
        myId = id;
      }
    } while (status);
    if (res.isNotEmpty) {
      List l = jsonDecode(res);
      List<Message> m = l.map((e) => Message.fromJson(e)).toList();

      for (var element in m) {
        if (element.id == id) {
          history.add(element.message);
        }
      }
    }
    List chats = await chat.readChat(key: user!);

    if (chats.isNotEmpty) {
      history.addAll(chats);
      history.add(" " * 10 + time());
    } else {
      history = [" " * 10 + time()];
    }

    writeln("instruction".tr);
    off:
    do {
      writeln("\n\n\n\n\n\n");
      for (var element in history) {
        print(element);
      }
      index.clear();
      text = '';

      one:
      while (true) {
        msg = read();

        if (msg == ">") {
          break one;
        }

        if (msg.toLowerCase() == "off") {
          text = "off";
          break off;
        }
        text += msg;
      }
      text += "|" + sendTime() + "\n";
      history.add("\t\t\t\t\t\t\t\t" + text);
      try {
        await NetworkService.POST(
            NetworkService.apiMessages,
            NetworkService.headers,
            {'from': myId, 'to': user, 'message': text});
      } catch (e) {
        print(e);
      }
      while (true) {
        if (msg == 'cancel') {
          break;
        }
        await waiting();
        String response = '';
        try {
          response = await NetworkService.GET(
              NetworkService.apiMessages, NetworkService.headers);
        } catch (e) {
          print(e);
        }

        List list = jsonDecode(response);

        List<Message> message = await NetworkService.parseMessage(list);

        a:
        for (var element in message) {
          if (user == element.from.toString()) {
            if (!history.contains(element.message)) {
              if (element.message == "off") {
                msg = 'cancel';
                break a;
              }
              history.add(element.message.toString());
              index.add(element.id.toString());
            }
          }
        }
        if (index.isNotEmpty) {
          break;
        }
      }

      try {
        await deleteResponse(index);
      } catch (e) {
        print(e);
      }
    } while (msg != "cancel");
    if (chatStatus) {
      await NetworkService.POST(NetworkService.apiMessages,
          NetworkService.headers, {'from': myId, 'to': user, 'message': text});
    }
    await chat.storeChat(key: user, value: history);
    await Navigator.pop();
  }

  @override
  Future<void> build() async {
    writeln("");
    await sendMessage();
    writeln("");
  }
}
