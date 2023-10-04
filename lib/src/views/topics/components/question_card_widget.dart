import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vquiz_app/src/components/custom_elevated_button.dart';
import 'package:vquiz_app/src/extensions/str_extension.dart';
import 'package:vquiz_app/src/models/data.dart';
import 'package:vquiz_app/src/res/dimens.dart';
import 'package:vquiz_app/src/res/styles.dart';
import 'package:vquiz_app/src/views/topics/models/topic_model.dart';

class QuestionCardWidget extends StatelessWidget {
  const QuestionCardWidget({
    super.key,
    required this.data,
    required this.currentIndex,
    required this.onTap,
  });
  final List<Questions> data;
  final int currentIndex;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PAD_ALL_20,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
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
                          child: CachedNetworkImage(
                            imageUrl: data[currentIndex].image.toString(),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
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
                      onTap(int.parse(choice.value!));
                    },
                    child: Text(
                      choice.label.toString().toTitleCase(),
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
