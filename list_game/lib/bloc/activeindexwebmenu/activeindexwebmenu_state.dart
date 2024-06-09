part of 'activeindexwebmenu_bloc.dart';

@immutable
abstract class ActiveindexwebmenuState {
  final String activeindexwebmenu;

  const ActiveindexwebmenuState(this.activeindexwebmenu);
}

class ActiveindexwebmenuInitial extends ActiveindexwebmenuState {
  const ActiveindexwebmenuInitial() : super('Login');
}

class ActiveindexwebmenuChanged extends ActiveindexwebmenuState {
  const ActiveindexwebmenuChanged({required String activeindexwebmenu})
      : super(activeindexwebmenu);
}
