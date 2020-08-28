import 'package:flutter/cupertino.dart';

class prograssHud extends ChangeNotifier{
  bool isLoading =false;
  changhisLoading(bool value){
    isLoading=value;
    notifyListeners();
}
}