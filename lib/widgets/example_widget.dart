// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_ped_mvvm_instead_block/domain/services/user_service.dart';

class ViewModelState {
  final String ageTitle;
  ViewModelState({
    required this.ageTitle,
  });
}
// ? Почему ViewModel тоже ChangeNotifier?
class ViewModel extends ChangeNotifier{
  final _userService = UserService();
  var _state = ViewModelState(ageTitle: '');
  ViewModelState get state => _state;

  ViewModel() {
    _userService.startListenUser((user) {
      _state = ViewModelState(ageTitle: user.age.toString());
      notifyListeners();
    });
  }
//? Зачем dispose?
  @override
  void dispose() {
    // _userService.stopListenUser();
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