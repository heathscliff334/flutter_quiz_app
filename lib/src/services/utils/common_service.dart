import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:vquiz_app/src/app_widget.dart';
import 'package:vquiz_app/src/res/colors.dart';

void callLoader(BuildContext ctx) {
  Loader.show(ctx,
      isSafeAreaOverlay: false,
      isAppbarOverlay: true,
      isBottomBarOverlay: true,
      progressIndicator: const CircularProgressIndicator(
          backgroundColor: Colors.white, color: primaryColor),
      overlayColor: const Color(0x99E8EAF6).withOpacity(0.2));
}

// ? Custom snackbar
void customSnackBar(BuildContext? ctx, IconData icon, String msg, int duration,
    {Widget? widget,
    Color? backgroundColor,
    Color? textColor,
    bool overrideContext = false}) {
  snackbarKey!.currentState?.removeCurrentSnackBar();

  snackbarKey!.currentState?.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: duration),
      backgroundColor: backgroundColor ?? Colors.black.withOpacity(0.8),
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      content: Row(
        children: [
          Icon(
            icon,
            color: textColor ?? Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: widget ??
                Text(
                  msg.toString(),
                  style: TextStyle(color: textColor ?? Colors.white),
                ),
          ),
        ],
      )));
}
