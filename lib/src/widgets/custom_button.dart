import 'package:flutter/material.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.text,
      this.press,
      this.color = ColorsApp.primaryColorBlue})
      : super(key: key);
  final String? text;
  final Function? press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: color,
        disabledColor: Colors.grey,
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
