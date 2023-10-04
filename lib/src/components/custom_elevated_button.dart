import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final double? elevation;
  final Gradient? gradient;
  final Color buttonColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final Widget child;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.elevation,
    this.gradient,
    this.buttonColor = Colors.white,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      width: width,
      height: height,
      decoration: BoxDecoration(
        /// If [gradient] is null then use default [buttonColor]
        ///
        color: gradient != null ? null : buttonColor,
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: borderColor != null
                ? BorderSide(
                    color: borderColor!,
                    width: 2,
                  )
                : BorderSide.none,
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Center(child: child)),
          ],
        ),
      ),
    );
  }
}
