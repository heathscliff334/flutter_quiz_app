import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vquiz_app/src/components/custom_elevated_button.dart';
import 'package:vquiz_app/src/models/data_model.dart';
import 'package:vquiz_app/src/res/colors.dart';
import 'package:vquiz_app/src/res/dimens.dart';
import 'package:vquiz_app/src/res/styles.dart';
import 'package:vquiz_app/src/services/utils/print_log.dart';
import 'package:vquiz_app/src/views/topics/components/selection_radio_widget.dart';
import 'package:vquiz_app/src/views/topics/models/questions_model.dart';
import 'package:vquiz_app/src/views/topics/models/topic_model.dart';

class QuizPage extends StatefulWidget {
  final TopicModel data;
  const QuizPage({super.key, required this.data});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final ValueNotifier<double> _progress = ValueNotifier(0);
  final int _totalMilliseconds = 30000; // 30 seconds
  // final int _totalMilliseconds = 5000; // 30 seconds
  int _currentMilliseconds = 0;
  int currentQuestion = 0;
  Timer? _timer;

  @override
  void initState() {
    _startTimer();
    inspect(widget.data);
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: primaryColor),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                title: const Text("Quiz Page"),
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

                forceElevated: false,
                elevation: sliverAppElevation,
                // shadowColor: _customColors.sliverAppShadowColor,
                floating: true,
                flexibleSpace: const FlexibleSpaceBar(),
                expandedHeight: 60,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Stack(
                  children: [
                    QuestionCardWidget(
                      data: widget.data.questions!,
                      currentIndex: currentQuestion,
                      onTap: (v) {
                        if (v) {
                          if (currentQuestion <
                              widget.data.questions!.length - 1) {
                            currentQuestion++;
                            _currentMilliseconds = 0;
                            setState(() {});
                          } else {
                            _timer!.cancel();
                            _currentMilliseconds = _totalMilliseconds;
                            final progress =
                                _currentMilliseconds / _totalMilliseconds;
                            _progress.value = progress;

                            setState(() {});
                            // _startTimer(stopTimer: true);
                          }
                        }
                      },
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: ValueListenableBuilder(
                          valueListenable: _progress,
                          builder: (context, value, _) {
                            return Visibility(
                              visible: double.parse(value.toString()) != 1.0,
                              child: LinearProgressIndicator(
                                value: double.parse(value.toString()),
                                backgroundColor: Colors.white,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(loadingColor),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ]))
              // SliverFillRemaining(
              //   hasScrollBody: false,
              //   fillOverscroll: false,
              //   child: Stack(
              //     children: [
              //       QuestionCardWidget(
              //         data: widget.data.questions!,
              //         currentIndex: currentQuestion,
              //       ),
              //       Positioned(
              //         top: 0,
              //         left: 0,
              //         right: 0,
              //         child: ValueListenableBuilder(
              //             valueListenable: _progress,
              //             builder: (context, value, _) {
              //               return Visibility(
              //                 visible: double.parse(value.toString()) != 1.0,
              //                 child: LinearProgressIndicator(
              //                   value: double.parse(value.toString()),
              //                   backgroundColor: Colors.white,
              //                   valueColor:
              //                       AlwaysStoppedAnimation<Color>(loadingColor),
              //                 ),
              //               );
              //             }),
              //       ),
              //     ],
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }

  void _startTimer({bool? stopTimer}) {
    const updateInterval = Duration(milliseconds: 100); // Update every 100ms
    _timer = Timer.periodic(updateInterval, (timer) {
      if (stopTimer == true) {
        _timer!.cancel();
      } else {
        if (_currentMilliseconds < _totalMilliseconds) {
          _currentMilliseconds += updateInterval.inMilliseconds;
          final progress = _currentMilliseconds / _totalMilliseconds;
          _progress.value = progress;
        } else {
          if (currentQuestion < widget.data.questions!.length - 1) {
            PrintLog().printSuccess("current question => $currentQuestion");
            currentQuestion++;
            _currentMilliseconds = 0;
            setState(() {});
          } else {
            timer.cancel();
          }
        }
      }
    });
  }
}

class QuestionCardWidget extends StatelessWidget {
  const QuestionCardWidget({
    super.key,
    required this.data,
    required this.currentIndex,
    required this.onTap,
  });
  final List<Questions> data;
  final int currentIndex;
  final ValueChanged<bool> onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PAD_ALL_20,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            child: Container(
              // height: 50,
              padding: PAD_ASYM_H20_V10,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data[currentIndex].question.toString(),
                    style: boldStyle,
                    textAlign: TextAlign.center,
                  ),
                  data[currentIndex].image != null
                      ? Container(
                          margin: PAD_ONLY_T10,
                          child: Image.network(
                            data[currentIndex].image.toString(),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: data[currentIndex].choices!.length,
            itemBuilder: (context, index) {
              Data choice = Data(
                  label: data[currentIndex].choices![index].choice,
                  value:
                      data[currentIndex].choices![index].choiceId.toString());

              return Container(
                margin: PAD_ONLY_T20,
                // height: 20,
                width: double.infinity,
                // color: Colors.red,
                child: CustomElevatedButton(
                    borderRadius: BorderRadius.circular(20),
                    onPressed: () {
                      onTap(true);
                    },
                    child: Text(
                      choice.label.toString(),
                      style: normalStyle.apply(color: Colors.black54),
                    )),
              );
            },
          )
        ],
      ),
    );
  }
}
