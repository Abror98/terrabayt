part of 'info_bloc.dart';

@immutable
abstract class MainEvent {}

class InfoEvent extends MainEvent{
   final int firstUpdate, lastUpdate, category, limit;
   InfoEvent({this.firstUpdate, this.lastUpdate, this.category, this.limit});
}
