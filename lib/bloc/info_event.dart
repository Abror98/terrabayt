part of 'info_bloc.dart';

@immutable
abstract class MainEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class InfoEvent extends MainEvent{
   final int category, limit;
   InfoEvent({this.category, this.limit});
}

class EventItemPressed extends MainEvent{
   final int index;

   EventItemPressed({this.index});

   @override
  List<Object> get props => [index];
}

class NextEvent extends MainEvent{
   final int firstUpdate, lastUpdate, category, limit;
   NextEvent({this.firstUpdate, this.lastUpdate, this.category, this.limit});
}
