part of 'info_bloc.dart';

@immutable
abstract class MainEvent {}

class InfoEvent extends MainEvent{
   final int category, limit;
   InfoEvent({this.category, this.limit});
}

class NextEvent extends MainEvent{
   final int firstUpdate, lastUpdate, category, limit;
   NextEvent({this.firstUpdate, this.lastUpdate, this.category, this.limit});
}
