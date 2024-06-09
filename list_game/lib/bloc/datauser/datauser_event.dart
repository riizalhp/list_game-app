part of 'datauser_bloc.dart';

@immutable
abstract class DatauserEvent {}

class DatauserEventFetch extends DatauserEvent {
  final List disukai;
  DatauserEventFetch({
    required this.disukai,
  });
}
