import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'datauser_event.dart';
part 'datauser_state.dart';

class DatauserBloc extends Bloc<DatauserEvent, DatauserState> {
  DatauserBloc() : super(DatauserInitial()) {
    on<DatauserEventFetch>(((event, emit) {
      emit(DatauserLoad(event.disukai));
    }));
  }
}
