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

class InfoBloc extends Bloc<MainEvent, InfoState> {
  final InfoRepository infoRepository = InfoRepository();
  final BuildContext context;
  List<NewsModel> list = [];

  InfoBloc(this.context) : super(InfoLoadingState());

  @override
  Stream<InfoState> mapEventToState(MainEvent event) async* {
    if (event is InfoEvent)
      yield* infoFunc(event);
    else
      yield* nextFunc(event);
  }

  Stream<InfoState> infoFunc(InfoEvent infoEvent) async* {
    yield InfoLoadingState();
    try {
      list = await infoRepository.getNewsList(
          0, 0, infoEvent.category, infoEvent.limit);
      if (list.isEmpty)
        yield InfoListErrorState(error: NoInformationClass("No information"));
      else
        yield InfoLoadedState(list: list);
    } on SocketException {
      yield InfoListErrorState(error: NoInternetException('No Internet'));
    } on HttpException {
      yield InfoListErrorState(error: NoServiceFoundException('No Service found'));
    } on FormatException {
      yield InfoListErrorState(
          error: InvalidFormatException('Invalid Responce format'));
    } on TimeoutException {
      yield InfoListErrorState(error: TimeOutException("Time out"));
    } catch (e) {
      yield InfoListErrorState(error: UnknownException('Unknown error'));
    }
  }

  Stream<InfoState> nextFunc(NextEvent nextEvent) async* {
    yield BottomLoadingState(list: list);
    try {
      (await infoRepository.getNewsList(nextEvent.firstUpdate,
              nextEvent.lastUpdate, nextEvent.category, nextEvent.limit))
          .forEach((element) => list.add(element));
      if (list.isEmpty)
        yield InfoListErrorState(error: NoInformationClass("No information"));
      else
        yield InfoLoadedState(list: list);
    } on SocketException {
      yield InfoListErrorState(error: NoInternetException('No Internet'));
    } on HttpException {
      yield InfoListErrorState(error: NoServiceFoundException('No Service found'));
    } on FormatException {
      yield InfoListErrorState(
          error: InvalidFormatException('Invalid Responce format'));
    } on TimeoutException {
      yield InfoListErrorState(error: TimeOutException("Time out"));
    } catch (e) {
      yield InfoListErrorState(error: UnknownException('Unknown error'));
    }
  }
}
