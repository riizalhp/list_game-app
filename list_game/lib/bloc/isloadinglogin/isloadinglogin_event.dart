part of 'isloadinglogin_bloc.dart';

@immutable
abstract class IsloadingloginEvent {}

class LoadingLoginSelesaiEvent extends IsloadingloginEvent {
  final bool isLoading;

  LoadingLoginSelesaiEvent({this.isLoading = false});
}

class LoadingLoginStartEvent extends IsloadingloginEvent {
  final bool isLoading;

  LoadingLoginStartEvent({this.isLoading = true});
}
