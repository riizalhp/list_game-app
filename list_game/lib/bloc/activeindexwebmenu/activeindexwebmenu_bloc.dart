import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'activeindexwebmenu_event.dart';
part 'activeindexwebmenu_state.dart';

class ActiveindexwebmenuBloc
    extends Bloc<ActiveindexwebmenuEvent, ActiveindexwebmenuState> {
  ActiveindexwebmenuBloc() : super(const ActiveindexwebmenuInitial()) {
    on<ChangeactiveindexwebmenuEvent>((event, emit) {
      emit(ActiveindexwebmenuChanged(activeindexwebmenu: event.activeindex));
    });
  }
}
