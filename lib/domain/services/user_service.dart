import 'package:flutter_ped_mvvm_instead_block/domain/data_providers/data_provider.dart';
import 'package:flutter_ped_mvvm_instead_block/domain/entity/user.dart';

typedef UserServiceOnUpdate = void Function(User);

// сервис получился бесполезным - просто абстракция над UserDataProvider
class UserService {
  final _userDataProvider = UserDataProvider();



  User get user => _userDataProvider.user; //  получаем user из UserDataProvider
  Stream<User> get userStream => _userDataProvider.userStream;

  // void startListenUser() {
  void openConnect() {
    _userDataProvider.openConnect();
  }


  // void stopListenUser() {
  void closeConnect() {
    _userDataProvider.closeConnect();
  }
}