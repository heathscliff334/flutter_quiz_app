// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:vquiz_app/src/res/colors.dart';
import 'package:vquiz_app/src/res/dimens.dart';
import 'package:vquiz_app/src/res/styles.dart';
import 'package:vquiz_app/src/services/utils/common_service.dart';
import 'package:vquiz_app/src/services/utils/print_log.dart';
import 'package:vquiz_app/src/views/home/views/home_page.dart';
import 'package:vquiz_app/src/views/topics/components/question_card_widget.dart';

import 'package:vquiz_app/src/views/topics/models/result.dart';
import 'package:vquiz_app/src/views/topics/models/topic_model.dart';
import 'package:vquiz_app/src/views/topics/views/result_page.dart';

class QuizPage extends StatefulWidget {
  final TopicModel data;
  const QuizPage({super.key, required this.data});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final ValueNotifier<double> _progress = ValueNotifier(0);
  final int _totalMilliseconds = 30000; // 30 seconds
  // final int _totalMilliseconds = 5000;
  int _currentMilliseconds = 0, currentQuestion = 0, _correctAnswer = 0;
  Timer? _timer;

  @override
  void initState() {
    _startTimer();

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
                actions: [
                  Container(
                    margin:
                        const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                    child: SizedBox(
                        // width: 35,
                        height: 35,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            },
                            child: const Text(
                              "Exit",
                              style: normalStyleWhite,
                            ))),
                  ),
                ],
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
                        widget.data.questions![currentQuestion].userAnswer = v;
                        if (v ==
                            widget.data.questions![currentQuestion].answer) {
                          _correctAnswer++;
                          PrintLog().printSuccess(
                              '_correctAnswer => $_correctAnswer');
                        }
                        if (currentQuestion <
                            widget.data.questions!.length - 1) {
                          currentQuestion++;
                          _currentMilliseconds = 0;
                          setState(() {});
                        } else {
                          _timer!.cancel();
                          setState(() {
                            _currentMilliseconds = _totalMilliseconds;
                            final progress =
                                _currentMilliseconds / _totalMilliseconds;
                            _progress.value = progress;
                          });
                          _calculateScore(context);
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
            ],
          )
        ],
      ),
    );
  }

  void _calculateScore(BuildContext context) {
    var _result = Result(
        correctAnswer: _correctAnswer,
        questionLength: widget.data.questions!.length,
        questions: widget.data.questions);
    callLoader(context);

    Future.delayed(const Duration(milliseconds: 1500), () {
      Loader.hide();
      customSnackBar(context, CupertinoIcons.check_mark_circled,
          "Your data has been calculated successfully", 4000,
          backgroundColor: Colors.black.withOpacity(0.8));
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ResultPage(result: _result)));
      });
    });
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
          widget.data.questions![currentQuestion].userAnswer = null;
          if (currentQuestion < widget.data.questions!.length - 1) {
            PrintLog().printSuccess("current question => $currentQuestion");
            currentQuestion++;
            _currentMilliseconds = 0;

            setState(() {});
          } else {
            timer.cancel();
            _calculateScore(context);
          }
        }
      }
    });
  }
}
