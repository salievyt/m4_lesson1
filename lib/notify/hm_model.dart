import 'package:flutter/foundation.dart';

class HmModel extends ChangeNotifier {
  Future<String> loadData() async {
    await Future.delayed(const Duration(seconds: 5));
    return 'Данные загрузились';
  }
}
