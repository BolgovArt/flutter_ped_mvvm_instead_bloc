import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ped_mvvm_instead_block/domain/entity/user.dart';
import 'package:provider/provider.dart';

import 'package:flutter_ped_mvvm_instead_block/domain/services/user_service.dart';

class ViewModelState {
  final String ageTitle;
  ViewModelState({
    required this.ageTitle,
  });
}

class ViewModel extends ChangeNotifier{
  final _userService = UserService();
  var _state = ViewModelState(ageTitle: '');
  ViewModelState get state => _state;
  StreamSubscription<User>? userSubscription;

  ViewModel() {
    _state = ViewModelState(ageTitle: _userService.user.age.toString());
    userSubscription = _userService.userStream.listen((User user){ // на каждом событии стрима обновляется State и уведомляются подписчики
      _state = ViewModelState(ageTitle: _userService.user.age.toString());
      notifyListeners();
    }); // функция .listen возвращает StreamSubscription, теперь эту подписку можно сохранить, положив прослушку в userSubscription
    _userService.openConnect();
  }

//? Зачем dispose?
// подписка начинается когда экран появляется, заканчивать подписку надо когда закрывается экран
  @override
  void dispose() {
    userSubscription?.cancel();
    _userService.closeConnect();
    super.dispose();
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: _AgeTitle(),
        )
        ),
    );
  }
}

class _AgeTitle extends StatelessWidget {
  const _AgeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.select((ViewModel vm) => vm.state.ageTitle);
    return Text(title);
  }
}