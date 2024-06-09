part of 'islogin_bloc.dart';

@immutable
abstract class IsloginState {
  final bool isLogin;
  const IsloginState(this.isLogin);
}

class IsloginInitial extends IsloginState {
  const IsloginInitial() : super(false);
}

class IsloginLoading extends IsloginState {
  const IsloginLoading({required bool isLogin}) : super(isLogin);
}
