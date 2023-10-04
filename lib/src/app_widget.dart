import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vquiz_app/src/res/colors.dart';
import 'package:vquiz_app/src/views/home/cubit/home_cubit.dart';
import 'package:vquiz_app/src/views/home/views/home_page.dart';
import 'package:vquiz_app/src/views/topics/cubit/topic_cubit.dart';

GlobalKey<ScaffoldMessengerState>? snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TopicCubit()),
        BlocProvider(create: (_) => HomeCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Quiz App',
        scaffoldMessengerKey: snackbarKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
