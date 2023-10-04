import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share_me/share_me.dart';
import 'package:vquiz_app/src/components/custom_elevated_button.dart';

import 'package:vquiz_app/src/res/colors.dart';
import 'package:vquiz_app/src/res/dimens.dart';
import 'package:vquiz_app/src/res/styles.dart';

import 'package:vquiz_app/src/views/topics/models/result.dart';
import 'package:vquiz_app/src/views/topics/models/topic_model.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.result});
  final Result result;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    inspect(widget.result);
    super.initState();
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
                title: const Text("Your Score"),
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
                // shadowColor: _customColors.sliverAppShadowColor,
                floating: true,
                flexibleSpace: const FlexibleSpaceBar(),
                expandedHeight: 60,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  height: 200,
                  margin: PAD_ONLY_B5,
                  // color: Colors.yellow,
                  // padding: const EdgeInsets.all(15.0),
                  child: CircularPercentIndicator(
                    reverse: true,
                    radius: 80.0,
                    lineWidth: 10.0,
                    percent: widget.result.correctAnswer /
                        widget.result.questionLength,
                    animation: true,
                    center: SizedBox(
                      // width: 80,
                      // color: Colors.red,
                      child: Text(
                        "${widget.result.correctAnswer} / ${widget.result.questionLength}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    progressColor: successColor,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: dangerColor.withOpacity(0.6),
                    // fillColor: Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: CustomElevatedButton(
                      buttonColor: accentColor,
                      borderRadius: BorderRadius.circular(20),
                      onPressed: () {
                        ShareMe.system(
                          title: 'Quiz App - Beat my score',
                          url:
                              'https://www.linkedin.com/in/kevin-laurence-6a61bb113/',
                          description:
                              "Look! I got ${widget.result.correctAnswer} / ${widget.result.questionLength} on Quiz App, I dare you to try it!",
                          subject:
                              'This is a quiz app demo, developed with Flutter and Firebase firestore',
                        );
                      },
                      child: const Text("Share your score",
                          style: normalStyleWhite)),
                ),
                const SizedBox(height: 20),
                Text("Your Report",
                    textAlign: TextAlign.center,
                    style: boldStyle.apply(color: Colors.white)),
                const SizedBox(height: 10),
              ])),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  Questions item = widget.result.questions![index];
                  return Container(
                      padding: PAD_SYM_H20,
                      margin: PAD_ONLY_B20,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(item.question.toString(),
                              style: normalStyleWhite),
                          Row(
                            children: [
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Icon(
                                      item.answer == item.userAnswer
                                          ? Icons.check
                                          : Icons.close,
                                      color: item.answer == item.userAnswer
                                          ? successColor
                                          : dangerColor,
                                      size: 18),
                                  const SizedBox(width: 3),
                                  Text(
                                      item.userAnswer != null
                                          ? item
                                              .choices![item.choices!
                                                  .indexWhere((v) =>
                                                      v.choiceId ==
                                                      item.userAnswer)]
                                              .choice
                                              .toString()
                                          : "Not Answered",
                                      style: normalStyleWhite.apply(
                                          color: Colors.grey.shade300)),
                                ],
                              ),
                              item.answer != item.userAnswer
                                  ? Container(
                                      margin: PAD_ONLY_L10,
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          const Icon(Icons.check,
                                              color: successColor, size: 18),
                                          const SizedBox(width: 3),
                                          Text(
                                              item
                                                  .choices![item.choices!
                                                      .indexWhere((v) =>
                                                          v.choiceId ==
                                                          item.answer)]
                                                  .choice
                                                  .toString(),
                                              style: normalStyleWhite.apply(
                                                  color: Colors.grey.shade300)),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ));
                }, childCount: widget.result.questions!.length),
              )
            ],
          )
        ],
      ),
    );
  }
}
