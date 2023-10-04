import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:share_me/share_me.dart';
import 'package:vquiz_app/src/components/custom_elevated_button.dart';
import 'package:vquiz_app/src/res/colors.dart';
import 'package:vquiz_app/src/res/dimens.dart';
import 'package:vquiz_app/src/res/styles.dart';
import 'package:vquiz_app/src/services/utils/common_service.dart';
import 'package:vquiz_app/src/services/utils/print_log.dart';
import 'package:vquiz_app/src/views/home/cubit/home_cubit.dart';

import 'package:vquiz_app/src/views/topics/models/topic_model.dart';
import 'package:vquiz_app/src/views/topics/views/quiz_page.dart';
import 'package:vquiz_app/src/views/topics/views/topics_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TopicModel> _data = [];
  ImageProvider logo = const AssetImage("assets/images/app_logo.png");

  int generateRandomNumber() {
    final random = Random();
    return random.nextInt(_data.length);
  }

  void _getTopicList() {
    PrintLog().printPrimary("Home _getTopicList() initiated");
    context.read<HomeCubit>().getTopicList();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      callLoader(context);
    });
    _getTopicList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: primaryColor),
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeLoading) {
                PrintLog().printPrimary("Home State loading");
                callLoader(context);
              } else if (state is HomeError) {
                PrintLog()
                    .printError("Home State Error => ${state.error.message}");
              } else if (state is HomeListSuccess) {
                PrintLog().printSuccess("Home State success");

                _data = state.data;
                Loader.hide();
              }
            },
            builder: (context, state) {
              PrintLog().printWarning("HomeState => $state");
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    fillOverscroll: false,
                    hasScrollBody: false,
                    child: Padding(
                      padding: PAD_ASYM_H20_V10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 250,
                            width: 250,
                            child: Hero(
                              tag: 'appLogo',
                              child: Image(image: logo),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text("Flutter Quiz App",
                              style: titleStyleWhite),
                          const SizedBox(height: 10),
                          const Text("Learn . Take Quiz . Repeat",
                              style: normalStyleWhite),
                          const SizedBox(height: 50),
                          Padding(
                            padding: PAD_SYM_H40,
                            child: CustomElevatedButton(
                                buttonColor: accentColor,
                                borderRadius: BorderRadius.circular(20),
                                onPressed: _data.isNotEmpty
                                    ? () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => QuizPage(
                                                      data: _data[
                                                          generateRandomNumber()],
                                                    )));
                                      }
                                    : null,
                                child: const Text("PLAY",
                                    style: normalStyleWhite)),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: PAD_SYM_H40,
                            child: CustomElevatedButton(
                                buttonColor: Colors.transparent,
                                borderColor: accentColor,
                                borderRadius: BorderRadius.circular(20),
                                onPressed: _data.isNotEmpty
                                    ? () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => TopicPage(
                                                      data: _data,
                                                    )));
                                      }
                                    : null,
                                child: Text(
                                  "TOPICS",
                                  style: normalStyleWhite.apply(
                                      color: accentColor),
                                )),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: PAD_SYM_H40,
                            // color: Colors.red,
                            child: Row(
                              children: [
                                CustomElevatedButton(
                                  width: 130,
                                  buttonColor: Colors.transparent,
                                  borderColor: Colors.transparent,
                                  elevation: 0,
                                  borderRadius: BorderRadius.circular(20),
                                  onPressed: () async {
                                    ShareMe.system(
                                      title: 'Quiz App',
                                      url:
                                          'https://www.linkedin.com/in/kevin-laurence-6a61bb113/',
                                    );
                                  },
                                  child: const Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Icon(Icons.share_rounded,
                                          color: accentColor, size: 18),
                                      SizedBox(width: 3),
                                      Text("Share", style: normalStyleWhite),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                CustomElevatedButton(
                                  width: 130,
                                  buttonColor: Colors.transparent,
                                  borderColor: Colors.transparent,
                                  elevation: 0,
                                  borderRadius: BorderRadius.circular(20),
                                  onPressed: () {},
                                  child: const Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Icon(Icons.star_rounded,
                                          color: Colors.yellow, size: 20),
                                      SizedBox(width: 3),
                                      Text("Rate Us", style: normalStyleWhite),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
