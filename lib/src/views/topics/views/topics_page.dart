import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vquiz_app/src/res/colors.dart';
import 'package:vquiz_app/src/res/dimens.dart';
import 'package:vquiz_app/src/res/styles.dart';

import 'package:vquiz_app/src/services/utils/print_log.dart';
import 'package:vquiz_app/src/views/topics/cubit/topic_cubit.dart';
import 'package:vquiz_app/src/views/topics/models/topic_model.dart';
import 'package:vquiz_app/src/views/topics/views/quiz_page.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key, required this.data});
  final List<TopicModel> data;
  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  List<TopicModel> _data = [];

  void _getTopicList() {
    print("_getTopicList() initiated");
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
              /// Listener from [PosterState]
              ///
              if (state is TopicLoading) {
                PrintLog().printPrimary("State loading");
              } else if (state is TopicError) {
                PrintLog().printError("State Error => ${state.error.message}");
              } else if (state is TopicListSuccess) {
                // logger.i("Info log");
                // logger.d("debug log");
                // logger.t("trace log");
                // Logger(printer: SimplePrinter(colors: true)).i('boom');

                PrintLog().printSuccess("State success");

                /// Store data from [PosterSuccess] to [_data]
                ///
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
                    // backgroundColor: Colors.white,
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    // actions: [
                    // Container(
                    //   margin: const EdgeInsets.only(right: 15),
                    //   decoration: BoxDecoration(
                    //       // color: CustomColors().themeOrange.withOpacity(0.25),
                    //       borderRadius: BorderRadius.circular(5)),
                    //   child: Material(
                    //     type: MaterialType.transparency,
                    //     shape: const CircleBorder(),
                    //     // borderRadius: BorderRadius.circular(5),
                    //     clipBehavior: Clip.hardEdge,
                    //     child: IconButton(
                    //         splashRadius: 30,
                    //         padding: const EdgeInsets.all(2),
                    //         constraints: const BoxConstraints(),
                    //         splashColor: Colors.grey.shade300,
                    //         onPressed: () {
                    //           setState(
                    //               () => _isAppMenuStyleGrid = !_isAppMenuStyleGrid);
                    //         },
                    //         icon: Icon(
                    //           !_isAppMenuStyleGrid
                    //               ? CupertinoIcons.list_bullet
                    //               : CupertinoIcons.square_grid_3x2,
                    //           // color: CustomColors().themeOrange,
                    //           size: 18,
                    //         )),
                    //   ),
                    // )
                    // ],
                    forceElevated: false,
                    elevation: sliverAppElevation,
                    // shadowColor: _customColors.sliverAppShadowColor,
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

class TopicCardWidget extends StatelessWidget {
  const TopicCardWidget({
    super.key,
    required this.data,
    required this.idx,
    required this.itemLength,
  });

  final List<TopicModel> data;
  final int idx, itemLength;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuizPage(
                      data: data[idx],
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(
            left: 20, right: 20, bottom: idx == itemLength - 1 ? 20 : 10),
        padding: PAD_ALL_20,
        // height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Text(data[idx].topicName.toString(),
                style: normalStyleWhite.apply(fontSizeDelta: 3)),
            const Spacer(),
            const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
