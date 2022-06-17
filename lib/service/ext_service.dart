import 'lang_service.dart';
import 'loc/en_EN.dart';
import 'loc/ru_RU.dart';
import 'loc/uz_UZ.dart';

extension Ext on String {
  String get tr {
    switch (LangService.language) {
      case Language.en:
        return enEN[this] ?? this;
      case Language.ru:
        return ruRU[this] ?? this;
      case Language.uz:
        return uzUZ[this] ?? this;
    }
  }
}
