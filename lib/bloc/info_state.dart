part of 'info_bloc.dart';

abstract class InfoState extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InfoLoadingState extends InfoState {}

class BottomLoadingState extends InfoState{
  final List<NewsModel> list;
  BottomLoadingState({this.list});
  @override
  // TODO: implement props
  List<Object> get props => [list];
}


class InfoLoadedState extends InfoState{
  final List<NewsModel> list;
  InfoLoadedState({this.list});
  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class InfoListErrorState extends InfoState{
  final error;
  InfoListErrorState({this.error});
}