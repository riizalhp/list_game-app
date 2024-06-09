import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'isloadinglogin_event.dart';
part 'isloadinglogin_state.dart';

class IsloadingloginBloc
    extends Bloc<IsloadingloginEvent, IsloadingloginState> {
  IsloadingloginBloc() : super(const IsloadingloginInitial()) {
    on<LoadingLoginSelesaiEvent>((event, emit) {
      emit(IsloadingloginLoaded(isloading: event.isLoading));
    });

    on<LoadingLoginStartEvent>((event, emit) {
      emit(IsloadingloginLoaded(isloading: event.isLoading));
    });
  }
}
