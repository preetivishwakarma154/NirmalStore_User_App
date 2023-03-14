import 'package:flutter/foundation.dart';

class countprovider with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void setcount() {
    _count++;
    notifyListeners();
  }
}
