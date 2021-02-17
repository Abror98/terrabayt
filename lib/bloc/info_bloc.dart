import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:terrabayt/model/info_model.dart';
import 'package:terrabayt/net/network_error/internet_error.dart';
import 'package:terrabayt/net/repository/repository.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final InfoRepository infoRepository = InfoRepository();
  final BuildContext context;
  List<NewsModel> list = [];

  InfoBloc(this.context) : super(InfoLoading());

  @override
  Stream<InfoState> mapEventToState(InfoEvent event) async* {
    if (event is InfoEvent)
      yield* infoFunc(event);
  }

  Stream<InfoState> infoFunc(InfoEvent infoEvent) async*{
    yield InfoLoading();
    try {
      list = await infoRepository.getNewsList(
          infoEvent.firstUpdate, infoEvent.lastUpdate, infoEvent.category,
          infoEvent.limit);
      if(list.isEmpty)
      yield InfoListError(error: NoInformationClass("List bo'sh"));
      else
      yield InfoLoaded(list: list);
    } on SocketException{
      yield InfoListError(error: NoInternetException('No Internet'));
    } on HttpException{
      yield InfoListError(error: NoServiceFoundException('No Service found'));
    } on FormatException{
      yield InfoListError(error: InvalidFormatException('Invalid Responce format'));
    }
    on TimeoutException{
      yield InfoListError(error: TimeOutException("Time out"));
    }
    catch(e){
      yield InfoListError(error: UnknownException('Unknown error'));
    }
  }
}
