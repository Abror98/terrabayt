part of 'info_bloc.dart';

abstract class InfoState extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InfoLoading extends InfoState {}


class InfoLoaded extends InfoState{
  final List<NewsModel> list;
  InfoLoaded({this.list});
  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class InfoListError extends InfoState{
  final error;
  InfoListError({this.error});
}