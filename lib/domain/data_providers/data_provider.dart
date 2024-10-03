import 'dart:async';

import 'package:flutter_ped_mvvm_instead_block/domain/entity/user.dart';

class UserDataProvider{
  var _user = User(0); 
  final _controller = StreamController<User>(); // создали стрим
  Stream<User> get userStream => _controller.stream.asBroadcastStream(); // стрим можно забирать || .asBroadcastStream() - чтобы получать стрим с любого места
  User get user => _user; // можно получать текущее значение User


  Timer? _timer;

// Timer - просто суррогатный код
  void openConnect() {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_){
      _user = User(_user.age + 1); // в openConnection обновляются как текущие значения тут
      _controller.add(_user); // так и в стриме
    });
  }

  void closeConnect() {
    _timer?.cancel();
    _timer = null;
  }
}