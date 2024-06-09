part of 'datauser_bloc.dart';

@immutable
abstract class DatauserState {
  final List disukai;

  const DatauserState(this.disukai);
}

class DatauserInitial extends DatauserState {
  DatauserInitial() : super([]);
}

class DatauserLoad extends DatauserState {
  const DatauserLoad(super.disukai);
}
