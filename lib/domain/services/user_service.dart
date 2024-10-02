import 'package:flutter/material.dart';
import 'package:flutter_ped_mvvm_instead_block/domain/data_providers/data_provider.dart';
import 'package:flutter_ped_mvvm_instead_block/domain/entity/user.dart';

// typedef UserServiceOnUpdate = void Function(User);

// сервис проксирует изменения наружу
class UserService {
  final _userDataProvider = UserDataProvider();

//   VoidCallback? _currentOnUpdate;

//   void startListenUser(UserServiceOnUpdate onUpdate) {
// //? ------------- вот это вот всё нахрена? ---------------
//     final currentOnUpdate = () {
//       onUpdate(_userDataProvider.user);
//     };
//     _currentOnUpdate = currentOnUpdate;
//     _userDataProvider.addListener(currentOnUpdate);
//     onUpdate(_userDataProvider.user);
// //? ------------------------------------------------------

//     _userDataProvider.openConnect();
//   }

  void startListenUser(void Function(User) onUpdate) { // функция будет вызываться, когда User будет обновляться
    _userDataProvider.addListener((){ // потом настраивается слушатель. Если сразу вызвать _userDataProvider.openConnect(); событие может пролететь
      onUpdate(_userDataProvider.user);
    });
    onUpdate(_userDataProvider.user); // вдруг там уже есть какое-то значение, вызываем onUpdate с текущим значением которое сейчас есть
    _userDataProvider.openConnect(); // потом уже коннект 
  }

  // void stopListenUser() {
  //   final currentOnUpdate = _currentOnUpdate; // создана переменная для того, чтобы можно было проверить ее в след строке
  //   if (currentOnUpdate != null) {
  //     _userDataProvider.removeListener(currentOnUpdate);
  //   }
  // }
}