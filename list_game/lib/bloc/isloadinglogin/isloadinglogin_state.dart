part of 'isloadinglogin_bloc.dart';

@immutable
abstract class IsloadingloginState {
  final bool isloading;

  const IsloadingloginState(this.isloading);
}

class IsloadingloginInitial extends IsloadingloginState {
  const IsloadingloginInitial() : super(false);
}

class IsloadingloginLoaded extends IsloadingloginState {
  const IsloadingloginLoaded({required bool isloading}) : super(isloading);
}
