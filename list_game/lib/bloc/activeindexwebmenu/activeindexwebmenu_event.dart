part of 'activeindexwebmenu_bloc.dart';

@immutable
abstract class ActiveindexwebmenuEvent {}

class ChangeactiveindexwebmenuEvent extends ActiveindexwebmenuEvent {
  final String activeindex;
  ChangeactiveindexwebmenuEvent({required this.activeindex});
}
