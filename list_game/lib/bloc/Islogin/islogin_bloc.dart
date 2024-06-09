
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'islogin_event.dart';
part 'islogin_state.dart';

class IsloginBloc extends Bloc<IsloginEvent, IsloginState> {
  IsloginBloc() : super(const IsloginInitial()) {
    on<UserLoginEvent>((event, emit) {
      emit(IsloginLoading(isLogin: event.isLogin));
    });

    on<UserSignoutEvent>((event, emit) {
      emit(IsloginLoading(isLogin: event.isLogin));
    });
  }
}
