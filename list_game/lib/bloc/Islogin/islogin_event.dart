part of 'islogin_bloc.dart';

@immutable
abstract class IsloginEvent {}

class UserLoginEvent extends IsloginEvent {
  final bool isLogin;

  UserLoginEvent({this.isLogin = true});
}

class UserSignoutEvent extends IsloginEvent {
  final bool isLogin;

  UserSignoutEvent({this.isLogin = false});
}
