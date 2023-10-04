import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vquiz_app/src/res/colors.dart';
import 'package:vquiz_app/src/res/dimens.dart';

import 'package:vquiz_app/src/services/utils/print_log.dart';
import 'package:vquiz_app/src/views/topics/components/topic_card_widget.dart';
import 'package:vquiz_app/src/views/topics/cubit/topic_cubit.dart';
import 'package:vquiz_app/src/views/topics/models/topic_model.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key, required this.data});
  final List<TopicModel> data;
  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  List<TopicModel> _data = [];

  void _getTopicList() {
    PrintLog().printPrimary("_getTopicList() initiated");
    context.read<TopicCubit>().getTopicList();
  }

  @override
  void initState() {
    if (widget.data.isEmpty) {
      _getTopicList();
    } else {
      _data = widget.data;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: primaryColor),
          BlocConsumer<TopicCubit, TopicState>(
            listener: (context, state) {
              if (state is TopicLoading) {
                PrintLog().printPrimary("State loading");
              } else if (state is TopicError) {
                PrintLog().printError("State Error => ${state.error.message}");
              } else if (state is TopicListSuccess) {
                PrintLog().printSuccess("State success");

                _data = state.data;
              }
            },
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    centerTitle: true,
                    title: const Text("Topics"),
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    forceElevated: false,
                    elevation: sliverAppElevation,
                    floating: true,
                    flexibleSpace: const FlexibleSpaceBar(),
                    expandedHeight: 60,
                  ),
                  state is TopicLoading
                      ? const SliverFillRemaining(
                          fillOverscroll: false,
                          hasScrollBody: false,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, i) => TopicCardWidget(
                                  data: _data,
                                  idx: i,
                                  itemLength: _data.length),
                              childCount: _data.length))
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
