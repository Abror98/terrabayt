import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:terrabayt/bloc/info_bloc.dart';
import 'package:terrabayt/widgets/bottom_widget.dart';
import 'package:terrabayt/widgets/drawer.dart';
import 'package:terrabayt/widgets/listview_builder.dart';

class BaseScreen extends StatefulWidget{
  int category;
  BaseScreen(int category){
    this.category = category;
  }

  static Widget screen(int category) => BlocProvider(
        create: (context) => InfoBloc(context),
        child: BaseScreen(category),
      );

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  InfoBloc bloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    bloc = BlocProvider.of<InfoBloc>(context);
    bloc.add(InfoEvent(category: widget.category, limit: 30));
    _scrollController.addListener(() => onScroll());
    super.initState();
  }

  void onScroll() {
    if (bloc.state is InfoLoadedState == false) return;
    if (!_scrollController.hasClients) return;
    final double maxHeight = _scrollController.position.maxScrollExtent;
    final double currentHeight = _scrollController.offset;
    if (currentHeight >= maxHeight * 0.9) {
      bloc.add(NextEvent(
        firstUpdate: bloc.list[bloc.list.length - 1].publishedAt,
        lastUpdate: 0,
        category: widget.category,
        limit: 30,
      ));
    }
  }
  @override
  void dispose() {
    bloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocBuilder<InfoBloc, InfoState>(builder: (context, state) {
        if (state is BottomLoadingState) {
          return BottomLoading();
        }
        return SizedBox();
      }),
      body: bodyWidget(),
    );
  }

  Container bodyWidget() => Container(
          child: BlocBuilder<InfoBloc, InfoState>(builder: (context, state) {
        if (state is InfoListErrorState) {
          final error = state.error;
          String message = '${error.message}';
          return Center(child: Text(message));
        }
        if (state is InfoLoadedState) {
          return ListViewBuilder(
              controller: _scrollController, list: state.list);
        }
        if (state is BottomLoadingState) {
          return ListViewBuilder(
              controller: _scrollController, list: state.list);
        }
        return Center(child: SpinKitFadingCircle(color: Colors.grey));
      }));
}
