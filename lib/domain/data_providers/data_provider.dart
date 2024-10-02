import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ped_mvvm_instead_block/domain/entity/user.dart';

class UserDataProvider extends ChangeNotifier{
  var _user = User(0);
  User get user => _user; // в ui/сервисах нужно узнавать о том, что данные эти меняются. Можно вместо ChangeNotifier сделать user в значениии valueNotifier или же сделать здесь стрим, который будет стримить юзеров
                          // valueNotifier был бы хорош, если в UserDataProvider было бы много всего (зарплаты и тд). Такого в принципе не надо допускать, но если вдруг допустили, то вот.
                          // стримы позволяют цепочку событий. его недостаток - нельзя посмотреть текущее значение. стрим более мощный чем ChangeNotifier, часть его функционала не нужна, поэтому такое.
  Timer? _timer;

// Timer - просто суррогатный код
  void openConnect() {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_){
      _user = User(_user.age + 1);
      notifyListeners();
    });
  }

  void closeConnect() {
    _timer?.cancel();
    _timer = null;
  }
}