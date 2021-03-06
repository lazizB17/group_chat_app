import 'dart:convert';
import 'dart:io';
import 'package:group_chat_app/service/ext_service.dart';

import '../model/users_model.dart';
import 'io_service.dart';
import 'network_service.dart';


class ContactService {
  final Directory _directory =
  Directory(Directory.current.path + "/assets/files ");
  late File _file;

  ///Create
  Future<void> init() async {
    bool isDirectoreyCreated = await _directory.exists();
    if (!isDirectoreyCreated) {
      await _directory.create();
    }
    _file = File(_directory.path + "//contacts.json");
    bool isContactsFileCreatd = await _file.exists();

    if (!isContactsFileCreatd) {
      await _file.create();
      await _file.writeAsString("{}");
    }
  }

//Store
  Future<bool> storeContact({required Map<String, dynamic> contact}) async {
    await init();

    bool result = false;

    Map<String, dynamic> dataBase = contact;

    String source = jsonEncode(dataBase);
    await _file
        .writeAsString(source)
        .whenComplete(() => {result = true})
        .catchError((_) {
      return result;
    });

    return result;
  }

//Read
  Future<String> readContact({required String key}) async {
    await init();

    Map<String, dynamic> dataBase;
    String source = await _file.readAsString();
    if (source.isEmpty) {
      dataBase = {};
    } else {
      dataBase = jsonDecode(source);
    }
    dataBase.forEach((keyM, valueM) {
      if (keyM == key) {
        return valueM;
      }
    });
    return "";
  }

  Future<bool> deleteContact({required String key}) async {
    bool result = false;
    String source = await _file.readAsString();

    if (source.isEmpty) {
      return false;
    }

    Map<String, dynamic> dataBase = jsonDecode(source);

    dataBase.remove(key);
    source = jsonEncode(dataBase);
    await _file
        .writeAsString(source)
        .whenComplete(() => {result = true})
        .catchError((_) {
      result = false;
    });
    return result;
  }

  Future<bool> clearContact() async {
    bool result = false;
    String source = await _file.readAsString();

    if (source.isEmpty) {
      return result;
    }
    await _file
        .writeAsString("{}")
        .whenComplete(() => {result = true})
        .catchError((_) {
      result = false;
    });
    return result;
  }

  Future<Map<String,dynamic>> getContacts() async {
    await init();
    await _downloadContacts();
    Map<String, dynamic> dataBase;
    String source = await _file.readAsString();
    if (source.isEmpty) {
      dataBase = {};
    } else {
      dataBase = jsonDecode(source);
    }

    return dataBase;
  }

  Future<void> readAllContact() async {
    await init();

    await _downloadContacts();

    Map<String, dynamic> dataBase;
    String source = await _file.readAsString();
    if (source.isEmpty) {
      dataBase = {};
    } else {
      dataBase = jsonDecode(source);
    }

    dataBase.forEach((key, value) {
      int colmn = 18 - value[0].toString().length;
      String columnSize = ' ' * colmn;

      writeln("ID " +
          key +
          "   " +
          "Name - " +
          value[0] +
          columnSize +
          "Phone - " +
          value[1]);
    });
  }

  Future<bool> _downloadContacts() async {
    await storeContact(contact: await parseContacts());
    return true;
  }

  Future<Map<String, dynamic>> parseContacts() async {
    String result = await NetworkService.GET(
        NetworkService.apiUsers, NetworkService.headers);

    if(result == '404'){
      writeln("empty".tr);
      return {};
    }
    List data = jsonDecode(result);
    List<User> user = NetworkService.parseUsers(data);

    Map<String, dynamic> map = {};
    user.forEach((element) async {
      map.addAll({
        element.id.toString(): [element.name, element.number]
      });
    });
    return map;
  }
}

