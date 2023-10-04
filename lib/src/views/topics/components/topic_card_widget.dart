import 'package:flutter/material.dart';
import 'package:vquiz_app/src/extensions/str_extension.dart';
import 'package:vquiz_app/src/res/colors.dart';
import 'package:vquiz_app/src/res/dimens.dart';
import 'package:vquiz_app/src/res/styles.dart';
import 'package:vquiz_app/src/views/topics/models/topic_model.dart';
import 'package:vquiz_app/src/views/topics/views/quiz_page.dart';

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
        width: double.infinity,
        decoration: BoxDecoration(
            color: accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Text(data[idx].topicName.toString().toTitleCase(),
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
