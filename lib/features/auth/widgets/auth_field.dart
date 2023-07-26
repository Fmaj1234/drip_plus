import 'package:flutter/material.dart';
import 'package:drip_plus/theme/pallete.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icons;
  final TextInputType textInputType;
  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icons,
    this.textInputType = TextInputType.emailAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 55,
      decoration: BoxDecoration(
        color: Pallete.authLightBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Pallete.authDarkBackgroundColor.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icons, size: 27, color: Pallete.authDarkBackgroundColor),
          const SizedBox(width: 15),
          SizedBox(
            // margin: EdgeInsets..,
            width: 250,
            child: TextFormField(
              controller: controller,
              keyboardType: textInputType,
              obscureText: false,
              style: const TextStyle(color: Pallete.blackColor, fontSize: 18),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Pallete.greyColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
