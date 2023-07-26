import 'package:flutter/material.dart';
import 'package:drip_plus/theme/pallete.dart';

class RoundedStretchButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;

  const RoundedStretchButton({
    super.key,
    required this.onTap,
    required this.label,
    this.isLoading = true,
    this.backgroundColor = Pallete.blueColor,
    this.textColor = Pallete.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          color: !isLoading ? backgroundColor : Pallete.anotherGreyColor,
        ),
        child: !isLoading
            ? Text(
                label,
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              )
            : CircularProgressIndicator(
                color: backgroundColor,
              ),
      ),
    );
  }
}
