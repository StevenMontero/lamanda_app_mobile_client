import 'package:flutter/material.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';

class TextFieldForm extends StatelessWidget {
  final String? initialValue;
  final String? lavel;
  final IconData? icon;
  final TextInputType? inputType;
  final bool errorOccurred;
  final String errorMessage;
  final ValueChanged<String>? onChanged;

  TextFieldForm({
      this.initialValue,
      this.lavel,
      this.icon,
      this.inputType,
      this.onChanged,
      this.errorOccurred = false,
      this.errorMessage = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0),
      child: Container(
        height: 75.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              width: 2,
              color: ColorsApp.secondaryColorlightPurple),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.blue,
          ),
          child: TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            decoration: InputDecoration(
                errorText: errorOccurred ? errorMessage: null,
                labelText: lavel,
                icon: Icon(
                  icon,
                  color: Colors.black38,
                ),
                labelStyle: TextStyle(
                    fontSize: 13.0,
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}
