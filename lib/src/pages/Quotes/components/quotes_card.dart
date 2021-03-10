import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuotesCard extends StatelessWidget {
  final String? itemImg;
  final String? itemTitle;
  final Color? itemBgColor;
  final Color? itemTextColor;
  final Function? onPress;

  const QuotesCard(
      {Key? key,
      this.itemImg,
      this.itemTitle,
      this.itemBgColor,
      this.itemTextColor,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: double.infinity,
        height: 140,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 100,
                child: RaisedButton(
                  color: itemBgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: onPress as void Function()?,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      itemTitle!,
                      style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: itemTextColor,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: -2,
              child: Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  itemImg!,
                  height: 100,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
