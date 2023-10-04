import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:vquiz_app/src/res/colors.dart';

void callLoader(BuildContext ctx) {
  Loader.show(ctx,
      isSafeAreaOverlay: false,
      isAppbarOverlay: true,
      isBottomBarOverlay: true,
      progressIndicator: const CircularProgressIndicator(
          // strokeWidth: 10,
          backgroundColor: Colors.white,
          color: primaryColor),
      overlayColor: const Color(0x99E8EAF6).withOpacity(0.2));
}
